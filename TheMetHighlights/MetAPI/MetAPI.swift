import Dependencies
import Foundation
import UIKit

// The URLSession to be used for all calls
let session: URLSession = {
    let configuration = URLSessionConfiguration.default
    configuration.requestCachePolicy = .returnCacheDataElseLoad
    configuration.urlCache = URLCache(
        memoryCapacity: 10 * 1024 * 1024,
        diskCapacity: 50 * 1024 * 1024,
        diskPath: nil
    )

    return URLSession(configuration: configuration)
}()

struct MetAPI: Sendable {
    var departments: @Sendable () async -> [Department]
    var highlightedExhibits: @Sendable (Department.ID) async throws -> [Exhibit]
    var thumbnailImage: @Sendable (String) async -> UIImage?

}

// Live Values
extension MetAPI: DependencyKey {
    static let liveValue = MetAPI(
        departments: {
            do {
                let (data, _) = try await session.data(from: .departments)
                return try JSONDecoder().decode(DepartmentsResponse.self, from: data).departments
            } catch {
                return []
            }
        },
        highlightedExhibits: { departmentId in
            let departmentURL = URL.highlightedExhibits(departmentId)
            let (data, _) = try await session.data(from: departmentURL)
            let exhibitIDs = try JSONDecoder()
                .decode(HighlighedExhibitsIdResponse.self, from: data)
                .objectIDs

            return await withTaskGroup(of: (Int, Exhibit?).self) { group -> [Exhibit] in
                for (index, exId) in exhibitIDs.enumerated() {
                    group.addTask {
                        do {
                            let (data, _) = try await session.data(from: .exhibitInt(exId))
                            let exhibit = try JSONDecoder().decode(Exhibit.self, from: data)
                            return (index, exhibit)
                        } catch {
                            return (index, nil)
                        }
                    }
                }

                let enumeratedExhibits = await group.reduce(into: [(Int, Exhibit?)]()) { partialResult, value in
                    partialResult.append(value)
                }

                return enumeratedExhibits.sorted { $0.0 < $1.0 }
                    .compactMap { $0.1 }
                    .filter { exhibit in
                        guard let string = exhibit.smallImage else { return false }
                        return !string.isEmpty
                    }
            }
        },
        thumbnailImage: { string in
            guard let encodedString = string.addingPercentEncoding()
            else {
                return nil
            }
            guard let url = URL(string: encodedString),
                  let (imageData, _) = try? await session.data(from: url),
                  let image = UIImage(data: imageData)
            else {
                return nil
            }

            let resizeTask = Task.detached(priority: .userInitiated) {
                generateThumbnail(for:image, size: CGSize(width: 52, height: 52))
            }

            let resizedImage = await resizeTask.value

            return resizedImage
        }
    )
}

// Previews and Default Tests
extension MetAPI {
    static var preview = MetAPI(
        departments: {
            [
                Department(id: 1, name: "American Decorative Arts"),
                Department(id: 3, name: "Ancient Near Eastern Art"),
                Department(id: 4, name: "Arms and Armor"),
                Department(id: 5, name: "Arts of Africa, Oceania, and the Americas"),
                Department(id: 6, name: "Asian Art"),
                Department(id: 7, name: "The Cloisters"),
                Department(id: 8, name: "The Costume Institude"),
                Department(id: 9, name: "Drawings and Prints"),
                Department(id: 10, name: "Egyptian Art"),
                Department(id: 11, name: "European Paintings"),
                Department(id: 12, name: "European Sculpture and Decorative Arts"),
                Department(id: 13, name: "Greek and Roman Art"),
                Department(id: 14, name: "Islamic Art"),
                Department(id: 15, name: "The Robert Lehman Collection"),
                Department(id: 16, name: "The Libraries")
            ]
        },
        highlightedExhibits: { _ in
            [
                Exhibit.mock1,
                .mock2,
            ]
        },
        thumbnailImage: { _ in
            UIImage(named: "Thumbnail")
        }
    )
}

extension MetAPI: TestDependencyKey {
    static let previewValue = MetAPI.preview
    static let testValue = MetAPI.preview
}

extension DependencyValues {
    var metAPI: MetAPI {
        get { self[MetAPI.self] }
        set { self[MetAPI.self] = newValue }
    }
}

extension URL {
    static var departments: Self {
        URL(string: "https://collectionapi.metmuseum.org/public/collection/v1/departments")!
    }

    static func exhibitInt(_ id: Int) -> Self {
        URL(string: "https://collectionapi.metmuseum.org/public/collection/v1/objects/\(id)")!
    }

    static func highlightedExhibits(_ id: Department.ID) -> Self {
        var components = URLComponents(string: "https://collectionapi.metmuseum.org/public/collection/v1/search")!
        let queryItems = [
            URLQueryItem(name: "isHighlight", value: "true"),
            URLQueryItem(name: "departmentId", value: id.rawValue.description),
            URLQueryItem(name: "q", value: ""),
            URLQueryItem(name: "hasImages", value: "true")
        ]

        components.queryItems = queryItems
        return components.url!
    }
}

extension String {
    func addingPercentEncoding() -> String? {
        let unreserved = ":-._~/?"
        let allowed = NSMutableCharacterSet.alphanumeric()
        allowed.addCharacters(in: unreserved)
        return addingPercentEncoding(withAllowedCharacters: allowed as CharacterSet)
    }
}

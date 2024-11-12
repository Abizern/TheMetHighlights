import Dependencies
import Foundation

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
}

// Live Values
extension MetAPI {
    static let liveValue = MetAPI(
        departments: {
            do {
                let (data, _) = try await session.data(from: .departments)
                return try JSONDecoder().decode(DepartmentsResponse.self, from: data).departments
            } catch {
                return []
            }
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
        })
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
}

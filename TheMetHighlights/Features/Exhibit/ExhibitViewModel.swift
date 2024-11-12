import Dependencies
import SwiftUI
import UIKit

@Observable
@MainActor
final class ExhibitViewModel {
    let exhibit: Exhibit
    var image: FetchedImageView.FetchedImage = .none
    var title: String
    var artist: String
    var bio: String
    var department: String
    var medium: String


    @ObservationIgnored
    lazy var urlStringForImage: String? = {
        return [exhibit.image, exhibit.smallImage]
            .compactMap { $0 }
            .first
    }()

    func detailImage() -> UIImage? {
        if case let .success(image) = image {
            return image
        } else {
            return nil
        }
    }

    @ObservationIgnored
    @Dependency(\.metAPI) var metAPI

    init(_ exhibit: Exhibit) {
        self.exhibit = exhibit
        title = exhibit.title
        artist = Self.safeString(exhibit.artistName)
        bio = Self.safeString(exhibit.artistBio)
        department = exhibit.department
        medium = Self.safeString(exhibit.medium)
    }

    func fetchImage() async {
        guard detailImage() == nil else { return }

        guard let urlString = urlStringForImage else { return }
        self.image = .loading

        if let fetched = await self.metAPI.fetchImage(urlString) {
            self.image = .success(fetched)
        } else {
            self.image = .none
        }
    }
}

private extension ExhibitViewModel {
    static func safeString(_ string: String?) -> String {
        guard let value = string,
              !value.isEmpty
        else { return "Unknown" }
        return value
    }
}

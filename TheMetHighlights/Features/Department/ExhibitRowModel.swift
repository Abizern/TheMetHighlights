import Dependencies
import Foundation
import Tagged
import UIKit

@Observable
final class ExhibitRowModel: Identifiable {
    let id: Exhibit.ID
    var exhibit: Exhibit
    private(set) var fetchedImage: FetchedImageView.FetchedImage = .none

    init(_ exhibit: Exhibit) {
        self.exhibit = exhibit
        id = exhibit.id
    }

    func setFetchedImage(_ fetchedImage: FetchedImageView.FetchedImage) {
        self.fetchedImage = fetchedImage
    }
}

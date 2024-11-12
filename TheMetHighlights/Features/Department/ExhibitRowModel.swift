import Dependencies
import Foundation
import Tagged
import UIKit

@Observable
final class ExhibitRowModel: Identifiable {
    let id: Exhibit.ID

    private(set) var thumbnail: UIImage?
    var exhibit: Exhibit

    init(_ exhibit: Exhibit) {
        self.exhibit = exhibit
        id = exhibit.id
    }

    func addThumbnail(_ image: UIImage) {
        thumbnail = image
    }
}

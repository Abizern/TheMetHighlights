import Dependencies
import Foundation
import IdentifiedCollections
import UIKit

@Observable
final class ExhibitsListModel: ObservableObject {
    private(set) var exhibitRowModels = IdentifiedArrayOf<ExhibitRowModel>()

    @ObservationIgnored
    @Dependency(\.metAPI) var metAPI

    let department: Department
    let navigationTitle: String

    init(_ department: Department
    ) {
        self.department = department
        navigationTitle = department.name
    }

    func fetchExhibits() async {
        do {
            let exhibits = try await metAPI.highlightedExhibits(department.id)
            exhibitRowModels = IdentifiedArrayOf(uniqueElements: exhibits.map { ExhibitRowModel($0) })
        } catch {
            print(error)
            self.exhibitRowModels = []
        }
        for model in exhibitRowModels {
            let identifier = model.id
            guard let imagePath = model.exhibit.smallImage,
                  let thumbnail = await metAPI.thumbnailImage(imagePath)
            else {
                continue
            }
            exhibitRowModels[id: identifier]?.addThumbnail(thumbnail)
        }
    }
}


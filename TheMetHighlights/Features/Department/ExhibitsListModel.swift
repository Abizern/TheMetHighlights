import Dependencies
import Foundation
import IdentifiedCollections
import UIKit

@Observable
@MainActor
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

            guard let rowModel = exhibitRowModels[id: identifier],
                  let imagePath = model.exhibit.smallImage
            else {
                continue
            }
            rowModel.setFetchedImage(.loading)
            guard let thumbnail = await metAPI.thumbnailImage(imagePath)
            else {
                rowModel.setFetchedImage(.none)
                continue
            }
            rowModel.setFetchedImage(.success(thumbnail))
        }
    }
}


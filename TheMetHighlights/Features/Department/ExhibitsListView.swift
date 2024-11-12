import Dependencies
import SwiftUI

struct ExhibitsListView: View {
    var model: ExhibitsListModel

    var body: some View {
        List(model.exhibitRowModels) { rowModel in
            NavigationLink {
                ExhibitView(ExhibitViewModel(rowModel.exhibit))
            } label: {
                ExhibitRow(rowModel)
            }
        }
        .navigationTitle(model.navigationTitle)
        .navigationBarTitleDisplayMode(.inline)
        .task {
            await model.fetchExhibits()
        }
    }
}

#Preview {
    NavigationStack{
        ExhibitsListView(model: ExhibitsListModel(.mock))
    }
}

import Dependencies
import SwiftUI

struct DepartmentView: View {
    var model: ExhibitsListModel

    var body: some View {
        List {
            ForEach(model.exhibitRowModels) { rowModel in
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
        DepartmentView(model: ExhibitsListModel(.mock))
    }
}

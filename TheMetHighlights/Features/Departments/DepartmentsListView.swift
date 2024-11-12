import SwiftUI

struct DepartmentsListView: View {
    var model = DepartmentsListModel()

    var body: some View {
        List(model.departments) { department in
            NavigationLink {
                ExhibitsListView(model: ExhibitsListModel(department))
            } label: {
                DepartmentRow(department)
            }
        }
        .navigationTitle(model.navigationTitle)
        .task {
            await model.fetchDepartments()
        }
    }
}

#Preview {
    NavigationStack{
        DepartmentsListView()
    }

}

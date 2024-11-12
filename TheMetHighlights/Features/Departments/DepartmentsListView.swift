import SwiftUI

struct DepartmentsListView: View {
    var model = DepartmentsListModel()

    var body: some View {
        List {
            ForEach(model.departments) { department in
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

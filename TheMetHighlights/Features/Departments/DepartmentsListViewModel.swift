import Dependencies
import Foundation

@Observable
final class DepartmentsListModel {
     private(set) var departments: [Department]

    @ObservationIgnored
    @Dependency(\.metAPI) var metAPI

    let navigationTitle = "Departments"

    init(
        departments: [Department] = []
    ) {
        self.departments = departments
    }

    func departmentTapped(_ department: Department) {
    }

    func fetchDepartments() async {
        departments = await metAPI.departments()

    }
}

import Testing

@testable import TheMetHighlights

@Suite("DepartmentListModel Tests")
struct DepartmentsListModelTests {
    @Test("Initial state")
    func testInitialState () {
        let model = DepartmentsListModel()

        #expect(model.departments.isEmpty)
        #expect(model.navigationTitle == "Departments")
    }

    @Test("Departments are fetched")
    func testFetchDepartments () async {
        let model = DepartmentsListModel()

        await model.fetchDepartments()

        #expect(!model.departments.isEmpty)
    }
}


import Testing

@testable import TheMetHighlights

@Test("Initial state")
func testInitialState () {
    let model = DepartmentsListModel()

    #expect(model.departments.isEmpty)
    #expect(model.navigationTitle == "Departments")
}

@Test("Departs are fetched")
func testFetchDepartments () async {
    let model = DepartmentsListModel()
    
    await model.fetchDepartments()

    #expect(!model.departments.isEmpty)
}

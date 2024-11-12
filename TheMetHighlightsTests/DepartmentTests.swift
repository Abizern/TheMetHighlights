import Foundation
import Testing
@testable import TheMetHighlights

@Suite("Department Tests")
struct DepartmentTests {
    @Test("Test decoding a single Department")
    func decodeDepartment() throws  {
        let data = Fixtures.department
        let department = try JSONDecoder().decode(Department.self, from: data)
        #expect(department.id == 1)
        #expect(department.name == "American Decorative Arts")
    }

    @Test("Test decoding results of the departments endpoint")
    func decodeDepartmentns() throws {
        let data = Fixtures.departments
        let departments = try JSONDecoder().decode(DepartmentsResponse.self, from: data).departments
        #expect(departments.count == 19)
    }
}


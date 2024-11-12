import Foundation
import Testing

@testable import TheMetHighlights

@Suite("Endpooints used by the MetAPI")
struct MetAPITests {
    @Test("Departments endpoint")
    func testDepartmentEndpoint() {
        let departmentEndpoint = "https://collectionapi.metmuseum.org/public/collection/v1/departments"
        #expect(URL.departments.absoluteString == departmentEndpoint)
    }

    @Test("Highlighted Exhibits endpoint")
    func testHighlightedExhibitsEndpoint() {
        let departmentId = Department.mock.id
        let highlightedExhibitsEndpoint = "https://collectionapi.metmuseum.org/public/collection/v1/search?isHighlight=true&departmentId=1&q=&hasImages=true"

        #expect(URL.highlightedExhibits(departmentId).absoluteString == highlightedExhibitsEndpoint)
    }


    @Test("Exhibit endpoint") func testExhibitEndpoint() {
        let exhibitId = Exhibit.mock1.id.rawValue
        let exhibitEndpoint = "https://collectionapi.metmuseum.org/public/collection/v1/objects/\(exhibitId)"

        #expect(URL.exhibitInt(exhibitId).absoluteString == exhibitEndpoint)
    }

}

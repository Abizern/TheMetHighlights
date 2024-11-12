import Foundation
import Testing

@testable import TheMetHighlights

@Suite("Exhibits Tests")
struct ExhibitsTests {
    @Test("Test decoding a single exhibit")
    func testDecodeExhibit() throws {
        let data = Fixtures.exhibit
        let exhibit = try JSONDecoder().decode(Exhibit.self, from: data)

        #expect(exhibit.id.rawValue == 10956)
        #expect(exhibit.image == "https://images.metmuseum.org/CRDImages/ad/original/DP162116.jpg")
        #expect(exhibit.smallImage == "https://images.metmuseum.org/CRDImages/ad/web-large/DP162116.jpg")
        #expect(exhibit.department == "The American Wing")
        #expect(exhibit.title == "Gilbert Stuart")
        #expect(exhibit.artistName == "Sarah Goodridge")
        #expect(exhibit.artistBio == "1788–1853")
        #expect(exhibit.medium == "Watercolor on ivory")
    }

    @Test("Test decoding the results of a call to get highlighteed exhibits for a department")
    func testDecodeExhibitsList() throws {
        let data = Fixtures.exhibits
        let exhibits = try JSONDecoder().decode(HighlighedExhibitsIdResponse.self, from: data).objectIDs

        #expect(exhibits.count == 132)
    }

    @Test("Decoding the results of an API call")
    func testHighlightedExhibitsEndpoint() {
        let departmentId = Department.mock.id
        let highlightedExhibitsEndpoint = "https://collectionapi.metmuseum.org/public/collection/v1/search?isHighlight=true&departmentId=1&q=&hasImages=true"

        #expect(URL.highlightedExhibits(departmentId).absoluteString == highlightedExhibitsEndpoint)
    }
}


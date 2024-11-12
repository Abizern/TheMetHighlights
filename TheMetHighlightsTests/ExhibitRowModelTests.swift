import Testing

@testable import TheMetHighlights

@MainActor
@Suite("ExhibitRowModel Tests")
struct ExhibitRowModelTests {
    @Test("Initial state")
    func testInitialState() {
        let model = ExhibitRowModel(.mock1)

        #expect(model.id == Exhibit.mock1.id)
        #expect(model.exhibit == .mock1)
        #expect(model.thumbnail == nil)

    }

    @Test("Add a thumbnail image")
    func testAddThumbnailImage() async {
        let model = ExhibitRowModel(.mock1)
        let thumbnail = Fixtures.thumbnail
        model.addThumbnail(thumbnail)

        #expect(model.id == Exhibit.mock1.id)
        #expect(model.exhibit == .mock1)
        #expect(model.thumbnail == thumbnail)

    }
}

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
        #expect(model.fetchedImage == .none)

    }

    @Test("Add a thumbnail image")
    func testAddThumbnailImage() async {
        let model = ExhibitRowModel(.mock1)
        let thumbnail = Fixtures.thumbnail
        model.setFetchedImage(.success(thumbnail))

        #expect(model.id == Exhibit.mock1.id)
        #expect(model.exhibit == .mock1)
        var successfullFetch = false
        if case FetchedImageView.FetchedImage.success(_) = model.fetchedImage {
            successfullFetch = true
        }
        #expect(successfullFetch)
    }
}

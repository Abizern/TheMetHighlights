import Testing

@testable import TheMetHighlights

@MainActor
@Suite("ExhibitListModel Tests")
struct ExhibitListModelTests {
    @Test("Initial state")
    func testInitialState() {
        let model = ExhibitsListModel(.mock)

        #expect(model.exhibitRowModels.isEmpty)
        #expect(model.department == .mock)
        #expect(model.navigationTitle == Department.mock.name)
    }

    @Test("Fetching exhibits for a department")
    func testFetchExhibits() async {
        let model = ExhibitsListModel(.mock)
        await model.fetchExhibits()

        #expect(model.exhibitRowModels.count == 2)
        #expect(model.exhibitRowModels.compactMap(\.thumbnail).count == 2)
    }
}

import Dependencies
import Testing
import UIKit

@testable import TheMetHighlights

@MainActor
@Suite("ExhibitViewModel Tests")
struct ExhibitViewModelTests {
    @Test("Initial state")
    func testInitialState() {
        let model = ExhibitViewModel(.mock1)

        #expect(model.image == FetchedImageView.FetchedImage.none)
        #expect(model.exhibit == .mock1)
    }

    @Test("Fetches exhibit.image by default")
    func testFetchesExhibitImageByDefault() async {
        let exhibit = Exhibit(
            id: 44818,
            image: "first",
            smallImage: "second",
            department: "Asian Art",
            title: "Rough Waves",
            artistName: "Kunz Lochner",
            artistBio: "Japanese, 1658–1716",
            medium: "Two-panel folding screen; ink, color, and gold leaf on paper"
        )
        let model = ExhibitViewModel(exhibit)

        #expect(model.urlStringForImage == "first")
    }

    @Test("Fetches exhibit.smallImage if no large image")
    func testFetchesSmallImageIfItMust() async {
        let exhibit = Exhibit(
            id: 44818,
            image: nil,
            smallImage: "second",
            department: "Asian Art",
            title: "Rough Waves",
            artistName: "Kunz Lochner",
            artistBio: "Japanese, 1658–1716",
            medium: "Two-panel folding screen; ink, color, and gold leaf on paper"
        )
        let model = ExhibitViewModel(exhibit)

        #expect(model.urlStringForImage == "second")
    }

    @Test("Returns nil if no image available")
    func testReturnsNilIfNoImage() async {
        let exhibit = Exhibit(
            id: 44818,
            image: nil,
            smallImage: nil,
            department: "Asian Art",
            title: "Rough Waves",
            artistName: "Kunz Lochner",
            artistBio: "Japanese, 1658–1716",
            medium: "Two-panel folding screen; ink, color, and gold leaf on paper"
        )
        let model = ExhibitViewModel(exhibit)

        #expect(model.urlStringForImage == nil)
    }
}

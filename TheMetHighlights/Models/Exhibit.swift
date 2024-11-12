import Foundation
import Tagged

struct Exhibit: Equatable, Decodable, Identifiable {
    let id: ID
    let image: String?
    let smallImage: String?
    let department: String
    let title: String
    let artistName: String?
    let artistBio: String?
    let medium: String?
    typealias ID = Tagged<Self, Int>

    enum CodingKeys: String, CodingKey {
        case id = "objectID"
        case image = "primaryImage"
        case smallImage = "primaryImageSmall"
        case department = "department"
        case title = "title"
        case artistName = "artistDisplayName"
        case artistBio = "artistDisplayBio"
        case medium = "medium"
    }
}

extension Exhibit {
    static var mock1: Self {
        .init(
            id: 44818,
            image: "https://images.metmuseum.org/CRDImages/as/original/DT1615.jpg",
            smallImage: "https://images.metmuseum.org/CRDImages/as/web-large/DT1615.jpg",
            department: "Asian Art",
            title: "Rough Waves",
            artistName: "Kunz Lochner",
            artistBio: "Japanese, 1658–1716",
            medium: "Two-panel folding screen; ink, color, and gold leaf on paper"
        )
    }

    static var mock2: Self {
        .init(
            id: 44819,
            image: "https://images.metmuseum.org/CRDImages/as/original/DT1615.jpg",
            smallImage: "https://images.metmuseum.org/CRDImages/as/web-large/DT1615.jpg",
            department: "Asian Art",
            title: "Copy of Rough Waves",
            artistName: "Kunz Lochner",
            artistBio: "Japanese, 1658–1716",
            medium: "Two-panel folding screen; ink, color, and gold leaf on paper"
        )
    }
}


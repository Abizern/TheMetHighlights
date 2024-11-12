import Foundation
import Tagged

struct Department: Equatable, Decodable, Identifiable {
    let id: ID
    let name: String
    typealias ID = Tagged<Self,Int>

    enum CodingKeys: String, CodingKey {
        case id = "departmentId"
        case name = "displayName"
    }
}

extension Department {
    static var mock: Self {
        .init(id: 1, name: "American Decorative Arts")
    }
}

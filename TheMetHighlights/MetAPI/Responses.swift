import Foundation

struct DepartmentsResponse: Decodable {
    let departments: [Department]
}

struct HighlighedExhibitsIdResponse: Decodable {
    let objectIDs: [Int]
}

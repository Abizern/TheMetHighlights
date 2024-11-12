import Foundation

private class BundleClass: AnyObject {}

enum Fixtures {
    class BundleClass {}
    static func loadJson(_ name: String) -> Data {
        let bundle = Bundle(for: BundleClass.self)
        guard let url = bundle.url(forResource: name, withExtension: "json")
        else {
            fatalError("Cannot find \(name).json in this bundle.")
        }

        return try! Data(contentsOf: url)
    }

    static var exhibit: Data {
        loadJson("Exhibit")
    }

    static var exhibits: Data {
        loadJson("Exhibits")
    }
    static var department: Data {
        loadJson("Department")
    }

    static var departments: Data {
        loadJson("Departments")
    }
}

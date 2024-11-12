import Foundation
import UIKit

private class BundleClass: AnyObject {}

enum Fixtures {
    static var department: Data {
        loadJson("Department")
    }

    static var departments: Data {
        loadJson("Departments")
    }

    static var exhibit: Data {
        loadJson("Exhibit")
    }

    static var exhibits: Data {
        loadJson("Exhibits")
    }

    static var image: UIImage {
        loadImage("Image")
    }

    static var thumbnail: UIImage {
        loadImage("Thumbnail")
    }
}

extension Fixtures {
    static func loadJson(_ name: String) -> Data {
        let bundle = Bundle(for: BundleClass.self)
        guard let url = bundle.url(forResource: name, withExtension: "json")
        else {
            fatalError("Cannot find \(name).json in this bundle.")
        }

        return try! Data(contentsOf: url)
    }

    static func loadImage(_ name: String) -> UIImage {
        let bundle = Bundle(for: BundleClass.self)
        guard let image = UIImage(named: name, in: bundle, compatibleWith: nil)
        else {
            fatalError("Cannot find image named \(name) in the test asset catalog.")
        }
        return image
    }
}

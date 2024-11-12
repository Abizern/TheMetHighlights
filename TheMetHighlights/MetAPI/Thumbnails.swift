import func AVFoundation.AVMakeRect
import UIKit

func generateThumbnail(for image: UIImage, size: CGSize) -> UIImage {
    let rect = AVMakeRect(
        aspectRatio: image.size,
        insideRect: CGRect(
            origin: .zero,
            size: size
        )
    )

    let renderer = UIGraphicsImageRenderer(size: size)
    return renderer.image { context in
        image.draw(in: rect)
    }
}

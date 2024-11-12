import SwiftUI
import UIKit

struct ImageDetailView: View {
    @Environment(\.dismiss) var dismiss
    @State private var currentMagnification = 0.0
    @State private var totalMagnification = 1.0

    let image: UIImage?

    init(image: UIImage?) {
        self.image = image
    }
    var body: some View {
        if let image {
            Image(uiImage: image)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .scaleEffect(currentMagnification + totalMagnification)
                .gesture(
                    MagnifyGesture()
                        .onChanged { value in
                            currentMagnification = value.magnification - 1
                        }
                        .onEnded { _ in
                            totalMagnification += currentMagnification
                            currentMagnification = 0
                        }
                )
        } else {
            Text("No image available")
                .font(.largeTitle)
        }

    }
}

#Preview {
    ImageDetailView(image: UIImage(named: "Image"))
}

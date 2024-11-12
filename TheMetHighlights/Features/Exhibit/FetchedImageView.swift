import SwiftUI



struct FetchedImageView: View {
    enum FetchedImage: Equatable {
        case loading
        case none
        case success(UIImage)
    }

    let fetchedImage: FetchedImage
    let isThumbnail: Bool

    init(
        _ image: FetchedImage,
        isThumbnail: Bool = true
    ) {
        fetchedImage = image
        self.isThumbnail = isThumbnail
    }

    var body: some View {
        switch fetchedImage {
        case .loading:
            ZStack {
                Rectangle()
                    .fill(.windowBackground)
                    .border(.tertiary, width: 1)
                    .scaledToFit()
                ProgressView()
                    .scaleEffect(isThumbnail ? 1 : 2)
            }
        case .none:
            ZStack {
                Rectangle()
                    .fill(.tertiary)
                    .scaledToFit()
                Image(systemName: "photo")
                    .foregroundStyle(.secondary)
                    .scaleEffect(isThumbnail ? 1 : 2)
            }
        case .success(let image):
            Image(uiImage: image)
                .resizable()
                .scaledToFit()
        }
    }
}

#Preview {
    FetchedImageView(.loading)
        .frame(width: 100 , height: 100)
    FetchedImageView(.none)
        .frame(width: 100 , height: 100)
    FetchedImageView(.success(UIImage(named: "Image")!))
}

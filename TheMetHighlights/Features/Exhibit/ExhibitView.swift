import SwiftUI

struct ExhibitView: View {
    let model: ExhibitViewModel

    init(_ model: ExhibitViewModel) {
        self.model = model
    }

    var body: some View {
        ScrollView(.vertical) {
            VStack {
                NavigationLink {
                    ImageDetailView(image: model.detailImage())
                } label: {
                    FetchedImageView(model.image, isThumbnail: false)
                }
                .padding()

                Text(model.exhibit.title)
                    .font(.largeTitle)
                    .padding()

                Group {
                    Label(model.artist, systemImage: "person")
                        .font(.headline)
                    Label(model.bio, systemImage: "info.circle")
                        .font(.headline)
                    Label(model.department, systemImage: "building.columns")
                    Label(model.medium, systemImage: "paintpalette")
                }
                .frame(maxWidth: .infinity, alignment: .leading)

            }
            .padding()
        }
        .task {
            await self.model.fetchImage()
        }
    }
}

#Preview {
    ExhibitView(ExhibitViewModel(.mock1))
}

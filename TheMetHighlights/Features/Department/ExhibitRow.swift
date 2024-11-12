import SwiftUI

struct ExhibitRow: View {
    var model: ExhibitRowModel

    init(_ model: ExhibitRowModel) {
        self.model = model
    }
    var body: some View {
        ZStack {
            HStack(alignment: .center) {
                FetchedImageView(model.fetchedImage, isThumbnail: true)
                    .frame(width: 52, height: 52)
                    .cornerRadius(5)
                    .padding()
                VStack(alignment: .leading) {
                    Text(model.exhibit.title)
                        .font(.title2)
                    Text(model.exhibit.artistName ?? "Unknown artist")
                }
                .padding(.vertical)
                Spacer()
            }
            .frame(maxWidth: .infinity)
        }
    }
}

#Preview {
    List {
        ExhibitRow(ExhibitRowModel(.mock1))
    }
}

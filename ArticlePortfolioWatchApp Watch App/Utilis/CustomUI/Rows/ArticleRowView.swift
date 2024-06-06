import SwiftUI
import Kingfisher

struct ArticleRowView: View {
    
    var article: ArticleDto
    var screenSize: CGSize
    var isFavourite: Bool
    var onTapRow: () -> ()
    
    var body: some View {
        Button {
            onTapRow()
        } label: {
            VStack(alignment: .leading, spacing: 8) {
                KFImage(article.imageUrl)
                    .resizable()
                    .fade(duration: 0.35)
                    .backgroundDecode()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: screenSize.width * 0.8,
                           height: 80)
                    .clipShape(
                        RoundedRectangle(cornerRadius: 8)
                    )
                    .padding(.top, 8)
                Text(article.title ?? "")
                    .lineLimit(3)
                    .font(.caption)
                if isFavourite {
                    HStack {
                        Image(systemName: "heart.fill")
                        Spacer()
                    }
                }
            }
            .padding()
            .frame(maxWidth: .infinity, alignment: .leading)
        }
    }
}

#Preview {
    ArticleRowView(article: .mock, 
                   screenSize: .init(width: 393, height: 750),
                   isFavourite: false,
                   onTapRow: {})
}

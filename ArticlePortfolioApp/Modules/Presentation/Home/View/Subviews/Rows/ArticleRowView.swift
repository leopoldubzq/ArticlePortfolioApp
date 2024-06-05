import SwiftUI
import Kingfisher

struct ArticleRowView: View {
    
    var article: ArticleDto
    var onTapRow: VoidCallback
    
    init(article: ArticleDto, onTapRow: @escaping VoidCallback) {
        self.article = article
        self.onTapRow = onTapRow
    }
    
    private var defaultImageSize: CGSize = .init(width: 200, height: 200)
    
    var body: some View {
        Button { onTapRow() } label: {
            VStack(alignment: .leading) {
                KFImage(article.imageUrl)
                    .resizable()
                    .fade(duration: 0.35)
                    .backgroundDecode()
                    .setProcessor(
                        ResizingImageProcessor(referenceSize: defaultImageSize, mode: .aspectFill)
                    )
                    .aspectRatio(contentMode: .fill)
                    .frame(height: 180)
                    .clipShape(
                        RoundedRectangle(cornerRadius: 8)
                    )
                    
                Text(article.title ?? "")
                    .font(.system(size: 18, weight: .bold))
                    .multilineTextAlignment(.leading)
                    
            }
            .padding([.horizontal, .top])
            .frame(maxWidth: .infinity,
                   alignment: .leading)
            
        }
        .buttonStyle(ScalableButtonStyle())
        .tint(.primary)
    }
}

#Preview {
    ArticleRowView(article: .mock) {}
}

import SwiftUI
import Kingfisher

struct ArticleRowView: View {
    
    var article: any ArticleModelProtocol
    var isFavourite: Bool
    var onTapRow: VoidCallback
    var onTapHeart: VoidCallback?
    var onTapTrash: VoidCallback?
    @Environment(\.modelContext) private var modelContext
    
    init(article: any ArticleModelProtocol,
         isFavourite: Bool = false,
         onTapHeart: VoidCallback? = nil,
         onTapTrash: VoidCallback? = nil,
         onTapRow: @escaping VoidCallback) {
        self.article = article
        self.isFavourite = isFavourite
        self.onTapHeart = onTapHeart
        self.onTapTrash = onTapTrash
        self.onTapRow = onTapRow
    }
    
    private var defaultImageSize: CGSize = .init(width: 200, height: 200)
    
    var body: some View {
        Button { onTapRow() } label: {
            VStack(alignment: .leading) {
                if let _ = article as? ArticleSwiftDataModel {
                    HStack {
                        Spacer()
                        Menu {
                            Button("Remove from favourites", role: .destructive) {
                                onTapTrash?()
                            }
                        } label: {
                            Image(systemName: "ellipsis")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 18, height: 18)
                        }
                        .tint(.primary)
                        .fontWeight(.semibold)
                        .frame(maxHeight: .infinity)
                    }
                    .frame(height: 35)
                }
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
                if let _ = article as? ArticleDto {
                    HStack {
                        Group {
                            Button { onTapHeart?() } label: {
                                Image(systemName: isFavourite ? "heart.fill" : "heart")
                                    .contentTransition(.symbolEffect(.replace))
                            }
                            .tint(.primary)
                            Button {
                                
                            } label: {
                                Image(systemName: "trash")
                            }
                            .tint(.primary)
                        }
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                    }
                    .frame(height: 25)
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 8)
                    .background(
                        Capsule()
                            .fill(Color.init(uiColor: .secondarySystemBackground))
                    )
                }
            }
            .padding([.horizontal, .top])
            .frame(maxWidth: .infinity,
                   alignment: .leading)
            
        }
        .buttonStyle(ScalableButtonStyle())
        .tint(.primary)
        .scrollTransition { content, phase in
            content
                .scaleEffect(phase.isIdentity ? 1 : 0.94)
                .opacity(phase.isIdentity ? 1 : 0.4)
                .blur(radius: phase.isIdentity ? 0 : 1)
        }
    }
}

#Preview {
    ArticleRowView(article: ArticleDto.mock, isFavourite: true) {}
}

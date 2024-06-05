import SwiftUI
import Kingfisher

struct ArticleDetailScreen<ViewModel: ArticleDetail.ViewModel>: View {
    
    //MARK: - PRIVATE PROPERTIES
    @Environment(\.articleDetailRouter) private var router: ArticleDetailRouterLogic
    @StateObject private var viewModel: ViewModel
    @State private var scrollOffsetY: CGFloat = .zero
    @State private var isBarHidden = false
    
    init(viewModel: ViewModel) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }
    
    //MARK: - VIEW BODY
    var body: some View {
        GeometryReader { proxy in
            HiddenNavBarView {
                OffsetObservingScrollView(offset: $scrollOffsetY) {
                    VStack(spacing: 20) {
                        if let imageUrl = viewModel.articleModel.imageUrl {
                            ArticleImage(url: imageUrl)
                        }
                        Text(viewModel.articleModel.description ?? "")
                            .padding(.horizontal)
                        Spacer()
                    }
                    .frame(maxWidth: .infinity)
                    
                }
                .overlay(alignment: .top) {
                    BlurView()
                        .frame(height: proxy.safeAreaInsets.top + 50)
                    
                        .ignoresSafeArea()
                        .overlay(alignment: .bottom) {
                            Text("Article")
                                .padding(.vertical)
                                .foregroundStyle(.white)
                                .fontWeight(.semibold)
                                .font(.title3)
                                .opacity(-scrollOffsetY * 0.03)
                        }
                        .opacity(-scrollOffsetY * 0.01)
                        .overlay(alignment: .bottomLeading) {
                            BackButton()
                                .padding(.bottom, 3)
                        }
                }
                .ignoresSafeArea()
            }
        }
    }
    
    @ViewBuilder
    private func ArticleImage(url: URL) -> some View {
        GeometryReader { proxy in
            KFImage(url)
                .resizable()
                .fade(duration: 0.35)
                .scaledToFill()
                .frame(width: proxy.size.width,
                       height: proxy.size.height + max(0, scrollOffsetY))
                .clipShape(
                    UnevenRoundedRectangle(
                        cornerRadii: .init(
                            bottomLeading: 8,
                            bottomTrailing: 8
                        )
                    )
                )
                .offset(y: min(0, -scrollOffsetY))
        }
        .frame(height: 450)
    }
    
    @ViewBuilder
    private func BackButton() -> some View {
        Button { router.navigate(.back) } label: {
            Image(systemName: "chevron.left")
                .padding(15)
                .background(
                    Circle()
                        .fill(Color.customDarkGray)
                        .opacity(1 - -scrollOffsetY * 0.03)
                )
                .foregroundStyle(.white)
                .fontWeight(.semibold)
                .scaleEffect(1 + min(0.2, max(0, -scrollOffsetY * 0.005)))
        }
        .padding(.leading, 16)
        .padding(.top, 8)
        .offset(x: max(-8, min(0, scrollOffsetY * 0.05)))
    }
}

//MARK: - PREVIEW
#Preview {
    ArticleDetailScreen(
        viewModel: ArticleDetailViewModel(articleData: .mock)
    )
}

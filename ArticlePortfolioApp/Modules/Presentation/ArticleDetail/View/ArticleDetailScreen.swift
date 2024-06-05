import SwiftUI
import Kingfisher
import SwiftData

struct ArticleDetailScreen<ViewModel: ArticleDetail.ViewModel>: View {
    
    //MARK: - PRIVATE PROPERTIES
    @Environment(\.articleDetailRouter) private var router: ArticleDetailRouterLogic
    @StateObject private var viewModel: ViewModel
    @State private var scrollOffsetY: CGFloat = .zero
    @State private var isBarHidden = false
    @Environment(\.modelContext) private var modelContext
    @Query private var favouriteArticles: [ArticleSwiftDataModel]
    
    init(viewModel: ViewModel) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }
    
    //MARK: - VIEW BODY
    var body: some View {
        GeometryReader { proxy in
            HiddenNavBarView {
                OffsetObservingScrollView(offset: $scrollOffsetY) {
                    VStack(spacing: 20) {
                        ArticleImage(url: viewModel.articleModel.imageUrl)
                        Text(viewModel.articleModel.articleDescription ?? "")
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
                                .padding(.bottom)
                                .foregroundStyle(.white)
                                .fontWeight(.semibold)
                                .font(.title3)
                                .opacity(-scrollOffsetY * 0.03)
                        }
                        .opacity(-scrollOffsetY * 0.01)
                        .overlay(alignment: .bottom) {
                            HStack {
                                BackButton()
                                Spacer()
                                Button { 
                                    viewModel.updateFavouriteState(with: modelContext)
                                } label: {
                                    Image(systemName: isFavourite() ? "heart.fill" : "heart")
                                        .resizable()
                                        .contentTransition(.symbolEffect(.replace))
                                        .aspectRatio(contentMode: .fit)
                                        .frame(width: 20, height: 20)
                                }
                                .tint(.white)
                            }
                            .frame(maxWidth: .infinity)
                            .padding(.horizontal)
                            .padding(.bottom, 4)
                        }
                }
                .ignoresSafeArea()
            }
        }
        .onLoad {
            viewModel.fetchFavouriteArticlesFromDB(with: modelContext)
        }
    }
    
    @ViewBuilder
    private func ArticleImage(url: URL?) -> some View {
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
                .overlay(alignment: .top) {
                    Rectangle()
                        .fill(
                            .linearGradient(colors: [
                                Color(uiColor: .systemBackground).opacity(0.7),
                                Color(uiColor: .systemBackground).opacity(0.6),
                                Color(uiColor: .systemBackground).opacity(0.5),
                                Color(uiColor: .systemBackground).opacity(0.2),
                                Color(uiColor: .systemBackground).opacity(0.1),
                                Color(uiColor: .systemBackground).opacity(0.05),
                                Color(uiColor: .systemBackground).opacity(0.01)
                            ], startPoint: .top, endPoint: .center)
                        )
                }
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
        .offset(x: max(-8, min(0, scrollOffsetY * 0.05)))
    }
    
    private func getFavouriteArticle() -> ArticleSwiftDataModel? {
        favouriteArticles.first { article in
            guard let model = viewModel.articleModel as? ArticleDto else {
                return false
            }
            return article.checkIfFavourite(modelToCompare: model)
        }
    }
    
    private func isFavourite() -> Bool {
        getFavouriteArticle() != nil
    }
}

//MARK: - PREVIEW
#Preview {
    ArticleDetailScreen(
        viewModel: ArticleDetailViewModel(articleData: ArticleDto.mock)
    )
}

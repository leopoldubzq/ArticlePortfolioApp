import XCTest
@testable import ArticlePortfolioApp
import Combine
import Moya

final class HomeViewModelTests: XCTestCase {
    
    var sut: HomeViewModel!
    var cancellables: Set<AnyCancellable>!

    override func setUp() {
        super.setUp()
        cancellables = []
    }
    
    override func tearDown() {
        sut = nil
        cancellables = nil
        super.tearDown()
    }
    
    func initializeSutWithStatusCode(statusCode: StatusCode) {
        sut = HomeViewModel(homeDomainManager: HomeDomainManager(statusCode: statusCode))
    }
    
    func testArticlesSuccessNotEmpty() {
        //Given
        initializeSutWithStatusCode(statusCode: .ok)
        
        //When
        sut.fetchArticles()
        
        //Then
        let expectation = expectation(description: #function)
        
        sut.$articles
            .dropFirst()
            .sink { _ in
                expectation.fulfill()
            }
            .store(in: &cancellables)
        
        waitForExpectations(timeout: 5.0)
        XCTAssertEqual(sut.articles.isEmpty, false)
    }
    
    func testEmptyArticlesFailure() {
        // Given
        initializeSutWithStatusCode(statusCode: .internalServerError)
        
        //When
        sut.fetchArticles()
        
        //Then
        let expectation = expectation(description: #function)
        
        sut.$articles
            .dropFirst()
            .sink { _ in
                expectation.fulfill()
            }
            .store(in: &cancellables)
        
        waitForExpectations(timeout: 5.0)
        XCTAssertEqual(sut.articles.isEmpty, true)
    }
    
    func testSearchPhrase() {
        //Given
        initializeSutWithStatusCode(statusCode: .ok)
        
        //When
        sut.searchPhrase = TestSearchPhrases.apple.rawValue
        
        //Then
        let expectation = expectation(description: #function)
        
        sut.$articles
            .dropFirst()
            .sink { _ in
                expectation.fulfill()
            }
            .store(in: &cancellables)
        
        waitForExpectations(timeout: 5.0)
        XCTAssertEqual(sut.articles.isEmpty, false)
    }
    
    func testEmptySearchPhrase() {
        //Given
        initializeSutWithStatusCode(statusCode: .ok)
        
        //When
        sut.searchPhrase = TestSearchPhrases.apple.rawValue
        sut.searchPhrase = ""
        
        //Then
        let expectation = expectation(description: #function)
        
        sut.$articles
            .dropFirst()
            .sink { _ in
                expectation.fulfill()
            }
            .store(in: &cancellables)
        
        waitForExpectations(timeout: 5.0)
        XCTAssertEqual(sut.articles.isEmpty, false)
    }
    
    func testSearchPhraseWithFailureServiceProvider() {
        //Given
        initializeSutWithStatusCode(statusCode: .internalServerError)
        
        //When
        sut.searchPhrase = TestSearchPhrases.apple.rawValue
        
        //Then
        let expectation = expectation(description: #function)
        
        sut.$articles
            .dropFirst()
            .sink { _ in
                expectation.fulfill()
            }
            .store(in: &cancellables)
        
        waitForExpectations(timeout: 5.0)
        XCTAssertEqual(sut.articles.isEmpty, true)
    }
}

import XCTest
@testable import ArticlePortfolioApp
import Combine
import Moya

final class EverythingServerTests: XCTestCase {
    
    var cancellables: Set<AnyCancellable>!
    var everythingServer: EverythingServer!
    var searchPhrase: String!
    var errorStatusCode: Int!
    
    override func tearDown() {
        cancellables = nil
        everythingServer = nil
        searchPhrase = nil
        errorStatusCode = nil
        super.tearDown()
    }
    
    override func setUp() {
        super.setUp()
        cancellables = []
    }
    
    private func initializeServerWithStatusCode(_ statusCode: StatusCode) {
        everythingServer = EverythingServer(provider: .getMockProvider(withStatusCode: statusCode))
    }
    
    func testFetchArticlesFailure() {
        
        //Given
        initializeServerWithStatusCode(.internalServerError)
        
        //When
        errorStatusCode = nil
        searchPhrase = TestSearchPhrases.apple.rawValue
        
        //Then
        let expectation = expectation(description: #function)
        
        everythingServer
            .fetchArticles(withQuery: TestSearchPhrases.apple.rawValue)
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { [weak self] result in
                if case .failure(let error) = result {
                    self?.errorStatusCode = error.response?.statusCode
                    expectation.fulfill()
                } else {
                    XCTFail("Expected failure, got success")
                }
            }, receiveValue: { _ in })
            .store(in: &cancellables)
        
        waitForExpectations(timeout: 5)
        XCTAssertNotNil(errorStatusCode)
        XCTAssertEqual(errorStatusCode, 500)
    }
    
    func testFetchArticlesSuccess() {
        
        //Given
        initializeServerWithStatusCode(.ok)
        
        //When
        searchPhrase = TestSearchPhrases.apple.rawValue
        errorStatusCode = nil
        
        //Then
        let expectation = expectation(description: #function)
        
        everythingServer
            .fetchArticles(withQuery: TestSearchPhrases.apple.rawValue)
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { [weak self] result in
                if case .failure(let error) = result {
                    self?.errorStatusCode = error.response?.statusCode
                    XCTFail("Expected success, got failure")
                }
                expectation.fulfill()
            }, receiveValue: { _ in })
            .store(in: &cancellables)
        
        waitForExpectations(timeout: 5)
        XCTAssertEqual(errorStatusCode, nil)
    }

    
}

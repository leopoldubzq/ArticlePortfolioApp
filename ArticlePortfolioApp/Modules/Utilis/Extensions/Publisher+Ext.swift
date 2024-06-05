import Combine
import Foundation

extension Publisher {
    func handleLoadingEvents(with viewModel: BaseViewModel) -> Publishers.HandleEvents<Self> {
        return self.handleEvents(receiveSubscription: { _ in
            DispatchQueue.main.async {
                viewModel.showLoader()
            }
        }, receiveCompletion: { _ in
            DispatchQueue.main.async {
                viewModel.hideLoader()
            }
        })
        
    }
}

extension Publisher {
    func customDebounce(forSeconds interval: TimeInterval) -> AnyPublisher<Self.Output, Self.Failure> {
        let debounceInterval = Constants.isRunningTests ? 0 : interval
        return debounce(for: .milliseconds(Int(debounceInterval * 1000)), scheduler: DispatchQueue.main).eraseToAnyPublisher()
    }
}

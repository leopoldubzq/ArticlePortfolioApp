import Foundation
import WatchConnectivity

enum WatchConnectivityError: Error {
    case companionAppNotActive
    
    var message: String {
        switch self {
        case .companionAppNotActive:
            "iPhone app not active"
        }
    }
}

struct NotificationMessage: Identifiable, Equatable {
    let id = UUID()
    let title: String?
    let model: ArticleDto?
    let favouriteArticlesList: [ArticleDto]?
    let type: WatchConnectivityMessage
}

enum WatchConnectivityMessage: String, CaseIterable {
    case favouriteArticleModel
    case favouriteArticlesList
}

final class WatchConnectivityManager: NSObject, ObservableObject {
    
    //MARK: - PUBLIC PROPERTIES
    @Published var notificationMessage: NotificationMessage? = nil
    @Published var iPhoneAppIsNotInstalled: Bool = false
    static let shared = WatchConnectivityManager()
    
    //MARK: - INITIALZIERS
    private override init() {
        super.init()
        setupWatchSession()
    }
    
    //MARK: - PUBLIC METHODS
    func send(_ message: Any, type: WatchConnectivityMessage,
              completion: ((WatchConnectivityError?) -> Void)? = nil) {
        guard WCSession.default.activationState == .activated else {
            completion?(.companionAppNotActive)
            return
        }
        completion?(nil)
        #if os(iOS)
        guard WCSession.default.isWatchAppInstalled else {
            return
        }
        #else
        guard WCSession.default.isCompanionAppInstalled else {
            iPhoneAppIsNotInstalled = true
            return
        }
        #endif
        
        WCSession.default.sendMessage([type.rawValue : message], replyHandler: nil) { error in
            print("Cannot send message: \(String(describing: error))")
        }
        
        do {
            try WCSession.default.updateApplicationContext([type.rawValue : message])
        } catch {
            print("Cannot send message: \(error)")
        }
    }
    
}

//MARK: - EXTENSIONS
extension WatchConnectivityManager: WCSessionDelegate {
    func session(_ session: WCSession, didReceiveMessage message: [String : Any]) {
        if let messageType = WatchConnectivityMessage.allCases.first(where: { message[$0.rawValue] != nil }) {
            if let message = message[messageType.rawValue] as? Data,
               messageType == .favouriteArticlesList {
                let decodedArray: [ArticleDto] = message.decodeToArray()
                DispatchQueue.main.async { [weak self] in
                    self?.notificationMessage = NotificationMessage(title: nil, 
                                                                    model: nil,
                                                                    favouriteArticlesList: decodedArray,
                                                                    type: .favouriteArticlesList)
                }
            }
        }
        
        if let messageType = WatchConnectivityMessage.allCases.first(where: { message[$0.rawValue] != nil }) {
            if let message = message[messageType.rawValue] as? Data,
               messageType == .favouriteArticleModel {
                guard let decodedModel: ArticleDto = message.decode() else { return }
                DispatchQueue.main.async { [weak self] in
                    self?.notificationMessage = NotificationMessage(title: nil,
                                                                    model: decodedModel,
                                                                    favouriteArticlesList: nil,
                                                                    type: .favouriteArticleModel)
                }
            }
        }
    }
    
    func session(_ session: WCSession, didReceiveApplicationContext applicationContext: [String : Any]) {}
    func session(_ session: WCSession,
                 activationDidCompleteWith activationState: WCSessionActivationState,
                 error: Error?) {}
    
    #if os(iOS)
    func sessionDidBecomeInactive(_ session: WCSession) {}
    func sessionDidDeactivate(_ session: WCSession) {
        session.activate()
    }
    #endif
    
    private func setupWatchSession() {
        if WCSession.isSupported() {
            WCSession.default.delegate = self
            WCSession.default.activate()
        }
    }
}

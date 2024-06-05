import SwiftUI

final class NavigationStore: ObservableObject, Equatable {
    static func == (lhs: NavigationStore, rhs: NavigationStore) -> Bool {
        lhs.uuid == rhs.uuid
    }
    
    //MARK: - PUBLIC PROPERTIES
    @Published var rootNode: AnyHashable
    @Published var navigationPath: [AnyHashable] = []
    @Published var childSheetNavigationStore: NavigationStore?
    @Published var childFullScreenNavigationStore: NavigationStore?
    @Published var presentationDetents: Set<PresentationDetent> = []
    
    weak var parentNavigationStore: NavigationStore?
    
    //MARK: - PRIVATE PROPERTIES
    private let uuid = UUID()

    //MARK: - INITIALIZERS
    init(rootNode: AnyHashable, parentNavigationStore: NavigationStore?,
         presentationDetents: Set<PresentationDetent> = []) {
        self.rootNode = rootNode
        self.parentNavigationStore = parentNavigationStore
        self.presentationDetents = presentationDetents
    }
    
    //MARK: - PUBLIC METHODS
    func openSheet(with node: AnyHashable, presentationDetents: Set<PresentationDetent> = []) {
        childSheetNavigationStore = NavigationStore(rootNode: node,
                                                    parentNavigationStore: self,
                                                    presentationDetents: presentationDetents)
    }
    
    func closeSheet() {
        parentNavigationStore?.childSheetNavigationStore = nil
    }
    
    func openFullScreen(with node: AnyHashable) {
        childFullScreenNavigationStore = NavigationStore(rootNode: node,
                                                         parentNavigationStore: self)
    }
    
    func closeFullScreen() {
        parentNavigationStore?.childFullScreenNavigationStore = nil
    }
    
    
}

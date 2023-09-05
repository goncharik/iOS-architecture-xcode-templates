import Combine
import Foundation

@MainActor
final class ___VARIABLE_productName___ViewModel {
    enum NavigationEvents {
        case back
    }

    private let navHandler: @MainActor (NavigationEvents) -> Void

    @Published private(set) var isLoading: Bool = false
    @Published private(set) var error: Error?
    
    init(navHandler: @escaping @MainActor (NavigationEvents) -> Void) {
        self.navHandler = navHandler
    }

    func back() {
        navHandler(.back)
    }
}

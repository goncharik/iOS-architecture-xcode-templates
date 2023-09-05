import Combine
import Dependencies
import Foundation

@MainActor
final class ___VARIABLE_productName___ViewModel: ObservableObject  {
    enum NavigationEvents {
        case back
    }

    private let navHandler: @MainActor (NavigationEvents) -> Void

    @Published private(set) var isLoading = false
    @Published var error: Error?
    
    init(
        navHandler: @escaping @MainActor (NavigationEvents) -> Void
    ) {
        self.navHandler = navHandler
    }

    func back() {
        navHandler(.back)
    }
}

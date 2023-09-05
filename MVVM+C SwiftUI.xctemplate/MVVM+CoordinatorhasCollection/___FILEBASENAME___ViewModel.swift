import Combine
import Dependencies
import Foundation
import IdentifiedCollections

@MainActor
final class ___VARIABLE_productName___ViewModel: ObservableObject  {
    enum NavigationEvents {
        case back
    }

    private let navHandler: @MainActor (NavigationEvents) -> Void

    @Published private(set) var isRefreshing = false
    @Published private(set) var isLoadingMore = false
    @Published private(set) var items: IdentifiedArrayOf<<#T##Item##Item#>> = []

    @Published var error: Error?
    
    init(
        navHandler: @escaping @MainActor (NavigationEvents) -> Void
    ) {
        self.navHandler = navHandler
    }

    func load() async {
        isRefreshing = true
        defer { isRefreshing = false }
        error = nil
        
        do {
            // ADD API CALL HERE
        } catch {
            self.error = error
        }
    }
    
    func loadMoreIfNeeded(for item: <#T##Item##Item#>) async {
        guard items.last?.id == item.id else { return }

        isLoadingMore = true
        defer { isLoadingMore = false }

        do {
            // ADD API CALL HERE IF NEEDED
        } catch {
            self.error = error
        }
    }

    func itemSelected(_ item: <#T##Item##Item#>) {
        
    }

    func back() {
        navHandler(.back)
    }
}

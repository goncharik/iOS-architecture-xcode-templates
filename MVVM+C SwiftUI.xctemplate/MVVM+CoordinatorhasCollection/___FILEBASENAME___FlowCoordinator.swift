import UIKit
import SwiftUI

@MainActor
public final class ___VARIABLE_productName___FlowCoordinator {
    private let navigation: UINavigationController
    
    public init(with navigation: UINavigationController) {
        self.navigation = navigation        
    }

    /// Entry point to the flow
    public func start() {
        let viewModel = ___VARIABLE_productName___ViewModel(
            navHandler: navigate
        )
        let view = UIHostingController(
            rootView: ___VARIABLE_productName___View(viewModel: viewModel)
        )

        navigation.pushViewController(view, animated: true)
    }

    // MARK: - Private helpers

    private func navigate(_ event: ___VARIABLE_productName___ViewModel.NavigationEvents) {
        switch event {
        case .back:
            navigation.popViewController(animated: true)
        }
    }
}

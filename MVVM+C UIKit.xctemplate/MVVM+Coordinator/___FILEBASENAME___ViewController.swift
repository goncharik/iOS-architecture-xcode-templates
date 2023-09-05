import Combine
import SnapKit
import UIKit

final class ___VARIABLE_productName___ViewController: UIViewController {
    private let viewModel: ___VARIABLE_productName___ViewModel
    private var cancellables = Set<AnyCancellable>()

    init(with viewModel: ___VARIABLE_productName___ViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        setupUI()
        setupBindings()
    }

    private func setupUI() {
        
    }

    private func setupBindings() {
        viewModel.$error
            .receive(on: DispatchQueue.main)
            .sink { [weak self] in
                self?.showError($0)
            }
            .store(in: &cancellables)

        viewModel.$isLoading
            .receive(on: DispatchQueue.main)
            .sink { [weak self] isLoading in
                // Add progress animation here
            }
            .store(in: &cancellables)
    }
}

// REMOVE IF SOMETHING IS NOT NEEDED
extension ___VARIABLE_productName___ViewController: ErrorPresentable, FullscreenProgressPresentable { }
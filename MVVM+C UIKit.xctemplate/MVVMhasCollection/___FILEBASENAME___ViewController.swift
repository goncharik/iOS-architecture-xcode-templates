import Combine
import SnapKit
import UIKit

final class ___VARIABLE_productName___ViewController: UIViewController {
    private let viewModel: ___VARIABLE_productName___ViewModel
    private var cancellables = Set<AnyCancellable>()

    private var collectionView: UICollectionView!

    private lazy var dataSource: UICollectionViewDiffableDataSource<ListSection, SkeletonableCellModel<___VARIABLE_cellModelClass___>> = {
        let cellRegistration = UICollectionView.CellRegistration<___VARIABLE_cellClass___, ___VARIABLE_cellModelClass___> { [weak self] cell, indexPath, model in
            cell.configure(with: model)
        }
        let skeletonCellRegistration = UICollectionView.CellRegistration<___VARIABLE_cellClass___, UUID> { [weak self] cell, indexPath, model in
            cell.showAnimatedSkeleton()
        }
        let dataSource = UICollectionViewDiffableDataSource<ListSection, SkeletonableCellModel<___VARIABLE_cellModelClass___>>(collectionView: collectionView) { collectionView, indexPath, model in
            switch model {
            case let .skeleton(id):
                return collectionView.dequeueConfiguredReusableCell(using: skeletonCellRegistration, for: indexPath, item: id)
            case let .value(id):
                return collectionView.dequeueConfiguredReusableCell(using: cellRegistration, for: indexPath, item: id)
            }
        }
        
        return dataSource
    }()

    init(with viewModel: ___VARIABLE_productName___ViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        collectionView.layoutSkeletonIfNeeded()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        setupUI()
        setupBindings()
    }

    private func setupUI() {
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: .createListLayout())
        view.addSubview(collectionView)

        collectionView.snp.makeConstraints { make in
            make.top.leading.trailing.bottom.equalToSuperview()            
        }
    }

    private func setupBindings() {    
        viewModel.$error
            .receive(on: DispatchQueue.main)
            .sink { [weak self] in
                self?.showError($0)
            }
            .store(in: &cancellables)

        viewModel.$data
            .combineLatest(viewModel.$isLoading)
            .receive(on: DispatchQueue.main)
            .sink { [weak self] (data, isLoading) in
                self?.reload(data, isSkeletoning: isLoading)
            }
            .store(in: &cancellables)
    }

    // MARK: - Private helpers

    private func reload(_ data: [String], isSkeletoning: Bool) {
        var snapshotData: [SkeletonableCellModel<___VARIABLE_cellModelClass___>] = []
        if data.isEmpty {
            snapshotData = isSkeletoning ? SkeletonableCellModel<___VARIABLE_cellModelClass___>.skeletonableModels : []
        } else {
            snapshotData = data.map(SkeletonableCellModel<___VARIABLE_cellModelClass___>.value)
        }
        var snapshot = NSDiffableDataSourceSnapshot<ListSection, SkeletonableCellModel<___VARIABLE_cellModelClass___>>()
        snapshot.appendSections([ListSection()])
        snapshot.appendItems(snapshotData)
        dataSource.apply(snapshot)
    }
}

// REMOVE IF SOMETHING IS NOT NEEDED
extension ___VARIABLE_productName___ViewController: ErrorPresentable, FullscreenProgressPresentable { }

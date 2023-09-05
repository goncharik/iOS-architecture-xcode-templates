import SwiftUI

struct ___VARIABLE_productName___View: View {
    @ObservedObject var viewModel: ___VARIABLE_productName___ViewModel

    var body: some View {
        ZStack {
            List {
                ForEach(viewModel.items) { item in
                    Button {
                        viewModel.itemSelected(item)
                    } label: {
                        Text("Hello, World!")
                            .background()
                    }
                    .buttonStyle(PlainButtonStyle())
                    .task {
                        await viewModel.loadMoreIfNeeded(for: item)
                    }
                }
                if viewModel.isLoadingMore {
                    ProgressView()
                }
            }
            .listStyle(PlainListStyle())
            .refreshable {
                await viewModel.load()
            }
            if viewModel.items.isEmpty {
                if !viewModel.isRefreshing {
                    VStack(spacing: 16) {
                        Spacer()
                        Text("No items")
                            .font(Font.system(size: 16).weight(.medium))
                        Spacer()
                    }
                } else {
                    ProgressView()
                        .scaleEffect(2)
                }
            }
        }        
        .task {
            await viewModel.load()
        }
        .errorToast($viewModel.error)
    }
}

// MARK: - Preview

#Preview {
    ___VARIABLE_productName___View(
        viewModel: ___VARIABLE_productName___ViewModel(
            navHandler: { _ in }
        )
    )
}

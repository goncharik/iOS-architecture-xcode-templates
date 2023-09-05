import SwiftUI

struct ___VARIABLE_productName___View: View {
    @ObservedObject var viewModel: ___VARIABLE_productName___ViewModel

    var body: some View {
        VStack {
            Text("Hello, World!")
        }
       .errorToast($viewModel.error)
    }
}

#Preview {
    ___VARIABLE_productName___View(
        viewModel: ___VARIABLE_productName___ViewModel(
            navHandler: { _ in }
        )
    )
}

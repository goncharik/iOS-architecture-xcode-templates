import ComposableArchitecture
import SwiftUI

struct ___VARIABLE_productName___Feature: Reducer {
    struct State: Equatable {
        
    }

    enum Action: Equatable {
        case someAction
    }

    var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case .someAction:
                return .none
            }
        }        
    }
}

struct ___VARIABLE_productName___View: View {
    let store: StoreOf<___VARIABLE_productName___Feature>

    var body: some View {
        WithViewStore(store, observe: { $0 }) { viewStore in
            VStack {
                Text("Hello, World!")
            }
            .navigationTitle("Title")            
        }
    }
}

// MARK: - Preview

#Preview {
    MainActor.assumeIsolated {
        NavigationStack {
            ___VARIABLE_productName___View(
                store: Store(initialState: ___VARIABLE_productName___Feature.State()) {
                    ___VARIABLE_productName___Feature()
                        ._printChanges()
                }
            )
        }
    }
}

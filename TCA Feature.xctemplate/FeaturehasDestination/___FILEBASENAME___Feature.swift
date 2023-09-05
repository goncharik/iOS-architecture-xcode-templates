import ComposableArchitecture
import SwiftUI

struct ___VARIABLE_productName___Feature: Reducer {
    struct State: Equatable {
        @PresentationState var destination: Destination.State?
        // other state properties
    }

    enum Action: Equatable {
        case someAction
        case destination(PresentationAction<Destination.Action>)
    }

    struct Destination: Reducer {
        enum State: Equatable {
            case alert(AlertState<Action.Alert>)
            // other destinations if needed
        }

        enum Action: Equatable {
            case alert(Alert)
            enum Alert {
                case confirmDeletion
            }
        }

        var body: some ReducerOf<Self> {
            /*@START_MENU_TOKEN@*//*@PLACEHOLDER=Do something@*//*@END_MENU_TOKEN@*/
        }
    }

    @Dependency(\.dismiss) var dismiss

    var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case .someAction:
                state.destination = .alert(
                    AlertState {
                        TextState("Are you sure you want to delete?")
                    } actions: {
                        ButtonState(role: .destructive, action: .confirmDeletion) {
                            TextState("Delete")
                        }
                    }
                )
                return .none

            case .destination(.presented(.alert(.confirmDeletion))):
                return .run { _ in
                    // Do additional logic if needed
                    await dismiss()
                }

            case .destination:
                return .none
            }
        }
        .ifLet(\.$destination, action: /Action.destination) {
            Destination()
        }
    }
}

struct ___VARIABLE_productName___View: View {
    let store: StoreOf<___VARIABLE_productName___Feature>

    var body: some View {
        WithViewStore(store, observe: { $0 }) { viewStore in
            List {
                Section {
                    Button("Some action") {
                        viewStore.send(.someAction)
                    }
                    .foregroundColor(.red)
                    .frame(maxWidth: .infinity)
                }
            }
            .navigationTitle("Title")
            .alert(
                store: store.scope(state: \.$destination, action: { .destination($0) }),
                state: /___VARIABLE_productName___Feature.Destination.State.alert,
                action: ___VARIABLE_productName___Feature.Destination.Action.alert
            )
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

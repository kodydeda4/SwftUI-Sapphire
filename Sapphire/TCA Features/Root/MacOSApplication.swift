//
//  Model.swift
//  Sapphire
//
//  Created by Kody Deda on 12/24/20.
//

import SwiftUI
import ComposableArchitecture

struct MacOSApplication {
    struct State: Equatable, Identifiable {
        var id   : URL { path }
        let path : URL
        let name : String
        let icon : URL
        var selected = false
    }
    
    enum Action: Equatable {
        case toggleSelected
    }
}

extension MacOSApplication {
    static let reducer = Reducer<State, Action, Void>.combine(
        Reducer { state, action, _ in
            switch action {
            
            case .toggleSelected:
                state.selected.toggle()
                return .none
            }
        }
    )
}

extension MacOSApplication {
    static let defaultStore = Store(
        initialState: .init(
            path: Bundle.allBundleURLs.first!,
            name: Bundle.name(from: Bundle.allBundleURLs.first!),
            icon: Bundle.icon(from: Bundle.allBundleURLs.first!)
        ),
        reducer: reducer,
        environment: ()
    )
}


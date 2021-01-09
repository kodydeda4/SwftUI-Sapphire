//
//  ContentView.swift
//  AdaptiveIcons
//
//  Created by Kody Deda on 12/15/20.
//

import SwiftUI
import Grid
import ComposableArchitecture

struct ThemeView: View {
    let store: Store<ThemeState, ThemeAction>
    
    var body: some View {
        NavigationView {
            sidebar
            primary
            detail
        }
    }
}

// MARK:- HelperViews

extension ThemeView {
    var sidebar: some View {
        SidebarView(store: RootState.defaultStore)
    }
    var primary: some View {
        ThemePrimaryView(store: store)
    }
    
    var detail: some View {
        ThemeDetailView(
            store: store.scope(
                state: \.selectedIconState,
                action: ThemeAction.selectedIconAction))
    }
}

// MARK:- SwiftUI Previews

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ThemeView(store: ThemeState.defaultStore)
    }
}

//
//  IconView.swift
//  AdaptiveIcons
//
//  Created by Kody Deda on 12/25/20.
//

import SwiftUI
import Combine
import ComposableArchitecture
import Grid

enum IconShape: String, CaseIterable {
    case roundedRectangle = "Rounded Rectangle"
    case circle = "Circle"
}

struct IconView: View {
    let store: Store<AppState, AppAction>
    var icon: Icon
    
    var body: some View {
        WithViewStore(store) { viewStore in
            Button(action: { viewStore.send(.toggleSelected(icon)) }) {
                VStack(alignment: .center, spacing: 3) {
                    
                    Image(nsImage: icon.appIcon)
                        .resizable()
                        .scaledToFill()
                        .frame(width: 50, height: 50)
                        .padding(8)
                        .background(icon.backgroundColor)
                        .clipShape(icon.shape)
                        .shadow(color: shadowColor(viewStore), radius: 1.6, y: 2.0)
                        //.border(Color.gray)
                    
                    Text(icon.name)
                        .font(.system(size: 11, weight: .regular))
                        .multilineTextAlignment(.center)
                        .padding(3)
                        //.border(Color.gray)
                    
                    
                }
                .padding(5)
                .frame(width: 100, height: 100, alignment: .top)
                //.border(Color.gray)
            }
            
            .overlay(
                RoundedRectangle(cornerRadius: 6)
                    .stroke(lineWidth: 1)
                    .foregroundColor(selectionColor(viewStore)))
            
            .buttonStyle(BorderlessButtonStyle())
            .onAppear { iddlog("body \(icon.name)") }
        }
    }
    
    private func selectionColor(_ viewStore: ViewStore<AppState, AppAction>) -> Color {
        Color.secondary.opacity(isSelected(viewStore) ? 1 : 0)
    }
    
    private func shadowColor(_ viewStore: ViewStore<AppState, AppAction>) -> Color {
        Color.black.opacity(icon.shadow ? 0.25 : 0)
    }
    
    private func isSelected(_ viewStore: ViewStore<AppState, AppAction>) -> Bool {
        viewStore.icons.filter(\.selected).contains(icon)
    }
}

struct IconView_Previews: PreviewProvider {
    static var previews: some View {
        var icon = Icon(path: "/Applications/Pages.app")
        
        icon.shape = .roundedRectangle
        return IconView(store: defaultStore, icon: icon)
    }
}

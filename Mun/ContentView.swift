//
//  ContentView.swift
//  Mun
//
//  Created by Tomás García Gobet on 15.09.23.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    @Environment(\.scenePhase) private var scenePhase
    
    let saveAction: ()->Void
    
    var body: some View {
        NavigationStack {
            NearbyView()
        }.onChange(of: scenePhase) { phase in
            if phase == .inactive { saveAction() }
        }
    }
}

#Preview {
    ContentView() {}
}

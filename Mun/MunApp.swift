//
//  MunApp.swift
//  Mun
//
//  Created by Tomás García Gobet on 15.09.23.
//

import SwiftUI
import SwiftData

@main
struct MunApp: App {
    @State private var stopManager = StopsManager()
    var body: some Scene {
        WindowGroup {
            ContentView {
                Task {
                    do {
                        try await stopManager.save(stops: stopManager.stops)
                    } catch {
                        fatalError(error.localizedDescription)
                    }
                }
            }
            .environment(stopManager)
            .task {
                do {
                    try await stopManager.load()
                } catch {
                    fatalError(error.localizedDescription)
                }
            }
        }
    }
}

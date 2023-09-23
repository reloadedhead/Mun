//
//  Transport.swift
//  Mun
//
//  Created by Tomás García Gobet on 17.09.23.
//

import Foundation
import SwiftUI

enum Transport: String, CustomStringConvertible, Codable, CaseIterable {
    case sbahn = "SBAHN"
    case ubahn = "UBAHN"
    case bus = "BUS"
    case tram = "TRAM"
    case bahn = "BAHN"
    case regionalBus = "REGIONAL_BUS"
    case ferry = "SCHIFF"
    
    var description: String {
        switch self {
        case .sbahn:
            "S-Bahn"
        case .ubahn:
            "U-Bahn"
        case .bus:
            "Bus"
        case .regionalBus:
            "Regional bus"
        case .tram:
            "Tram"
        case .bahn:
            "Regional train"
        case .ferry:
            "Ferry"
            
        }
    }
    
    @ViewBuilder
    var icon: some View {
        switch self {
            case .bus:
                Image(systemName: "bus")
            case .regionalBus:
                Image(systemName: "bus")
            case .sbahn:
                Image(systemName: "tram")
            case .ubahn:
                Image(systemName: "tram.fill.tunnel")
            case .tram:
                Image(systemName: "cablecar")
            case .bahn:
                Image(systemName: "tram")
            case .ferry:
                Image(systemName: "ferry")
            
        }
    }
}

extension [Transport] {
    func join() -> String {
        return self.map { $0.description }.joined(separator: ", ")
    }
}

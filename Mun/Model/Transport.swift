//
//  Transport.swift
//  Mun
//
//  Created by Tomás García Gobet on 17.09.23.
//

import Foundation
import SwiftUI

enum Transport: String, CustomStringConvertible, Codable {
    case SBAHN = "SBAHN"
    case UBAHN = "UBAHN"
    case BUS = "BUS"
    case TRAM = "TRAM"
    case BAHN = "BAHN"
    case REGIONAL_BUS = "REGIONAL_BUS"
    case SCHIFF = "SCHIFF"
    
    var description: String {
        switch self {
        case .SBAHN:
            "S-Bahn"
        case .UBAHN:
            "U-Bahn"
        case .BUS:
            "Bus"
        case .REGIONAL_BUS:
            "Regional bus"
        case .TRAM:
            "Tram"
        case .BAHN:
            "Train"
        case .SCHIFF:
            "Ferry"
            
        }
    }
    
    @ViewBuilder
    var icon: some View {
        switch self {
            case .BUS:
                Image(systemName: "bus")
            case .REGIONAL_BUS:
                Image(systemName: "bus")
            case .SBAHN:
                Image(systemName: "tram")
            case .UBAHN:
                Image(systemName: "tram.fill.tunnel")
            case .TRAM:
                Image(systemName: "cablecar")
            case .BAHN:
                Image(systemName: "tram")
            case .SCHIFF:
                Image(systemName: "ferry")
            
        }
    }
}

extension [Transport] {
    func join() -> String {
        return self.map { $0.description }.joined(separator: ", ")
    }
}

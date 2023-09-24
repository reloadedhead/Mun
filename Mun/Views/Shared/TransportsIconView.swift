//
//  TransportsIconView.swift
//  Mun
//
//  Created by Tomás García Gobet on 24.09.23.
//

import SwiftUI

struct TransportsIconView: View {
    var transports: [Transport]
    var isMultiTransport: Bool { self.transports.count > 1 }
    
    var body: some View {
        if isMultiTransport {
            Image(systemName: "circle.hexagongrid.fill")
                .symbolRenderingMode(.multicolor)
        } else {
            if let transport = transports.first {
                transport.icon
            }
        }
    }
}


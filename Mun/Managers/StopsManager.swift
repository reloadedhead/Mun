//
//  StopsManager.swift
//  Mun
//
//  Created by Tomás García Gobet on 23.09.23.
//

import Foundation

@Observable class StopsManager {
    private var lastUpdated = Date()
    private var cachedStops = [Stop]()
    
    var stops: [Stop] {
        if lastUpdated.timeIntervalSinceNow > 604800 || cachedStops.isEmpty {
            Task { await loadStops() }
        }
        
        return cachedStops
    }
    
    private func loadStops() async {
        do {
            self.cachedStops = try await Fetch().load(Stop.all())
        } catch {
            print(error)
        }
    }
    
    private static func fileURL() throws -> URL {
        try FileManager.default.url(for: .documentDirectory,
                                    in: .userDomainMask,
                                    appropriateFor: nil,
                                    create: false)
        .appendingPathComponent("stops-manager.data")
    }
    
    func load() async throws {
       let task = Task<StopsManagerData, Error> {
           let fileURL = try Self.fileURL()
           guard let data = try? Data(contentsOf: fileURL) else {
               return StopsManagerData(stops: [], timestamp: Date.now)
           }
           let dailyScrums = try JSONDecoder().decode(StopsManagerData.self, from: data)
           return dailyScrums
        }
        let data = try await task.value
        self.cachedStops = data.stops
        self.lastUpdated = data.timestamp
   }
    
    func save(stops: [Stop]) async throws {
        let task = Task {
            let data = try JSONEncoder().encode(StopsManagerData(stops: stops, timestamp: Date.now))
            let outfile = try Self.fileURL()
            try data.write(to: outfile)
        }
        
        _ = try await task.value
    }
}

private struct StopsManagerData: Codable {
    var stops: [Stop]
    var timestamp: Date
}

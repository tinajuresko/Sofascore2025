//
//  DbManager.swift
//  sofascoreAcademy
//
//  Created by Tina Jureško on 13.04.2025..
//

import Foundation
import GRDB

final class DbManager {
    static let shared = DbManager()
    let dbQueue: DatabaseQueue?
    
    private init() {
        do {
            let dbURL = try FileManager.default
                .url(for: .applicationSupportDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
                .appendingPathComponent("db-academy.sqlite")
            
            try FileManager.default.createDirectory(at: dbURL.deletingLastPathComponent(), withIntermediateDirectories: true)
            self.dbQueue = try DatabaseQueue(path: dbURL.path)
            
            createTables()
        } catch {
            print("Failed to initialize database: \(error)")
            self.dbQueue = nil
        }
    }
    
    private func createTables() {
        guard let dbQueue = dbQueue else { return }
        
        do {
            try dbQueue.write { db in
                try db.create(table: "DBLeague", body: { t in
                    t.primaryKey("id", .integer)
                    t.column("name", .text).notNull()
                    t.column("countryName", .text)
                    t.column("logoUrl", .text)
                })
                
                try db.create(table: "DBEvent", body: { t in
                    t.primaryKey("id", .integer)
                    t.column("homeTeam", .text).notNull()
                    t.column("awayTeam", .text).notNull()
                    t.column("startTimestamp", .integer).notNull()
                    t.column("status", .text).notNull()
                    t.column("homeScore", .integer)
                    t.column("awayScore", .integer)
                    t.column("leagueId", .integer).references("DBLeague", onDelete: .cascade)
                })
                
            }
        } catch {
            print("Failed to create tables: \(error)")
        }
    }
}

//
//  StorageManager.swift
//  sofascoreAcademy
//
//  Created by Tina Jureško on 18.04.2025..
//

import Foundation
import GRDB

final class StorageManager {
    static let shared = StorageManager()
    
    func insertIntoDB(_ sections: [LeagueSection]) async {
        await Task.detached(priority: .background) {
            sections.forEach { section in
                let league = section.league
                let leagueEntity = DBLeague(from: league)
                try? DbManager.shared.dbQueue?.write { db in
                    try? leagueEntity.upsert(db)
                }
                
                let events = section.matches
                events.forEach { event in
                    let eventEntity = DBEvent(from: event)
                    try? DbManager.shared.dbQueue?.write { db in
                        try? eventEntity.upsert(db)
                    }
                }
            }
        }.value
    }
    
    func count<T: FetchableRecord & PersistableRecord>(_ type: T.Type) async -> Int {
        await withCheckedContinuation { continuation in
            DbManager.shared.dbQueue?.asyncRead { dbResult in
                switch dbResult {
                case .success(let db):
                    do {
                        let count = try T.fetchCount(db)
                        continuation.resume(returning: count)
                    } catch {
                        continuation.resume(returning: 0)
                    }
                case .failure:
                    continuation.resume(returning: 0)
                }
            }
        }
    }
    
    func clearTable<T: PersistableRecord & PersistableRecord>(_ type: T.Type) async {
        await withCheckedContinuation { continuation in
            do {
                try DbManager.shared.dbQueue?.write { db in
                    try T.deleteAll(db)
                }
                continuation.resume()
            } catch {
                print("Error deleting \(T.databaseTableName): \(error)")
                continuation.resume()
            }
        }
    }
}

//
//  DataStore.swift
//  JuniorWeekend
//
//  Created by Jelle Vandebeeck on 11/06/16.
//  Copyright © 2016 Fousa. All rights reserved.
//

import PerfectLib
import PostgreSQL

class DataStore {
    
    // MARK: - Configuration
    
    private lazy var host: String = self.getEnvVar("DATABASE_HOST")
    private lazy var name: String = self.getEnvVar("DATABASE_NAME")
    private lazy var username: String = self.getEnvVar("DATABASE_USER")
    private lazy var password: String = self.getEnvVar("DATABASE_PASSWORD")
    
    // MARK: - Connection
    
    private var connection: PGConnection
    
    // MARK: - Environment
    
    private func getEnvVar(name: String) -> String {
        return String.fromCString(getenv(name)) ?? ""
    }
    
    // MARK: - Init
    
    init() throws {
        connection = PostgreSQL.PGConnection()
        connection.connectdb("host='\(host)' dbname='\(name)' user='\(username)' password='\(password)'")
        
        // Check if the connection can be opened.
        guard connection.status() != .Bad else {
            throw PerfectError.FileError(500, "Internal Server Error\n\(connection.errorMessage())")
        }
    }
    
    deinit {
        // Always close the connection at the end.
        connection.close()
    }
    
    // MARK: - Registrations
    
    private func perform(queryString queryString: String) throws -> [[String: Any]] {
        // Query the database.
        let query = connection.exec(queryString)
        guard query.status() == .CommandOK || query.status() == .TuplesOK else {
            throw PerfectError.FileError(500, "Internal Server Error\n\(connection.errorMessage())")
        }

        var objects = [[String: Any]]()
        0.stride(to: query.numTuples(), by: 1).forEach { row in
            var object = [String: Any]()
            0.stride(to: query.numFields(), by: 1).forEach { column in
                if let name = query.fieldName(column) {
                    object[name] = query.getFieldString(row, fieldIndex: column)
                }
            }
            objects.append(object)
        }
        
        return objects
    }
    
    func fetchRegistrations() throws -> [[String: Any]] {
        return try perform(queryString: "SELECT * FROM registrations;")
    }
    
}

//
//  RegistrationsHandler.swift
//  JuniorWeekend
//
//  Created by Jelle Vandebeeck on 11/06/16.
//  Copyright © 2016 Fousa. All rights reserved.
//

import PerfectLib
import PostgreSQL

class RegistrationsHandler: PageHandler {
    
    private let host = "localhost"
    private let name = "junior_weekend_2016"
    private let username = ""
    private let password = ""
    
    func valuesForResponse(context: MustacheEvaluationContext, collector: MustacheEvaluationOutputCollector) throws -> MustacheEvaluationContext.MapType {
        
        // Connect to the database.
        let connection = PostgreSQL.PGConnection()
        connection.connectdb("host='\(host)' dbname='\(name)' user='\(username)' password='\(password)'")
        defer {
            // Always close the connection at the end.
            connection.close()
        }
        
        // Check if the connection can be opened.
        guard connection.status() != .Bad else {
            throw PerfectError.FileError(500, "Internal Server Error - Failed to connect to database")
        }
        
        let query = connection.exec("SELECT * FROM registrations;")
        // Check if the query succeeded.
        guard query.status() == .CommandOK || query.status() == .TuplesOK else {
            throw PerfectError.FileError(500, "Internal Server Error - Failed to query the database")
        }
        
        var registrations = [[String: Any]]()
        
        0.stride(to: query.numTuples(), by: 1).forEach { row in
            var registration = [String: Any]()
            0.stride(to: query.numFields(), by: 1).forEach { column in
                if let fieldName = query.fieldName(column) where fieldName == "name" {
                    print("🤘 \(row): \(query.getFieldString(row, fieldIndex: column))")
                    registration["name"] = query.getFieldString(row, fieldIndex: column)
                }
            }
            registrations.append(registration)
        }
        
        var values = MustacheEvaluationContext.MapType()
        values["title"] = "Registrations"
        values["registrations"] = registrations
        values["count"] = registrations.count
        return values
    }
    
}

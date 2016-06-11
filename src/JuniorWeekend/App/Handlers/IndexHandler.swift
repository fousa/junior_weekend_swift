//
//  IndexHandler.swift
//  JuniorWeekend
//
//  Created by Jelle Vandebeeck on 11/06/16.
//  Copyright © 2016 Fousa. All rights reserved.
//

import PerfectLib
import PostgreSQL

class IndexHandler: PageHandler {
    
    private let host = "localhost"
    private let name = "junior_weekend_2016"
    private let username = ""
    private let password = ""
    
    func valuesForResponse(context: MustacheEvaluationContext, collector: MustacheEvaluationOutputCollector) throws -> MustacheEvaluationContext.MapType {
        var values = MustacheEvaluationContext.MapType()
        
        if let
            request = context.webRequest,
            params = request.params() {
            if params.count > 0 {
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
                
                let query = connection.exec("INSERT INTO \"registrations\"(\"name\") VALUES (E'\(params.first)');")
                // Check if the query succeeded.
                guard query.status() == .CommandOK || query.status() == .TuplesOK else {
                    throw PerfectError.FileError(500, "Internal Server Error - \(query.errorMessage())")
                }
            }
        }
        
        values["title"] = "Juniorenweekend 2016"
        
        return values
    }
    
}
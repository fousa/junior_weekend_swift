//
//  RegistrationsHandler.swift
//  JuniorWeekend
//
//  Created by Jelle Vandebeeck on 11/06/16.
//  Copyright © 2016 Fousa. All rights reserved.
//

import PerfectLib

#if os(Linux)
    import Glibc
#else
    import Darwin
#endif

enum Logger {
    static func info(string: String) {
        fputs(string, stdout)
        fflush(stdout)
    }
}

class RegistrationsHandler: PageHandler {
    
    func valuesForResponse(context: MustacheEvaluationContext, collector: MustacheEvaluationOutputCollector) throws -> MustacheEvaluationContext.MapType {
        let registrations = try DataStore().fetchRegistrations()
        
        var values = MustacheEvaluationContext.MapType()
        values["title"] = "Registrations"
        values["registrations"] = registrations
        values["count"] = registrations.count
        return values
    }
    
}

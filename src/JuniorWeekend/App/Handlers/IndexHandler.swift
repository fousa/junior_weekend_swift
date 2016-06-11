//
//  IndexHandler.swift
//  JuniorWeekend
//
//  Created by Jelle Vandebeeck on 11/06/16.
//  Copyright © 2016 Fousa. All rights reserved.
//

import PerfectLib

class IndexHandler: PageHandler {
    
    func valuesForResponse(context: MustacheEvaluationContext, collector: MustacheEvaluationOutputCollector) throws -> MustacheEvaluationContext.MapType {
        var values = MustacheEvaluationContext.MapType()
        
        if let
            request = context.webRequest,
            params = request.params() {
            if params.count > 0 {
                try DataStore().addRegistration(withParams: params)
            }
        }
        
        values["title"] = "Juniorenweekend 2016"
        return values
    }
    
}
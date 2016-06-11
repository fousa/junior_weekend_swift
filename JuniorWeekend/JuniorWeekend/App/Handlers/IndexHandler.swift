//
//  IndexHandler.swift
//  JuniorWeekend
//
//  Created by Jelle Vandebeeck on 11/06/16.
//  Copyright © 2016 Fousa. All rights reserved.
//

import Foundation
import PerfectLib

public func PerfectServerModuleInit() {
    
    PageHandlerRegistry.addPageHandler("IndexHandler") { (response: WebResponse) -> PageHandler in
        return IndexHandler()
    }
    
}

class IndexHandler: PageHandler {
    
    func valuesForResponse(context: MustacheEvaluationContext, collector: MustacheEvaluationOutputCollector) throws -> MustacheEvaluationContext.MapType {
        let values = MustacheEvaluationContext.MapType()
        return values
    }
    
}
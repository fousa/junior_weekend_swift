//
//  Registration.swift
//  JuniorWeekend
//
//  Created by Jelle Vandebeeck on 12/06/16.
//  Copyright © 2016 Fousa. All rights reserved.
//

import PerfectLib

struct Registration {
    
    var name: String?
    
    // MARK: - Template
    
    var mustache: MustacheEvaluationContext.MapType {
        return [
            "name": name
        ]
    }
    
}
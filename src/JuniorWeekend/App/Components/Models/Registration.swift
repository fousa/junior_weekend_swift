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
    
    // MARK: - Init
    
    init() {
    }
    
    init?(params: [(String,String)]) {
        for (key, value) in params {
            switch key {
            case "name": name = value
            default:
                break
            }
        }
        
        guard let _ = name else {
            return nil
        }
    }
    
    // MARK: - Template
    
    var mustache: MustacheEvaluationContext.MapType {
        return [
            "name": name
        ]
    }
    
}
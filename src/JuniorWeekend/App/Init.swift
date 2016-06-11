//
//  InitHandler.swift
//  JuniorWeekend
//
//  Created by Jelle Vandebeeck on 11/06/16.
//  Copyright © 2016 Fousa. All rights reserved.
//

import PerfectLib

public func PerfectServerModuleInit() {
    
    PageHandlerRegistry.addPageHandler("IndexHandler") { (response: WebResponse) -> PageHandler in
        return IndexHandler()
    }
    
    PageHandlerRegistry.addPageHandler("RegistrationsHandler") { (response: WebResponse) -> PageHandler in
        return RegistrationsHandler()
    }
    
}
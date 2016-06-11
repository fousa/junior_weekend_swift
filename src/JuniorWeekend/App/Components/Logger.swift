//
//  Logger.swift
//  JuniorWeekend
//
//  Created by Jelle Vandebeeck on 11/06/16.
//  Copyright © 2016 Fousa. All rights reserved.
//

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
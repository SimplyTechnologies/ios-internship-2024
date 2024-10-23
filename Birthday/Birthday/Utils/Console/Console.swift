//
//  Console.swift
//  Birthday
//
//  Created by Narek on 22.10.24.
//

import os
import Foundation

struct Console {
    private init() {}

    static func log(_ items: Any..., separator: String = " ", terminator: String = "\n") {
        let output = items.map { "🔓\n\($0)" }.joined(separator: separator)
        let logger = Logger(subsystem: Bundle.main.bundleIdentifier ?? "com.Birthday.ios", category: "custom_console_logger")
        logger.log("This is a log message with a value: \(output)")
    }
}

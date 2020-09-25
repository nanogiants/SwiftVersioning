//
// Created by NanoGiants GmbH on 22.09.20.
// Copyright © 2020 NanoGiants GmbH. All rights reserved.
//

import Foundation
import Logging

final class Log {
    // MARK: - Properties

    static var isVerbose: Bool = false {
        didSet {
            if isVerbose {
                sharedLog.logger.logLevel = .trace
            } else {
                sharedLog.logger.logLevel = .info
            }

            #if DEBUG
            sharedLog.logger.logLevel = .trace
            #endif
        }
    }

    private static var sharedLog: Log = {
        Log()
    }()

    private var logger: Logger

    // MARK: - Init

    private init() {
        self.logger = Logger(label: "eu.NanoGiants.swift-versioning",
                             factory: StreamLogHandler.standardOutput(label:))
    }

    // MARK: - Methods

    class func verbose(_ message: Logger.Message) {
        sharedLog.logger.trace(message)
    }

    class func info(_ message: Logger.Message) {
        sharedLog.logger.info(message)
    }

    class func warning(_ message: Logger.Message) {
        sharedLog.logger.warning(message)
    }

    class func error(_ message: Logger.Message) {
        sharedLog.logger.error(message)
    }
}

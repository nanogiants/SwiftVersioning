//
// Created by NanoGiants GmbH on 22.09.20.
// Copyright © 2020 NanoGiants GmbH. All rights reserved.
//

import Foundation
import Logging

final class Log {
    // MARK: - Properties

    static var isVerbose: Bool = false

    private static var sharedLog: Log = {
        Log()
    }()

    private var logger: Logger

    // MARK: - Init

    private init() {
        self.logger = Logger(label: "test")
    }

    // MARK: - Methods

    class func verbose(_ message: Logger.Message) {
        sharedLog.logger.trace(message)
    }

    class func info(_ message: Logger.Message) {
        sharedLog.logger.info(message)
    }

    class func debug(_ message: Logger.Message) {
        sharedLog.logger.debug(message)
    }

    class func warning(_ message: Logger.Message) {
        sharedLog.logger.warning(message)
    }

    class func error(_ message: Logger.Message) {
        sharedLog.logger.error(message)
    }
}

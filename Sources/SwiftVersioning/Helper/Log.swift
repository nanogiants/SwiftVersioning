//
// Created by NanoGiants GmbH on 22.09.20.
// Copyright © 2020 NanoGiants GmbH. All rights reserved.
//

import Foundation


final class Log {
    // MARK: - Properties

    static var isVerbose: Bool = false
    private static var sharedLog: Log = {
        Log(commandHandler: CommandHandler())
    }()

    // MARK: - Dependencies

    private var commandHandler: CommandHandlerProtocol

    // MARK: - Init

    private init(commandHandler: CommandHandlerProtocol) {
        self.commandHandler = commandHandler
    }

    // MARK: - Methods

    class func debug(_ message: String) {
        if isVerbose {
            sharedLog.commandHandler.log(message)
        }
    }

    class func error(_ message: String) {
        sharedLog.commandHandler.log(message)
        exit(EXIT_FAILURE)
    }
}

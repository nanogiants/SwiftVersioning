//
// Created by NanoGiants GmbH on 02.10.20.
// Copyright © 2020 NanoGiants GmbH. All rights reserved.
//

import Foundation

protocol CommandHandlerProtocol {
    func invoke(_ command: String, with arguments: [String]) -> String
}

final class CommandHandler: CommandHandlerProtocol {
    func invoke(_ command: String, with arguments: [String]) -> String {
        launch(command: command, arguments: arguments)
    }
}

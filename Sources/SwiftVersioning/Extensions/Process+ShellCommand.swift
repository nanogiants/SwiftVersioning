//
// Created by NanoGiants GmbH on 28.08.20.
// Copyright © 2020 NanoGiants GmbH. All rights reserved.
//

import Foundation

extension Process {
    func shell(command: String) -> String {
        launchPath = "/bin/bash"
        arguments = ["-c", command]

        let outputPipe = Pipe()
        standardOutput = outputPipe
        launch()

        let data = outputPipe.fileHandleForReading.readDataToEndOfFile()
        guard let outputData = String(data: data, encoding: String.Encoding.utf8) else { return "" }

        return outputData.reduce("") { (result, value) in
            if value.isWhitespace {
                return result
            }

            return result + String(value)
        }
    }
}

func launch(command: String, arguments: [String]) -> String {
    let process = Process()
    let command = "\(command) \(arguments.joined(separator: " "))"
    return process.shell(command: command)
}

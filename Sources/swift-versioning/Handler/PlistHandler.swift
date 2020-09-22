//
// Created by NanoGiants GmbH on 20.09.20.
// Copyright © 2020 NanoGiants GmbH. All rights reserved.
//

import Foundation

protocol PlistHandlerProtocol {
    func write(_ version: Version, to plistPathString: String)
}

final class PlistHandler: PlistHandlerProtocol {
    // MARK: - Properties
    
    private var encoder: PropertyListEncoder {
        let encoder = PropertyListEncoder()
        encoder.outputFormat = .xml
        
        return encoder
    }
    
    // MARK: - Methode
    
    func write(_ version: Version, to plistPathString: String) {
        if plistPathString.isValid() {
            let plistUrl: URL = URL(fileURLWithPath: plistPathString, isDirectory: false)
            save(version, to: plistUrl)
        } else {
            // TODO: error handling -> no valid path to plist
        }
    }
    
    // MARK: - Private Methods
    
    private func save(_ version: Version, to plistUrl: URL) {
        if let data = try? encoder.encode(version) {
            do {
                // TODO: writing data to plist will overwrite content -> don't
                try data.write(to: plistUrl, options: .atomic)
            } catch {
                // TODO: error handling -> could not write data
            }
        } else {
            // TODO: error handling -> could not encode version
            print("could not encode version")
        }
    }
}

fileprivate extension String {
    func isValid() -> Bool {
        FileManager.default.fileExists(atPath: self)
    }
}

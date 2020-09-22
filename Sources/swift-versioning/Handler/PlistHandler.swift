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
    
    private var decoder = PropertyListDecoder()
    
    // MARK: - Methode
    
    func write(_ version: Version, to plistPathString: String) {
        Log.verbose("Write version:")
        if plistPathString.isValid() {
            let plistUrl: URL = URL(fileURLWithPath: plistPathString, isDirectory: false)
            save(version, to: plistUrl)
        } else {
            // TODO: error handling -> no valid path to plist
        }
    }
    
    // MARK: - Private Methods
    
    private func save(_ version: Version, to plistUrl: URL) {
        do {
            if let plistData = read(plistUrl) {
                let versionData = try encoder.encode(version)
                let data = NSMutableData()
                data.append(plistData)
                data.append(versionData)
                
                Log.verbose("... beginn writing to plist.")
                try data.write(to: plistUrl, options: .atomic)
                Log.verbose("... done!")
            } else {
                // TODO: error handling -> could read plist
                Log.verbose("Error: couldn't fetch plist")
            }
        } catch {
            // TODO: error handling -> could not write data
            Log.verbose("Error: couldn't read plist")
        }
    }
    
    private func read(_ plistUrl: URL) -> Data? {
        Log.verbose("... reading existing plist.")
        if let data = try? Data(contentsOf: plistUrl) {
            do {
                let tmpDict = try PropertyListSerialization.propertyList(from: data, options: .mutableContainers, format: nil)
                Log.verbose("... done!: \(tmpDict)")
                    
//                if let tmpDict = try PropertyListSerialization.propertyList(from: data, options: .mutableContainers, format: nil) as? Data {
//                    Log.verbose("... done!: \(tmpDict)")
//                    return nil
//                } else {
//                    // TODO: error handling -> couldn't cast propertyList to data
//                    Log.verbose("Error: couldn't cast propertyList to data")
//                }
            } catch {
                // TODO: error handling -> couldn't decode existing plist
                Log.verbose("Error: couldn't decode existing plist")
            }
        } else {
            // TODO: error handling -> couldn't read plist
            Log.verbose("Error: couldn't read plist")
        }
        
        return nil
    }
}

fileprivate extension String {
    func isValid() -> Bool {
        FileManager.default.fileExists(atPath: self)
    }
}

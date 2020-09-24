//
// Created by NanoGiants GmbH on 20.09.20.
// Copyright © 2020 NanoGiants GmbH. All rights reserved.
//

import Foundation

protocol PlistHandlerProtocol {
    func write(_ version: Version, to plistPathString: String)
}

final class PlistHandler: PlistHandlerProtocol {
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
            if let plistDict = read(plistUrl) {
                if let versionDict = version.dictionary() {
                    let mergedDict = plistDict.merging(versionDict) { (_, new) in new }
                    let mergedData = try PropertyListSerialization.data(fromPropertyList: mergedDict, format: .xml, options: .max)
                    Log.verbose("... beginn writing to plist.")
                    try mergedData.write(to: plistUrl, options: .atomic)
                    Log.verbose("... done!")
                } else {
                    // TODO: error handling -> could read plist
                }
            } else {
                // TODO: error handling -> could read plist
                Log.verbose("Error: couldn't fetch plist")
            }
        } catch {
            // TODO: error handling -> could not write data
            Log.verbose("Error: couldn't read plist: \(error)")
        }
    }
    
    private func read(_ plistUrl: URL) -> [String : Any]? {
        Log.verbose("... reading existing plist.")
        
        if let plist = FileManager.default.contents(atPath: plistUrl.path) {
            do {
                let plistDict = try PropertyListSerialization.dictionary(from: plist)
                return plistDict
            } catch {
                // TODO: error handling -> couldn't decode existing plist
                Log.verbose("Error: couldn't decode existing plist to data")
            }
        } else {
            // TODO: error handling -> couldn't read plist
            Log.verbose("Error: couldn't read plist from file")
        }
        
        return nil
    }
}

fileprivate extension String {
    func isValid() -> Bool {
        FileManager.default.fileExists(atPath: self)
    }
}

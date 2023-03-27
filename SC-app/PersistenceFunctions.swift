//
//  PersistenceFunctions.swift
//  SC-app
//
//  Created by klifton Cheng stu on 25/3/23.
//

import Foundation
import SwiftUI

class CouncillorManager: ObservableObject {
    static let shared: CouncillorManager = .init() 
    
    @Published var councillors: [Councillor] = [] {
        didSet {
            save()
        }
    }
        
    private init() {
        load()
    }
    
    func getArchiveURL() -> URL {
        let plistName = "Councillors.plist"
        let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        
        return documentsDirectory.appendingPathComponent(plistName)
    }
    
    func save() {
        let archiveURL = getArchiveURL()
        let propertyListEncoder = PropertyListEncoder()
        let encodedCouncillors = try? propertyListEncoder.encode(councillors)
        try? encodedCouncillors?.write(to: archiveURL, options: .noFileProtection)
    }
    
    func load() {
        let archiveURL = getArchiveURL()
        let propertyListDecoder = PropertyListDecoder()
                
        if let retrievedCouncillorData = try? Data(contentsOf: archiveURL),
            let councillorsDecoded = try? propertyListDecoder.decode([Councillor].self, from: retrievedCouncillorData) {
            councillors = councillorsDecoded
        }
    }
}

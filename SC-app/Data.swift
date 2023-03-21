//
//  Data.swift
//  SC-app
//
//  Created by klifton Cheng stu on 21/3/23.
//

import Foundation

enum Subcomm: String {
    case Discipline = "Discipline"
    case StudentEngagement = "Student Engagement"
    case Training = "Training"
    case Communications = "Communications"
    case None = "None"
}

extension Subcomm {
    
    var title: String {
        switch self {
        case .Discipline: return "Discipline Subcomm"
        case .StudentEngagement: return "Student Engagement Subcomm"
        case .Training: return "Training Subcomm"
        case .Communications: return "Communications Subcomm"
        case .None: return "No Subcomm"
        }
    }
}

struct Councillor: Identifiable {
    var id = UUID()
    
    let name: String
    let Class: String
    let Subcomm: Subcomm
    let ExCo: Bool? = false
    let Callings: Int? = 0
}

extension Councillor {
    
    static func names() -> [Councillor] {
        return [.init(name: "Klifton", Class: "S30X", Subcomm: .Discipline),
                .init(name: "Luke", Class: "S30X", Subcomm: .Discipline),
                .init(name: "Natalie", Class: "S30X", Subcomm: .StudentEngagement),
                .init(name: "Neha", Class: "S30X", Subcomm: .Communications),
                .init(name: "Nicole", Class: "S30X", Subcomm: .Training)]
    }
}

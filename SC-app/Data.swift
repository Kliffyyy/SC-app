//
//  Data.swift
//  SC-app
//
//  Created by klifton Cheng stu on 21/3/23.
//

import Foundation
import SwiftUI

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
    
    var name: String
    var formClass: String
    var subcomm: Subcomm
    var exco: Bool? = false
    var callings: Int? = 0
    
    init(name: String, formClass: String, subcomm: Subcomm, exco: Bool? = false, callings: Int? = 0) {
        self.name = name
        self.formClass = formClass
        self.subcomm = subcomm
        self.exco = exco
        self.callings = callings
    }
}

extension Councillor {
    
    static func names() -> [Councillor] {
        return [.init(name: "Klifton", formClass: "S30X", subcomm: .Discipline),
                .init(name: "Luke", formClass: "S30X", subcomm: .Discipline),
                .init(name: "Natalie", formClass: "S30X", subcomm: .StudentEngagement, exco: true),
                .init(name: "Neha", formClass: "S30X", subcomm: .Communications, exco: true),
                .init(name: "Nicole", formClass: "S30X", subcomm: .Training)]
    }
}

enum tagColor: Color. {
    
    case Discipline = red
    case StudentEngagement = orange
    case Training = cyan
    case Communications = blue
    case None = white
}

extension tagColor {
    
    var value: String {
        switch self {
        case .Discipline: return .red
        case .StudentEngagement: return .orange
        case .Training: return .cyan
        case .Communications: return .blue
        case .None: return .white
        }
    }
}

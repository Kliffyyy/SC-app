//
//  Data.swift
//  SC-app
//
//  Created by klifton Cheng stu on 21/3/23.
//

import Foundation
import SwiftUI

enum Subcomm: String, Codable, CaseIterable {
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

struct Councillor: Identifiable, Codable {
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

protocol ValidationRule {
    
    associatedtype Value: Equatable
    associatedtype Failure: Error
    
    var fallbackValue: Value { get }
    
    func validate(_ value: Value) -> Result<Value, Failure>
}

extension ValidationRule where Value == String {
    var fallbackValue: Value { .init() } // returns empty String
}

extension ValidationRule where Value: ExpressibleByNilLiteral {
    var fallbackValue: Value { .init(nilLiteral: ()) } // returns nil
}

typealias ErrorMessage = String
extension ErrorMessage: Error {}

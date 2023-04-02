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

struct ValidatableTextField: View {
    let placeholder: String
    @State private var text = ""
    var validation: (String) -> Bool
  
    @Binding private var sourceText: String
  
    init(_ placeholder: String, text: Binding<String>, validation: @escaping (String) -> Bool) {
        self.placeholder = placeholder
        self.validation = validation
        self._sourceText = text
    
        self.text = text.wrappedValue
    }
  
    var body: some View {
        TextField(placeholder, text: $text)
            .onChange(of: text) { newValue in
                if validation(newValue) {
                    self.sourceText = newValue.uppercased()
                } else {
                    self.text = sourceText.uppercased()
                }
            }
    }
}



/*
// Protocols 

public protocol ValidationRule {
    
    associatedtype Value: Equatable
    associatedtype Failure: Error
    typealias ValidationResult = Result<Value, Failure>
    
    init()
    
    var fallbackValue: Value { get }
    
    func validate(_ value: Value) -> Result<Value, Failure>
}

public extension ValidationRule where Value == String {
    var fallbackValue: Value { .init() } // returns empty String
}

public extension ValidationRule where Value: ExpressibleByNilLiteral {
    var fallbackValue: Value { .init(nilLiteral: ()) } // returns nil
}

// adding to the View protocol
extension View {
    
    public func validate<Rule>(_ value: Binding<Rule.Value>, rule: Rule, validation: @escaping (Rule.ValidationResult) -> Void) -> some View where Rule: ValidationRule {
        
        self
            .onChange(of: value.wrappedValue) { value in
                let result = rule.validate(value)
                validation(result)
            }
            .onSubmit {
                let result = rule.validate(value.wrappedValue)
                if case .success(let validated) = result {
                    if value.wrappedValue != validated {
                        value.wrappedValue = validated // update value
                    }
                }
            }
    }
}
*/

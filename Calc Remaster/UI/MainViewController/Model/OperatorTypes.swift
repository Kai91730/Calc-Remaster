//
//  OperatorTypes.swift
//  Calc Remaster
//
//  Created by Kai on 2022/3/15.
//

import Foundation

enum OperatorTypes: Int {
    case none
    case plus
    case minus
    case multiply
    case divide
    
    func title() -> String {
        switch self{
        case .plus:
            return "+"
        case .minus:
            return "-"
        case .multiply:
            return "x"
        case .divide:
            return "/"
        default:
            return "none"
        }
    }
    
    func tag() -> Int {
        switch self {
        case .plus:
            return 1
        case .minus:
            return 2
        case .multiply:
            return 3
        case .divide:
            return 4
        default:
            return 0
        }
    }
}

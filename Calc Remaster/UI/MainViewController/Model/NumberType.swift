//
//  NumberType.swift
//  Calc Remaster
//
//  Created by Kai on 2022/3/15.
//

import Foundation

enum NumberType: Int {
    case zero
    case doubleZero
    case one
    case two
    case three
    case four
    case five
    case six
    case seven
    case eight
    case nine
    case point
    
    func content() -> String? {
        switch self {
        case .zero:
            return "0"
        case .doubleZero:
            return "00"
        case .one:
            return "1"
        case .two:
            return "2"
        case .three:
            return "3"
        case .four:
            return "4"
        case .five:
            return "5"
        case .six:
            return "6"
        case .seven:
            return "7"
        case .eight:
            return "8"
        case .nine:
            return "9"
        case .point:
            return "."
        }
    }
    
    func tag() -> Int {
        switch self {
        case .zero:
            return 0
        case .doubleZero:
            return 100
        case .one:
            return 1
        case .two:
            return 2
        case .three:
            return 3
        case .four:
            return 4
        case .five:
            return 5
        case .six:
            return 6
        case .seven:
            return 7
        case .eight:
            return 8
        case .nine:
            return 9
        case .point:
            return 10
        }
    }
}

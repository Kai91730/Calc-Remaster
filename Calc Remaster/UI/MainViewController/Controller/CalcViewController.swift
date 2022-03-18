//
//  CalcViewController.swift
//  Calc Remake
//
//  Created by Kai on 2021/11/10.
//

import Foundation
import UIKit
import SnapKit

class CalcViewController: UIViewController {

    private let mainView: CalcView = CalcView()
    
    private var resultNumber: Decimal? = 0
    private var currentNumber: Decimal = 0
    private var previousNumber: Decimal = 0
    private var currentOperator: OperatorTypes = OperatorTypes.none
    private var isCalculateStarted: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        initView()
        addTargets()
    }
    
    private func initView() {
        
        self.view.addSubview(mainView)
        mainView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
    }
    
    private func addTargets() {
        
        mainView.acButton.addTarget(self, action: #selector(pressedACButton), for: .touchUpInside)
        mainView.symbolSwitchButton.addTarget(self, action: #selector(pressedSymbolSwitchButton), for: .touchUpInside)
        mainView.symbolEqualButton.addTarget(self, action: #selector(pressedEqualButton), for: .touchUpInside)
        
        mainView.plusButton.addTarget(self, action: #selector(pressedOperatorButton), for: .touchUpInside)
        mainView.minusButton.addTarget(self, action: #selector(pressedOperatorButton), for: .touchUpInside)
        mainView.multiplyButton.addTarget(self, action: #selector(pressedOperatorButton), for: .touchUpInside)
        mainView.divideButton.addTarget(self, action: #selector(pressedOperatorButton), for: .touchUpInside)

        mainView.numberZeroButton.addTarget(self, action: #selector(pressNumberButton), for: .touchUpInside)
        mainView.numberDoubleZeroButton.addTarget(self, action: #selector(pressNumberButton), for: .touchUpInside)
        mainView.numberOneButton.addTarget(self, action: #selector(pressNumberButton), for: .touchUpInside)
        mainView.numberTwoButton.addTarget(self, action: #selector(pressNumberButton), for: .touchUpInside)
        mainView.numberThreeButton.addTarget(self, action: #selector(pressNumberButton), for: .touchUpInside)
        mainView.numberFourButton.addTarget(self, action: #selector(pressNumberButton), for: .touchUpInside)
        mainView.numberFiveButton.addTarget(self, action: #selector(pressNumberButton), for: .touchUpInside)
        mainView.numberSixButton.addTarget(self, action: #selector(pressNumberButton), for: .touchUpInside)
        mainView.numberSevenButton.addTarget(self, action: #selector(pressNumberButton), for: .touchUpInside)
        mainView.numberEightButton.addTarget(self, action: #selector(pressNumberButton), for: .touchUpInside)
        mainView.numberNineButton.addTarget(self, action: #selector(pressNumberButton), for: .touchUpInside)
        mainView.symbolPointButton.addTarget(self, action: #selector(pressNumberButton), for: .touchUpInside)
        
    }
    
    @objc func pressedACButton() {
        currentNumber = 0
        previousNumber = 0
        currentOperator = OperatorTypes.none
        mainView.resultBar.text = "0"
        isCalculateStarted = false
        disableSelectedButton()
    }
    
    @objc func pressNumberButton(sender: UIButton) {
        //TODO: resultBar limit
        if let inputString = sender.titleLabel?.text,
           let resultBarText = mainView.resultBar.text {
            
            var addedNumberString = resultBarText

            if inputString == "." {
                
                if resultBarText.contains(".") {
                } else {
                    addedNumberString += inputString
                    mainView.resultBar.text = addedNumberString
                    isCalculateStarted = true
                }
                
            } else {
                
                addedNumberString = addNumber(inputString: inputString)
                let removedCommaString = removeSymbol(inputString: addedNumberString, symbol: ",")
                
                guard let formattedResultNumberString = formatter(removedCommaString),
                      let decimalResultNumber = Decimal(string: removedCommaString) else {
                    print("removedCommaString unwrapped failed! 001")
                    return
                }
                
                if resultBarText.contains(".") {
                    //加了數字後不做format以避免去除逗號
                    mainView.resultBar.text = addedNumberString
                    currentNumber = decimalResultNumber
                } else {
                    if inputString == "." {
                        mainView.resultBar.text = formattedResultNumberString + "."
                    } else {
                        mainView.resultBar.text = formattedResultNumberString
                    }
                    currentNumber = decimalResultNumber
                }
                
                currentNumber = decimalResultNumber
                isCalculateStarted = true
            }
        }
    }
    
    @objc private func pressedOperatorButton(sender: UIButton) {
        
        sender.isSelected = true
        if let selectedOperator = OperatorTypes(rawValue: sender.tag) {
            currentOperator = selectedOperator
        }
        
        previousNumber = currentNumber
        currentNumber = 0
        mainView.resultBar.text = "0"
    }

    @objc func pressedEqualButton() {
        
        let operatorType = currentOperator
        print("currentOperator:\(currentOperator)")
        print("numbers:\(previousNumber) \(currentNumber)")
        switch operatorType {

        case .plus:
            resultNumber = previousNumber + currentNumber
        case .minus:
            resultNumber = previousNumber - currentNumber
        case .multiply:
            resultNumber = previousNumber * currentNumber
        case .divide:
            if currentNumber == 0 {
                resultNumber = nil
            } else {
                resultNumber = previousNumber / currentNumber
            }
        default:
            print("there is no selected operator now. 003")
        }
        
        guard let unwrappedResultNumber = resultNumber else {
            mainView.resultBar.text = "錯誤"
            currentOperator = OperatorTypes.none
            isCalculateStarted = false
            disableSelectedButton()
            return
        }
        
        let resultNumberString = NSDecimalNumber(decimal: unwrappedResultNumber).stringValue
        guard let formattedString = formatter(resultNumberString) else {
            print("resultNumberString unwrapped failed 004")
            return
        }
        
        disableSelectedButton()
        
        mainView.resultBar.text = "\(formattedString)"
        currentOperator = OperatorTypes.none
        isCalculateStarted = false
    }
    
    @objc private func pressedSymbolSwitchButton() {
        
        currentNumber = currentNumber * -1
        
        let currentNumberString = NSDecimalNumber(decimal: currentNumber).stringValue
        guard let formattedString = formatter(currentNumberString) else {
            print("currentNumberString unwrapped failed 005")
            return
        }
        
        mainView.resultBar.text = "\(formattedString)"
    }
    
    private func addNumber(inputString: String) -> String {
        
        guard var resultString = mainView.resultBar.text else {
            print("resultBar.text unwrapped failed 002 ")
            return "錯誤"
        }
        
        if !isCalculateStarted {
            resultString = inputString
        } else {
            resultString += inputString
        }
        
        return resultString
    }
    
    private func formatter(_ string: String) -> String? {
        
        var formattedString = ""
        
        let formatter = NumberFormatter()
        formatter.allowsFloats = true
        formatter.numberStyle = .decimal
        formatter.groupingSize = 3
        formatter.maximumFractionDigits = 8
        
        if let nsNumberOfString = formatter.number(from: string) {
            formattedString = formatter.string(from: nsNumberOfString) ?? ""
        }
        
        return formattedString
    }
    
    private func removeSymbol(inputString: String, symbol: Character) -> String {
        
        var string = inputString
        
        string.removeAll { char in
            return char == symbol
        }
        return string
    }
    
    private func disableSelectedButton () {
        
        for view in mainView.subviews as [UIView] {
            if let btn = view as? UIButton {
                if btn.isSelected {
                    btn.isSelected = false
                }
            }
        }
    }

}

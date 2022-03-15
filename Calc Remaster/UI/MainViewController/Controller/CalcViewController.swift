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

    private var screenWidth = UIScreen.main.bounds.width
    private var screenHeight = UIScreen.main.bounds.height
    private lazy var numberZeroButton: UIButton = makeNumberButton(type: .zero)
    private lazy var numberDoubleZeroButton: UIButton = makeNumberButton(type: .doubleZero)
    private lazy var numberOneButton: UIButton = makeNumberButton(type: .one)
    private lazy var numberTwoButton: UIButton = makeNumberButton(type: .two)
    private lazy var numberThreeButton: UIButton = makeNumberButton(type: .three)
    private lazy var numberFourButton: UIButton = makeNumberButton(type: .four)
    private lazy var numberFiveButton: UIButton = makeNumberButton(type: .five)
    private lazy var numberSixButton: UIButton = makeNumberButton(type: .six)
    private lazy var numberSevenButton: UIButton = makeNumberButton(type: .seven)
    private lazy var numberEightButton: UIButton = makeNumberButton(type: .eight)
    private lazy var numberNineButton: UIButton = makeNumberButton(type: .nine)
    private lazy var symbolPointButton: UIButton = makeNumberButton(type: .point)

    private lazy var plusButton: UIButton = makeOperatorButton(type: .plus)
    private lazy var minusButton: UIButton = makeOperatorButton(type: .minus)
    private lazy var multiplyButton: UIButton = makeOperatorButton(type: .multiply)
    private lazy var divideButton: UIButton = makeOperatorButton(type: .divide)
    
    private var acButton: UIButton = UIButton(type: .system)
    //正負符號switch
    private var symbolSwitchButton: UIButton = UIButton(type: .system)
    private var symbolEqualButton: UIButton = UIButton(type: .system)
    
    private var previousNumberString: UILabel = UILabel()
    private var resultBar: UILabel = UILabel()
    //Decimal?
    private var resultNumber: Decimal? = 0
    private var currentNumber: Decimal = 0
    private var previousNumber: Decimal = 0
    private var currentOperator: OperatorTypes = OperatorTypes.none
    private var isCalculateStarted: Bool = false
    
    private func makeOperatorButton(type: OperatorTypes) -> UIButton {
        let button = UIButton()
        
        button.layer.cornerRadius = 6
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.systemBlue.cgColor
        button.setTitleColor(.systemBlue, for: .normal)
        button.setTitleColor(.red, for: .selected)
        button.setTitle(type.title(), for: .normal)
        button.tag = type.tag()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(pressedOperatorButton), for: .touchUpInside)
        
        return button
    }
    
    private func makeNumberButton(type: NumberType) -> UIButton {
        let button = UIButton()
        
        if let content = type.content() {
            button.setTitle(content, for: .normal)
        } else {
            button.setTitle("沒有值", for: .normal)
        }
        
        button.layer.cornerRadius = 6
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.systemBlue.cgColor
        button.setTitleColor(.systemBlue, for: .normal)
        button.tag = type.tag()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(pressNumberButton), for: .touchUpInside)
        
        return button
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = .white
        setupView()
        initConstraints()
    }
    
    private func setupView() {
        resultBar.text = "0"
        resultBar.translatesAutoresizingMaskIntoConstraints = false
        
        acButton.setTitle("AC", for: .normal)
        acButton.translatesAutoresizingMaskIntoConstraints = false
        acButton.addTarget(self, action: #selector(pressedACButton), for: .touchUpInside)
        acButton.layer.cornerRadius = 6
        acButton.layer.borderWidth = 1
        acButton.layer.borderColor = UIColor.systemBlue.cgColor
        
        symbolSwitchButton.setTitle("+/-", for: .normal)
        symbolSwitchButton.translatesAutoresizingMaskIntoConstraints = false
        symbolSwitchButton.addTarget(self, action: #selector(pressedSymbolSwitchButton), for: .touchUpInside)
        symbolSwitchButton.layer.cornerRadius = 6
        symbolSwitchButton.layer.borderWidth = 1
        symbolSwitchButton.layer.borderColor = UIColor.systemBlue.cgColor
        
        symbolEqualButton.setTitle("=", for: .normal)
        symbolEqualButton.translatesAutoresizingMaskIntoConstraints = false
        symbolEqualButton.addTarget(self, action: #selector(pressedEqualButton), for: .touchUpInside)
        symbolEqualButton.layer.cornerRadius = 6
        symbolEqualButton.layer.borderWidth = 1
        symbolEqualButton.layer.borderColor = UIColor.systemBlue.cgColor
    }
    
    private func initConstraints() {
        
        view.addSubview(resultBar)
        view.addSubview(numberZeroButton)
        view.addSubview(numberOneButton)
        view.addSubview(numberTwoButton)
        view.addSubview(numberThreeButton)
        view.addSubview(numberFourButton)
        view.addSubview(numberFiveButton)
        view.addSubview(numberSixButton)
        view.addSubview(numberSevenButton)
        view.addSubview(numberEightButton)
        view.addSubview(numberNineButton)
        view.addSubview(numberDoubleZeroButton)
        view.addSubview(plusButton)
        view.addSubview(minusButton)
        view.addSubview(multiplyButton)
        view.addSubview(divideButton)
        view.addSubview(symbolSwitchButton)
        view.addSubview(acButton)
        view.addSubview(symbolPointButton)
        view.addSubview(symbolEqualButton)
        
        resultBar.snp.makeConstraints({ make in
            make.top.equalTo(self.view.layoutMarginsGuide).offset(20)
            make.right.equalTo(self.view.layoutMarginsGuide).offset(-20)
        })
        
        for view in self.view.subviews as [UIView] {
            if let btn = view as? UIButton {
                btn.snp.makeConstraints { make in
                    make.width.height.equalTo(75)
                }
            }
        }
        
        acButton.snp.makeConstraints { make in
            make.top.equalTo(self.view.layoutMarginsGuide).offset(200)
            make.left.equalTo(self.view.layoutMarginsGuide).offset(20)
        }
        
        symbolSwitchButton.snp.makeConstraints { make in
            make.top.equalTo(acButton)
            make.left.equalTo(acButton).offset(screenWidth/5)
        }
        
        plusButton.snp.makeConstraints { make in
            make.top.equalTo(symbolSwitchButton)
            make.right.equalTo(symbolSwitchButton).offset((screenWidth/5) * 2)
        }
        
        numberSevenButton.snp.makeConstraints { make in
            make.top.equalTo(acButton).offset(screenHeight/7.5)
            make.left.equalTo(acButton)
        }
        
        numberEightButton.snp.makeConstraints { make in
            make.top.equalTo(numberSevenButton)
            make.left.equalTo(numberSevenButton).offset(screenWidth/5)
        }
        
        numberNineButton.snp.makeConstraints { make in
            make.top.equalTo(numberSevenButton)
            make.left.equalTo(numberEightButton).offset(screenWidth/5)
        }
        
        minusButton.snp.makeConstraints { make in
            make.top.equalTo(numberNineButton)
            make.left.equalTo(numberNineButton).offset(screenWidth/5)
        }
        
        numberFourButton.snp.makeConstraints { make in
            make.top.equalTo(numberSevenButton).offset(screenHeight/7.5)
            make.left.equalTo(numberSevenButton)
        }
        
        numberFiveButton.snp.makeConstraints { make in
            make.top.equalTo(numberFourButton)
            make.left.equalTo(numberFourButton).offset(screenWidth/5)
        }
        
        numberSixButton.snp.makeConstraints { make in
            make.top.equalTo(numberFiveButton)
            make.left.equalTo(numberFiveButton).offset(screenWidth/5)
        }
        
        multiplyButton.snp.makeConstraints { make in
            make.top.equalTo(numberSixButton)
            make.left.equalTo(numberSixButton).offset(screenWidth/5)
        }
        
        numberOneButton.snp.makeConstraints { make in
            make.top.equalTo(numberFourButton).offset(screenHeight/7.5)
            make.left.equalTo(numberFourButton)
        }
        
        numberTwoButton.snp.makeConstraints { make in
            make.top.equalTo(numberOneButton)
            make.left.equalTo(numberOneButton).offset(screenWidth/5)
        }
        
        numberThreeButton.snp.makeConstraints { make in
            make.top.equalTo(numberTwoButton)
            make.left.equalTo(numberTwoButton).offset(screenWidth/5)
        }
        
        divideButton.snp.makeConstraints { make in
            make.top.equalTo(numberThreeButton)
            make.left.equalTo(numberThreeButton).offset(screenWidth/5)
        }
        
        numberZeroButton.snp.makeConstraints { make in
            make.top.equalTo(numberOneButton).offset(screenHeight/7.5)
            make.left.equalTo(numberOneButton)
        }
        
        numberDoubleZeroButton.snp.makeConstraints { make in
            make.top.equalTo(numberZeroButton)
            make.left.equalTo(numberZeroButton).offset(screenWidth/5)
        }
        
        symbolPointButton.snp.makeConstraints { make in
            make.top.equalTo(numberDoubleZeroButton)
            make.left.equalTo(numberDoubleZeroButton).offset(screenWidth/5)
        }
        
        symbolEqualButton.snp.makeConstraints { make in
            make.top.equalTo(symbolPointButton)
            make.left.equalTo(symbolPointButton).offset(screenWidth/5)
        }
        
    }

    @objc func pressedACButton() {
        currentNumber = 0
        previousNumber = 0
        currentOperator = OperatorTypes.none
        resultBar.text = "0"
        isCalculateStarted = false
        disableSelectedButton()
    }
    
    @objc func pressNumberButton(sender: UIButton) {
        //TODO: resultBar limit
        if let inputString = sender.titleLabel?.text,
           let resultBarText = resultBar.text {
            
            var addedNumberString = resultBarText

            if inputString == "." {
                
                if resultBarText.contains(".") {
                } else {
                    addedNumberString += inputString
                    resultBar.text = addedNumberString
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
                    resultBar.text = addedNumberString
                    currentNumber = decimalResultNumber
                } else {
                    if inputString == "." {
                        resultBar.text = formattedResultNumberString + "."
                    } else {
                        resultBar.text = formattedResultNumberString
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
        resultBar.text = "0"
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
            resultBar.text = "錯誤"
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
        
        resultBar.text = "\(formattedString)"
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
        
        resultBar.text = "\(formattedString)"
    }
    
    private func addNumber(inputString: String) -> String {
        
        guard var resultString = resultBar.text else {
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
//        formatter.usesSignificantDigits = true
//        formatter.maximumFractionDigits = 4
//        formatter.maximumSignificantDigits = 4
        formatter.allowsFloats = true
        formatter.numberStyle = .decimal
        formatter.groupingSize = 3
        formatter.maximumFractionDigits = 8
        
        if let nsNumberOfString = formatter.number(from: string) {
            formattedString = formatter.string(from: nsNumberOfString) ?? ""
        }
        
//        var h:Decimal = 123456789
//        print(h.significand)
//        let dd = NSDecimalNumber(value: h)
//        let anotherNumber = dd.floatValue
//            print(anotherNumber)
        
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
        
        for view in self.view.subviews as [UIView] {
            if let btn = view as? UIButton {
                if btn.isSelected {
                    btn.isSelected = false
                }
            }
        }
    }

}

//
//  CalcView.swift
//  Calc Remaster
//
//  Created by Kai on 2022/3/18.
//

import UIKit
import SnapKit

class CalcView: UIView {

    private var screenWidth = UIScreen.main.bounds.width
    private var screenHeight = UIScreen.main.bounds.height
    
    lazy var numberZeroButton: UIButton = makeNumberButton(type: .zero)
    lazy var numberDoubleZeroButton: UIButton = makeNumberButton(type: .doubleZero)
    lazy var numberOneButton: UIButton = makeNumberButton(type: .one)
    lazy var numberTwoButton: UIButton = makeNumberButton(type: .two)
    lazy var numberThreeButton: UIButton = makeNumberButton(type: .three)
    lazy var numberFourButton: UIButton = makeNumberButton(type: .four)
    lazy var numberFiveButton: UIButton = makeNumberButton(type: .five)
    lazy var numberSixButton: UIButton = makeNumberButton(type: .six)
    lazy var numberSevenButton: UIButton = makeNumberButton(type: .seven)
    lazy var numberEightButton: UIButton = makeNumberButton(type: .eight)
    lazy var numberNineButton: UIButton = makeNumberButton(type: .nine)
    lazy var symbolPointButton: UIButton = makeNumberButton(type: .point)

    lazy var plusButton: UIButton = makeOperatorButton(type: .plus)
    lazy var minusButton: UIButton = makeOperatorButton(type: .minus)
    lazy var multiplyButton: UIButton = makeOperatorButton(type: .multiply)
    lazy var divideButton: UIButton = makeOperatorButton(type: .divide)
    
    var acButton: UIButton = UIButton(type: .system)
    //正負符號switch
    var symbolSwitchButton: UIButton = UIButton(type: .system)
    var symbolEqualButton: UIButton = UIButton(type: .system)
    
    var previousNumberString: UILabel = UILabel()
    var resultBar: UILabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
        initConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        resultBar.text = "0"
        resultBar.translatesAutoresizingMaskIntoConstraints = false
        
        acButton.setTitle("AC", for: .normal)
        acButton.translatesAutoresizingMaskIntoConstraints = false
        acButton.layer.cornerRadius = 6
        acButton.layer.borderWidth = 1
        acButton.layer.borderColor = UIColor.systemBlue.cgColor
        
        symbolSwitchButton.setTitle("+/-", for: .normal)
        symbolSwitchButton.translatesAutoresizingMaskIntoConstraints = false
        
        symbolSwitchButton.layer.cornerRadius = 6
        symbolSwitchButton.layer.borderWidth = 1
        symbolSwitchButton.layer.borderColor = UIColor.systemBlue.cgColor
        
        symbolEqualButton.setTitle("=", for: .normal)
        symbolEqualButton.translatesAutoresizingMaskIntoConstraints = false
        
        symbolEqualButton.layer.cornerRadius = 6
        symbolEqualButton.layer.borderWidth = 1
        symbolEqualButton.layer.borderColor = UIColor.systemBlue.cgColor
    }
    
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
        
        return button
    }
    
    private func initConstraints() {
        
        self.addSubview(resultBar)
        self.addSubview(numberZeroButton)
        self.addSubview(numberOneButton)
        self.addSubview(numberTwoButton)
        self.addSubview(numberThreeButton)
        self.addSubview(numberFourButton)
        self.addSubview(numberFiveButton)
        self.addSubview(numberSixButton)
        self.addSubview(numberSevenButton)
        self.addSubview(numberEightButton)
        self.addSubview(numberNineButton)
        self.addSubview(numberDoubleZeroButton)
        self.addSubview(plusButton)
        self.addSubview(minusButton)
        self.addSubview(multiplyButton)
        self.addSubview(divideButton)
        self.addSubview(symbolSwitchButton)
        self.addSubview(acButton)
        self.addSubview(symbolPointButton)
        self.addSubview(symbolEqualButton)
        
        resultBar.snp.makeConstraints({ make in
            make.top.equalTo(self.layoutMarginsGuide).offset(20)
            make.right.equalTo(self.layoutMarginsGuide).offset(-20)
        })
        
        for view in self.subviews as [UIView] {
            if let btn = view as? UIButton {
                btn.snp.makeConstraints { make in
                    make.width.height.equalTo(75)
                }
            }
        }
        
        acButton.snp.makeConstraints { make in
            make.top.equalTo(self.layoutMarginsGuide).offset(200)
            make.left.equalTo(self.layoutMarginsGuide).offset(20)
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
    
}

//
//  CustomButton.swift
//
//  Copyright © 2024 Jumio Corporation. All rights reserved.
//

import UIKit

class CustomButton: UIButton {
    private struct Config {
        static let positiveColor: UIColor = .systemBlue
        static let positiveTextColor: UIColor = .white
        static let positiveBorderColor: UIColor = .systemBlue
        
        static let negativeColor: UIColor = .clear
        static let negativeTextColor: UIColor = .systemBlue
        static let negativeBorderColor: UIColor = .systemBlue
        
        static let inactiveColor: UIColor = .lightGray
        static let inactiveTextColor: UIColor = .white
        static let inactiveBorderColor: UIColor = .lightGray
    }
    
    enum Design {
        case positive
        case negative
        case inactive
    }
    
    var design: Design = .positive {
        didSet {
            update()
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        update()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        update()
    }
    
    private func update() {
        layer.cornerRadius = 10
        layer.borderWidth = 1.0
        switch design {
        case .positive:
            backgroundColor = Config.positiveColor
            setTitleColor(Config.positiveTextColor, for: .normal)
            layer.borderColor = Config.positiveBorderColor.cgColor
        case .negative:
            backgroundColor = Config.negativeColor
            setTitleColor(Config.negativeTextColor, for: .normal)
            layer.borderColor = Config.negativeBorderColor.cgColor
        case .inactive:
            backgroundColor = Config.inactiveColor
            setTitleColor(Config.negativeColor, for: .normal)
            layer.borderColor = Config.inactiveBorderColor.cgColor
        }
        setTitle(titleLabel?.text?.uppercased(), for: .normal)
    }
}

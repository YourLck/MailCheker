//
//  VerificationButton.swift
//  MailCheck
//
//  Created by Nikita Nemtsu on 08.04.2023.
//

import Foundation
import UIKit

class VerificationButton: UIButton {
    
    public var isValid = false {
        didSet {
            if self.isValid {
                setValidSettings()
            } else {
                setNotValidSettings()
            }
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        backgroundColor = #colorLiteral(red: 0.9686274529, green: 0.78039217, blue: 0.3450980484, alpha: 1)
        setTitle("Verification Button", for: .normal)
        layer.cornerRadius = 10
        titleLabel?.font = .boldSystemFont(ofSize: 17)
        isEnabled = false
        alpha = 0.5
        translatesAutoresizingMaskIntoConstraints = false 
    }
    
    private func setNotValidSettings() {
        isEnabled = false
        alpha = 0.5
    }
    
    private func setValidSettings() {
        isEnabled = true
        alpha = 1
    }
    
    public func setDefaultSetting() {
        configure()
    }
}

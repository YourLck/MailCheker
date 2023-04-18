//
//  StatusLabel.swift
//  MailCheck
//
//  Created by Nikita Nemtsu on 07.04.2023.
//

import UIKit

class StatusLabel: UILabel {
    
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
        text = "Check your mail"
        textColor = #colorLiteral(red: 0.9450980392, green: 0.9333333333, blue: 0.862745098, alpha: 1)
        font = .boldSystemFont(ofSize: 16)
        adjustsFontSizeToFitWidth = true
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    private func setNotValidSettings() {
        text = "Mail is not valid. Example: name@domain.com"
        textColor = #colorLiteral(red: 0.5725490451, green: 0, blue: 0.2313725501, alpha: 1)
    }
    
    private func setValidSettings() {
        text = "Mail is valid."
        textColor = #colorLiteral(red: 0.5843137503, green: 0.8235294223, blue: 0.4196078479, alpha: 1)
    }
    
    public func setDefaultSetting() {
        configure()
    }
}

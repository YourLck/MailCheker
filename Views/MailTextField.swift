//
//  MailTextField.swift
//  MailCheck
//
//  Created by Nikita Nemtsu on 08.04.2023.
//

import UIKit

class MailTextField: UITextField {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        backgroundColor = .white
        borderStyle = .none
        layer.cornerRadius = 10
        textColor = .red //373737
        leftView = UIView(frame: CGRect(x: 0,
                                        y: 0,
                                        width: 15,
                                        height: self.frame.height))
        leftViewMode = .always
        clearButtonMode = .always
        returnKeyType = .done
        placeholder = "Entar mail"
        font = .boldSystemFont(ofSize: 20)
        tintColor = .red // 808080
        translatesAutoresizingMaskIntoConstraints = false
    }
}

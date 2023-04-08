//
//  VerificationButton.swift
//  MailCheck
//
//  Created by Nikita Nemtsu on 08.04.2023.
//

import Foundation
import UIKit

class VerificationButton: UIButton {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        backgroundColor = .brown
        setTitle("Verification Button", for: .normal)
//        let color = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        layer.cornerRadius = 10
        titleLabel?.font = .boldSystemFont(ofSize: 17)
//        isEnabled = false
        alpha = 0.5
        translatesAutoresizingMaskIntoConstraints = false 
    }
}
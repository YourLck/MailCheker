//
//  String.swift
//  MailCheck
//
//  Created by Nikita Nemtsu on 14.04.2023.
//

import Foundation

extension String {
    func isValid() -> Bool {
        let format = "SELF MATCHES %@"
        let regEx = "[a-zA-Z0-9._]+@[a-zA-Z]+\\.[a-zA-Z]{2,}"
//        let regEx = "[(a-zA-Z0-9._)"
        return NSPredicate(format: format, regEx).evaluate(with: self)
    }
}
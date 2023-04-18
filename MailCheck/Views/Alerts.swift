//
//  Alerts.swift
//  MailCheck
//
//  Created by Nikita Nemtsu on 18.04.2023.
//

import Foundation
import UIKit

struct Alert {
    
    private static func showSimpleAlert(vc: UIViewController, title: String, message: String) {
        
        let alertController = UIAlertController(title: title,
                                                message: message,
                                                preferredStyle: .alert)
        
        let ok = UIAlertAction(title: "OK", style: .default)
        alertController.addAction(ok)
        DispatchQueue.main.async {
            vc.present(alertController, animated: true, completion: nil)
        }
    }
    
    private static func showChangeAlert(vc: UIViewController, title: String, message: String, complition: @escaping() -> Void) {
        
        let alertController = UIAlertController(title: title,
                                                message: message,
                                                preferredStyle: .alert)
        
        let ok = UIAlertAction(title: "OK", style: .default) {_ in
            complition()
        }
        let cancel = UIAlertAction(title: "Cancel", style: .cancel)
        alertController.addAction(cancel)
        alertController.addAction(ok)
        DispatchQueue.main.async {
            vc.present(alertController, animated: true, completion: nil)
        }
    }
    
    static func showResultAlert(vc: UIViewController, message: String) {
        showSimpleAlert(vc: vc, title: "Result", message: message)
    }
    
    static func showErrorAlert(vc: UIViewController, message: String, complition: @escaping() -> Void) {
        showChangeAlert(vc: vc, title: "Error", message: message, complition: complition)
    }
}

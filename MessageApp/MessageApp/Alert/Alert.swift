//
//  Alert.swift
//  MessageApp
//
//  Created by Kaue de Assis Jacyntho on 18/11/22.
//

import UIKit

class Alert: NSObject {
    
    var controller: UIViewController
    
    init(controller: UIViewController) {
        self.controller = controller
    }
    
    func getAlert(title: String, message: String, completion: (() -> Void)? = nil) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let cancel = UIAlertAction(title: "OK", style: .cancel) { action in
            completion?()
        }
        alertController.addAction(cancel)
        self.controller.present(alertController, animated: true, completion: nil)
    }
    
    
}

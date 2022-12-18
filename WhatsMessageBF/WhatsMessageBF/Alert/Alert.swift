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
    
    func addContact(completion:((_ value: String) -> Void)? = nil){
        var _textField: UITextField?
        let alert = UIAlertController(title: "Adicionar Usuário", message: "Digite um email válido", preferredStyle: .alert)
        let ok = UIAlertAction(title: "Adicionar", style: .default) { (action) in
            completion?(_textField?.text ?? "")
        }
        let cancel = UIAlertAction(title: "Cancelar", style: .cancel, handler: nil)
        alert.addAction(cancel)
        alert.addAction(ok)
        alert.addTextField(configurationHandler: {(textField: UITextField) in
            _textField = textField
            textField.placeholder = "Email:"
        })
        self.controller.present(alert, animated: true, completion: nil)
    }
}

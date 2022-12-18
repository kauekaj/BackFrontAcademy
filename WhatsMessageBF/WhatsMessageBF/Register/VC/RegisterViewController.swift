//
//  RegisterViewController.swift
//  MessageApp
//
//  Created by Kaue de Assis Jacyntho on 07/11/22.
//

import UIKit
import Firebase

class RegisterViewController: UIViewController {

    var registerScreen: RegisterScreen?
    var auth: Auth?
    var firestore: Firestore?
    var alert: Alert?

    override func loadView() {
        registerScreen = RegisterScreen()
        view = registerScreen
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        registerScreen?.configTextFieldDelegate(delegate: self)
        registerScreen?.delegate(delegate: self)
        auth = Auth.auth()
        firestore = Firestore.firestore()
        alert = Alert(controller: self)
    }
    
}

extension RegisterViewController: UITextFieldDelegate {
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        registerScreen?.validateTextfields()
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}

extension RegisterViewController: RegisterScreenProtocol {
    func actionBackButton() {
        navigationController?.popViewController(animated: true)
    }
    
    func actionRegisterButton() {
        
        guard let register = registerScreen else { return }
  
        auth?.createUser(withEmail: register.getEmail(), password: register.getPassword(), completion: { result, error in
            if error != nil {
                self.alert?.getAlert(title: "Atençao", message: "Erro ao cadastrar, verifique os dados e tente novamente.")
            } else {
                
                // save date into Firabase
                
                if let userId = result?.user.uid {
                    self.firestore?.collection("users").document(userId).setData([
                        "name": self.registerScreen?.getName() ?? "",
                        "email": self.registerScreen?.getEmail() ?? "",
                        "id": userId
                    ])
                }
                
                
                self.alert?.getAlert(title: "Parabéns", message: "Cadastro realizado com sucesso", completion: {
                    let VC = HomeViewController()
                    let navVC = UINavigationController(rootViewController: VC)
                    navVC.modalPresentationStyle = .fullScreen
                    self.present(navVC, animated: true, completion: nil)
                })
            }
        })
    }
    
    
}

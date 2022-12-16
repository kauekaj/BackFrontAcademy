//
//  ContactController.swift
//  WhatsMessageBF
//
//  Created by Kaue de Assis Jacyntho on 16/12/22.
//

import Foundation
import UIKit
import FirebaseFirestore

protocol ContactControllerProtocol: AnyObject {
    func alertStateError(title: String, message: String)
    func sucessContact()
}

class ContactController {
    
    weak var delegate: ContactControllerProtocol?
    
    public func delegate(delegate: ContactControllerProtocol) {
        self.delegate = delegate
    }
    
    func addContact(email: String, loggedUserEmail: String, userID: String) {
        
        if email == loggedUserEmail {
            self.delegate?.alertStateError(title: "Voce adicionou seu próprio email", message: "Verifique o email informado e tente novamente")
            return
        }
        
        
        //Check if user exists in Firebase
        let firestore = Firestore.firestore()
        firestore.collection("users").whereField("email", isEqualTo: email).getDocuments { snapshotresult, error in
            
            
            //check account
            if let totalItens = snapshotresult?.count {
                if totalItens == 0 {
                    self.delegate?.alertStateError(title: "Usuario nao cadastrado", message: "Adicione um email diferente")
                    return
                }
            }
            
            //save contact
            if let snapshot = snapshotresult {
                for document in snapshot.documents {
                    let data = document.data()
                    self.saveContact(contactData: data, userID: userID)
                }
            }
        }
    }
    
    func saveContact(contactData: Dictionary<String, Any>, userID: String) {
        
        let contact: Contact = Contact(dictionary: contactData)
        let firestore = Firestore.firestore()
        firestore.collection("users").document(userID).collection("contacts").document(contact.id ?? "").setData(contactData) { error in
            if error == nil {
                self.delegate?.sucessContact()

            }
        }
    }
}

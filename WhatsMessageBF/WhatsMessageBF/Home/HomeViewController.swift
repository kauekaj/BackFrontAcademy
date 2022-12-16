//
//  HomeViewController.swift
//  WhatsMessageBF
//
//  Created by Kaue de Assis Jacyntho on 15/12/22.
//

import UIKit
import Firebase

class HomeViewController: UIViewController {
    
    var homeScreen: HomeScreen?
    
    var auth: Auth?
    var db: Firestore?
    var loggedUserID: String?
    
    var screenContact: Bool?
    var loggedUseremail: String?
    var alert: Alert?
    
    var contact: ContactController?
    var contactList: [Contact] = []
    var conversationList: [Conversation] = []
    var conversationListener: ListenerRegistration?
    
    
    override func loadView() {
        self.homeScreen = HomeScreen()
        self.view = self.homeScreen
        self.configHomeView()
        self.configCollectionView()
        self.configAlert()
        self.configIdentifierFirebase()
        self.addListenerGetConversation()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.isHidden = true
        self.view.backgroundColor = CustomColor.appLight
    }
    
    private func configHomeView() {
        self.homeScreen?.navigationView.delegate(delegate: self)
    }
    
    private func configCollectionView() {
        self.homeScreen?.delegateCollectionView(delegate: self, dataSource: self)
    }
    
    private func configAlert() {
        self.alert = Alert(controller: self)
    }
    
    private func configIdentifierFirebase() {
        self.auth = Auth.auth()
        self.db = Firestore.firestore()
        
        //get logged user
        if let currentUser = auth?.currentUser {
            self.loggedUserID = currentUser.uid
            self.loggedUseremail = currentUser.email
        }
    }
    
    private func configContact() {
        self.contact = ContactController()
        self.contact?.delegate(delegate: self)
    }
    
    func getContact() {
        self.contactList.removeAll()
        self.db?.collection("users").document(self.loggedUserID ?? "").collection("contacts").getDocuments(completion: { snapshotResult, error in
            
            if error != nil {
                print("error getContact")
                return
            }
            
            if let snapshot = snapshotResult {
                for document in snapshot.documents {
                    let contactData = document.data()
                    self.contactList.append(Contact(dictionary: contactData))
                }
                self.homeScreen?.reloadCollectionView()
            }
        })
    }
    
    func addListenerGetConversation() {
        
        if let loggedUserID = auth?.currentUser?.uid {
            self.conversationListener = db?.collection("Conversation").document(loggedUserID).collection("lastConversation").addSnapshotListener({ querySnapshot, error in
                
                if error == nil {
                    
                    self.conversationList.removeAll()
                    
                    if let snapshot = querySnapshot {
                        for document in snapshot.documents {
                            let data = document.data()
                            self.conversationList.append(Conversation(dictionary: data))
                        }
                    }
                }
            })
        }
    }
    
}

extension HomeViewController: NavigationViewProtocol {
    func typeScreenMessage(type: TypeConversationOrContact) {
        
        switch type {
        case .contact:
            self.screenContact = true
            self.getContact()
        case .conversation:
            self.screenContact = false
            self.addListenerGetConversation()
            self.homeScreen?.reloadCollectionView()
        }
    }
}

extension HomeViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print(indexPath)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: 100)
    }
    
}

extension HomeViewController: ContactControllerProtocol {
    func alertStateError(title: String, message: String) {
        self.alert?.getAlert(title: title, message: message)
    }
    
    func sucessContact() {
        self.alert?.getAlert(title: "Parabéns", message: "Usuário cadastradp com sucesso", completion: {
            self.getContact()
        })
    }
    
    
}

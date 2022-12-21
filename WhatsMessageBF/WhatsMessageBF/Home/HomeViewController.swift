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
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.isHidden = true
        self.view.backgroundColor = CustomColor.appLight
        self.configHomeView()
        self.configCollectionView()
        self.configAlert()
        self.configIdentifierFirebase()
        self.configContact()
        self.addListenerGetConversation()
        print(conversationList)
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
                    print(contactData)
                }
                self.homeScreen?.reloadCollectionView()
            }
        })
    }

    func addListenerGetConversation() {

        if let loggedUserID = auth?.currentUser?.uid {
            self.conversationListener = db?.collection("conversation").document(loggedUserID).collection("lastConversation").addSnapshotListener({ querySnapshot, error in

                if error == nil {

                    self.conversationList.removeAll()

                    if let snapshot = querySnapshot {
                        for document in snapshot.documents {
                            let data = document.data()
                            self.conversationList.append(Conversation(dictionary: data))
                        }
                        self.homeScreen?.reloadCollectionView()
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
            self.conversationListener?.remove()
        case .conversation:
            self.screenContact = false
            self.addListenerGetConversation()
            self.homeScreen?.reloadCollectionView()
        }
    }
}

extension HomeViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {

        if self.screenContact ?? false {
            return self.contactList.count + 1
        } else {
            print(conversationList.count)

            return self.conversationList.count
        }
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        if self.screenContact ?? false {
            if indexPath.row == self.contactList.count {
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: LastMessageCollectionViewCell.identifier, for: indexPath)
                return cell

            } else {
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MessageDetailCollectionViewCell.identifier, for: indexPath) as? MessageDetailCollectionViewCell
                cell?.setupViewContact(contact: self.contactList[indexPath.row])
                return cell ?? UICollectionViewCell()
            }
        } else {
            // Conversation Cell
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MessageDetailCollectionViewCell.identifier, for: indexPath) as? MessageDetailCollectionViewCell
            cell?.setupViewConversation(conversation: self.conversationList[indexPath.row])
            return cell ?? UICollectionViewCell()
        }
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if self.screenContact ?? false {
            if indexPath.row == self.contactList.count {
                self.alert?.addContact(completion: { value in
                    self.contact?.addContact(email: value, loggedUserEmail: self.loggedUseremail ?? "", userID: self.loggedUserID ?? "")
                })
            } else {
                let VC: ChatViewController = ChatViewController()
                VC.contact = self.contactList[indexPath.row]
                self.navigationController?.pushViewController(VC, animated: true)
            }
        } else {
            let VC: ChatViewController = ChatViewController()
            let data = self.conversationList[indexPath.row]
            let contact: Contact = Contact(id: data.recipientID ?? "", name: data.userName ?? "")
            VC.contact = contact
            self.navigationController?.pushViewController(VC, animated: true)
        }
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

//
//  ChatViewController.swift
//  WhatsMessageBF
//
//  Created by Kaue de Assis Jacyntho on 18/12/22.
//

import UIKit
import Firebase
import AVFoundation

class ChatViewController: UIViewController {

    var messageList:[Message] = []
    var loggedUserID: String?
    var contact: Contact?
    var messageListener: ListenerRegistration?
    var auth: Auth?
    var db: Firestore?
    var contactName: String?
    var loggedUserName: String?

    var chatViewScreen: ChatViewScreen?
   
    override func loadView() {
        self.chatViewScreen = ChatViewScreen()
        self.view = chatViewScreen
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configDataFirebase()
        self.configChatView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.addListenerGetMessages()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        self.messageListener?.remove()
    }
    
    func addListenerGetMessages() {
        
        if let recipientID = self.contact?.id {
            
            messageListener = db?.collection("messages").document(self.loggedUserID ?? "").collection(recipientID).order(by: "date",descending: true).addSnapshotListener({ querySnapshot, error in
                
                //limpar lista
                self.messageList.removeAll()
                
                //Recuperar dados
                if let snapshot = querySnapshot{
                    for document in snapshot.documents {
                        let data = document.data()
                        self.messageList.append(Message(dictionary: data))
                    }
                    self.chatViewScreen?.reloadTableView()
                }
            })
        }
    }
    
    private func configDataFirebase() {
        self.auth = Auth.auth()
        self.db = Firestore.firestore()
        
        
        //Recuperar Id Usuario Logado
        if let id = self.auth?.currentUser?.uid{
            self.loggedUserID = id
            self.getLoggedUserData()
        }
        
        if let name = self.contact?.name{
            self.contactName = name
        }
        
        
    }
    
    private func getLoggedUserData(){
        let users = self.db?.collection("users").document(self.loggedUserID ?? "")
        users?.getDocument(completion: { documentSnapshot, error in
            if error == nil{
                let data: Contact = Contact(dictionary: documentSnapshot?.data() ?? [:])
                self.loggedUserName = data.name ?? ""
            }
        })
    }
    
    private func configChatView(){
        self.chatViewScreen?.configNavigationView(controller: self)
        self.chatViewScreen?.configTableView(delegate: self, dataSource: self)
        self.chatViewScreen?.delegate(delegate: self)
    }
    
    @objc
    func tappedBackButton() {
        self.navigationController?.popToRootViewController(animated: true)
    }
    
    private func saveMessage(senderID: String, recipientID: String, message: [String:Any]) {
        db?.collection("messages").document(senderID).collection(recipientID).addDocument(data: message)
        //limpar caixa de texto
        chatViewScreen?.inputMessageTextField.text = ""
    }
    
    private func saveConversation(senderID: String, recipientID: String, conversation: [String:Any]) {
        db?.collection("conversation").document(senderID).collection("lastConversation").document(recipientID).setData(conversation)
        
    }

}


extension ChatViewController: UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.messageList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let index = indexPath.row
        let data = self.messageList[index]
        let userID = data.userID ?? ""
        
        
        if self.loggedUserID != userID {
            //LADO ESQUERDO
            let cell = tableView.dequeueReusableCell(withIdentifier: IncomingTextMessageTableViewCell.identifier, for: indexPath) as? IncomingTextMessageTableViewCell
            cell?.transform = CGAffineTransform(scaleX: 1, y: -1)
            cell?.setupCell(message: data)
            cell?.selectionStyle = .none
            return cell ?? UITableViewCell()
        } else {
            //LADO DIREITO
            let cell = tableView.dequeueReusableCell(withIdentifier: OutgoingTextMessageTableViewCell.identifier, for: indexPath) as? OutgoingTextMessageTableViewCell
            cell?.transform = CGAffineTransform(scaleX: 1, y: -1)
            cell?.setupCell(message: data)
            cell?.selectionStyle = .none
            return cell ?? UITableViewCell()
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let desc: String = self.messageList[indexPath.row].text ?? ""
        let font = UIFont(name: CustomFont.poppinsSemiBold, size: 14) ?? UIFont()
        let estimateHeight = desc.heightWithConstrainedWidth(width: 220, font: font)
        return CGFloat(65 + estimateHeight)
    }
}

extension ChatViewController: ChatViewScreenProtocol{
    
    func actionPushMessage() {
        
        let message: String = self.chatViewScreen?.inputMessageTextField.text ?? ""
        
        if let recipientID = contact?.id {
            
            let msg: Dictionary<String,Any> = [
                "IDUser" : self.loggedUserID ?? "",
                "text" : message,
                "date" : FieldValue.serverTimestamp()
            ]
            
            //mensagem para remetente
            self.saveMessage(senderID: self.loggedUserID ?? "", recipientID: recipientID, message: msg)
            
            //salvar mensagem para destinario
            self.saveMessage(senderID: recipientID, recipientID: self.loggedUserID ?? "", message: msg)
            
            var conversation: Dictionary<String,Any> = [
                "lastMessage" : message
            ]
            
            //salvar conversa para remetente(dados de quem recebe)
            conversation["senderID"] = loggedUserID ?? ""
            conversation["recipientID"] = recipientID
            conversation["userName"] = self.contactName ?? ""
            self.saveConversation(senderID: loggedUserID ?? "", recipientID: recipientID, conversation: conversation)
            
            //salvar conversa para destinatario(dados de quem envia)
            conversation["senderID"] = recipientID
            conversation["recipientID"] = loggedUserID ?? ""
            conversation["userName"] = self.contactName ?? ""
            self.saveConversation(senderID: recipientID, recipientID: loggedUserID ?? "", conversation: conversation)
        }
    }
}

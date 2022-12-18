//
//  ChatViewController.swift
//  WhatsMessageBF
//
//  Created by Kaue de Assis Jacyntho on 18/12/22.
//

import UIKit
import Firebase

class ChatViewController: UIViewController {

    var chatViewScreen: ChatViewScreen?
    
    override func loadView() {
        self.chatViewScreen = ChatViewScreen()
        self.view = chatViewScreen
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    @objc
    func tappedBackButton() {
        self.navigationController?.popToRootViewController(animated: true)
    }


}

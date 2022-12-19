//
//  ChatViewScreen.swift
//  WhatsMessageBF
//
//  Created by Kaue de Assis Jacyntho on 18/12/22.
//

import UIKit
import AVFoundation

protocol ChatViewScreenProtocol: AnyObject {
    func actionPushMessage()
}

class ChatViewScreen: UIView {
    
    weak private var delegate: ChatViewScreenProtocol?
    
    public func delegate(delegate:ChatViewScreenProtocol?){
        self.delegate = delegate
    }
    
    var bottomConstraint: NSLayoutConstraint?
    var player: AVAudioPlayer?
    
    lazy var navigationView: ChatNavigationView = {
        let element = ChatNavigationView()
        element.translatesAutoresizingMaskIntoConstraints = false
        return element
    }()
    
    lazy var messageInputView: UIView = {
        let element = UIView()
        element.translatesAutoresizingMaskIntoConstraints = false
        element.backgroundColor = .white
        return element
    }()
    
    lazy var messageBar: UIView = {
        let element = UIView()
        element.translatesAutoresizingMaskIntoConstraints = false
        element.backgroundColor = CustomColor.appLight
        element.layer.cornerRadius = 20
        return element
    }()
    
    lazy var sendButton: UIButton = {
        let element = UIButton()
        element.translatesAutoresizingMaskIntoConstraints = false
        element.backgroundColor = CustomColor.appPink
        element.layer.cornerRadius = 22.5
        element.layer.shadowColor = CustomColor.appPink.cgColor
        element.layer.shadowRadius = 10
        element.layer.shadowOffset = CGSize(width: 0, height: 5)
        element.layer.shadowOpacity = 0.3
        element.addTarget(self, action: #selector(self.sendButtonPressed), for: .touchUpInside)
        element.setImage(UIImage(named: "send"), for: .normal)
        return element
    }()
    
    lazy var inputMessageTextField: UITextField = {
        let element = UITextField()
        element.delegate = self
        element.translatesAutoresizingMaskIntoConstraints = false
        element.placeholder = "Digite aqui"
        element.font = UIFont(name: CustomFont.poppinsSemiBold, size: 14)
        element.textColor = .darkGray
        return element
    }()

    lazy var tableView: UITableView = {
        let element = UITableView()
        element.translatesAutoresizingMaskIntoConstraints = false
        element.register(IncomingTextMessageTableViewCell.self, forCellReuseIdentifier: IncomingTextMessageTableViewCell.identifier)
        element.register(OutgoingTextMessageTableViewCell.self, forCellReuseIdentifier: OutgoingTextMessageTableViewCell.identifier)
        element.backgroundColor = .clear
        element.transform = CGAffineTransform(scaleX: 1, y: -1)
        element.separatorStyle = .none
        element.tableFooterView = UIView()
        return element
    }()

    public func configTableView(delegate:UITableViewDelegate,dataSource:UITableViewDataSource){
        self.tableView.delegate = delegate
        self.tableView.dataSource = dataSource
    }
    
    
    public func reloadTableView(){
        self.tableView.reloadData()
    }
    
    func configNavigationView(controller: ChatViewController){
        self.navigationView.controller = controller
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .white
        self.addElemented()
        self.setupContraints()
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.handleKeyboardNotification), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.handleKeyboardNotification), name: UIResponder.keyboardWillHideNotification, object: nil)

        self.inputMessageTextField.addTarget(self, action: #selector(textFieldDidChange), for: UIControl.Event.editingChanged)
        
        self.bottomConstraint = NSLayoutConstraint(item: self.messageInputView, attribute: .bottom, relatedBy: .equal, toItem: self, attribute: .bottom, multiplier: 1, constant: 0)
        
        self.addConstraint(bottomConstraint ?? NSLayoutConstraint())
        self.sendButton.isEnabled = false
        self.sendButton.layer.opacity = 0.4
        self.sendButton.transform = .init(scaleX: 0.8, y: 0.8)
        self.inputMessageTextField.becomeFirstResponder()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func addElemented(){
        self.addSubview(self.tableView)
        self.addSubview(self.navigationView)
        self.addSubview(self.messageInputView)
        self.messageInputView.addSubview(self.messageBar)
        self.messageBar.addSubview(self.sendButton)
        self.messageBar.addSubview(self.inputMessageTextField)
    }
    
    
    private func setupContraints(){
        NSLayoutConstraint.activate([
            
            self.navigationView.topAnchor.constraint(equalTo: self.topAnchor),
            self.navigationView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            self.navigationView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            self.navigationView.heightAnchor.constraint(equalToConstant: 140),
            
            self.tableView.topAnchor.constraint(equalTo: self.navigationView.bottomAnchor),
            self.tableView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            self.tableView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            self.tableView.bottomAnchor.constraint(equalTo: self.messageInputView.topAnchor),
            
            self.messageInputView.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor),
            self.messageInputView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            self.messageInputView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            self.messageInputView.heightAnchor.constraint(equalToConstant: 80),
            
            self.messageBar.leadingAnchor.constraint(equalTo: self.messageInputView.leadingAnchor,constant: 20),
            self.messageBar.trailingAnchor.constraint(equalTo: self.messageInputView.trailingAnchor,constant: -20),
            self.messageBar.heightAnchor.constraint(equalToConstant: 55),
            self.messageBar.centerYAnchor.constraint(equalTo: self.messageInputView.centerYAnchor),
            
            self.sendButton.trailingAnchor.constraint(equalTo: self.messageBar.trailingAnchor, constant: -15),
            self.sendButton.heightAnchor.constraint(equalToConstant: 55),
            self.sendButton.widthAnchor.constraint(equalToConstant: 55),
            self.sendButton.bottomAnchor.constraint(equalTo: self.messageBar.bottomAnchor, constant: -10),
            
            self.inputMessageTextField.leadingAnchor.constraint(equalTo: self.messageBar.leadingAnchor,constant: 20),
            self.inputMessageTextField.trailingAnchor.constraint(equalTo: self.sendButton.leadingAnchor,constant: -5),
            self.inputMessageTextField.heightAnchor.constraint(equalToConstant: 45),
            self.inputMessageTextField.centerYAnchor.constraint(equalTo: self.messageBar.centerYAnchor)
        ])
    }

    @objc
    func handleKeyboardNotification(notification: NSNotification){

        if let keyboardFrame: NSValue = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue {
            let keyboardRectangle = keyboardFrame.cgRectValue
            let keyboardHeight = keyboardRectangle.height

            let isKeyboardShowing = notification.name == UIResponder.keyboardWillShowNotification

            self.bottomConstraint?.constant = isKeyboardShowing ? -keyboardHeight : 0

            self.tableView.center.y = isKeyboardShowing ? self.tableView.center.y-keyboardHeight : self.tableView.center.y+keyboardHeight

            UIView.animate(withDuration:0.1, delay: 0 , options: .curveEaseOut , animations: {
                self.layoutIfNeeded()
            } , completion: {(completed) in
                //Config!!!!!
            })
        }
    }
    
    
    @objc
    func sendButtonPressed(){
        self.sendButton.touchAnimation(s: self.sendButton)
        self.playSound()
        self.delegate?.actionPushMessage()
        self.startPushMessage()
    }
    
    func playSound() {
        guard let url = Bundle.main.url(forResource: "send", withExtension: "wav") else { return }
        do {
            try AVAudioSession.sharedInstance().setCategory(.playback, mode: .default)
            try AVAudioSession.sharedInstance().setActive(true)
            self.player = try AVAudioPlayer(contentsOf: url, fileTypeHint: AVFileType.wav.rawValue)
            guard let player = self.player else { return }
            player.play()
        } catch let error {
            print(error.localizedDescription)
        }
    }

    public func startPushMessage(){
        self.inputMessageTextField.text = ""
        self.sendButton.isEnabled = false
        self.sendButton.layer.opacity = 0.4
        self.sendButton.transform = .init(scaleX: 0.8, y: 0.8)
    }
}


extension ChatViewScreen: UITextFieldDelegate{
    
    //MARK:- Animating
    @objc
    func textFieldDidChange(_ textField: UITextField) {
        if self.inputMessageTextField.text == ""{
            UIView.animate(withDuration: 0.3, delay: 0, usingSpringWithDamping: 0.4, initialSpringVelocity: 0, options: .curveEaseInOut, animations: {
                self.sendButton.isEnabled = false
                self.sendButton.layer.opacity = 0.4
                self.sendButton.transform = .init(scaleX: 0.8, y: 0.8)
            }, completion: { _ in
            })
        }
        else {
            UIView.animate(withDuration: 0.3, delay: 0, usingSpringWithDamping: 0.4, initialSpringVelocity: 0, options: .curveEaseInOut, animations: {
                self.sendButton.isEnabled = true
                self.sendButton.layer.opacity = 1
                self.sendButton.transform = .identity
            }, completion: { _ in
            })
        }
    }
    
}

//
//  OutgoingTextMessageTableViewCell.swift
//  WhatsMessageBF
//
//  Created by Kaue de Assis Jacyntho on 19/12/22.
//

import UIKit

class OutgoingTextMessageTableViewCell: UITableViewCell {

    static let identifier: String = "OutgoingTextMessageTableViewCell"
    
    lazy var myMessageView: UIView = {
       let element = UIView()
        element.translatesAutoresizingMaskIntoConstraints = false
        element.backgroundColor = CustomColor.appPurple
        element.layer.cornerRadius = 20
        element.layer.maskedCorners =  [.layerMinXMaxYCorner, .layerMinXMinYCorner , .layerMaxXMinYCorner]
        return element
    }()
    
    lazy var messageTextLabel: UILabel = {
        let element = UILabel()
        element.translatesAutoresizingMaskIntoConstraints = false
        element.numberOfLines = 0
        element.textColor = .white
        element.font = UIFont(name: CustomFont.poppinsSemiBold, size: 14)
        return element
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.addElemented()
        self.setupContraints()
    }
    
    func addElemented(){
        self.addSubview(self.myMessageView)
        self.myMessageView.addSubview(self.messageTextLabel)
        self.isSelected = false
    }
    
    
    func setupContraints(){
        
        NSLayoutConstraint.activate([
            self.myMessageView.trailingAnchor.constraint(equalTo: self.trailingAnchor,constant: -20),
            self.myMessageView.topAnchor.constraint(equalTo: self.topAnchor,constant: 10),
            self.myMessageView.widthAnchor.constraint(lessThanOrEqualToConstant: 250),
            
            self.messageTextLabel.leadingAnchor.constraint(equalTo: self.myMessageView.leadingAnchor,constant: 15),
            self.messageTextLabel.topAnchor.constraint(equalTo: self.myMessageView.topAnchor,constant: 15),
            self.messageTextLabel.bottomAnchor.constraint(equalTo: self.myMessageView.bottomAnchor,constant: -15),
            self.messageTextLabel.trailingAnchor.constraint(equalTo: self.myMessageView.trailingAnchor,constant: -15),
        ])
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func setupCell(message: Message?){
        self.messageTextLabel.text = message?.text ?? ""
    }

}

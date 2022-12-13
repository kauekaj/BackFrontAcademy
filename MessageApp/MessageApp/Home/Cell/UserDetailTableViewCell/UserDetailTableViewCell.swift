//
//  UserDetailTableViewCell.swift
//  MessageApp
//
//  Created by Kaue de Assis Jacyntho on 05/12/22.
//

import UIKit

class UserDetailTableViewCell: UITableViewCell {
    
    static let identifier = "UserDetailTableViewCell"
    
    lazy var userDetailView: UserDetailView = {
        let element = UserDetailView()
        return element
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addSubView()
        configConstraintsDescriptionCell()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func addSubView() {
        self.contentView.addSubview(userDetailView)
    }

    public func setupCell(data: DataUser) {
        self.userDetailView.nameLabel.text = data.name
        self.userDetailView.userImageView.image = UIImage(named: data.nameImage)
    }
    
    private func configConstraintsDescriptionCell() {
        self.userDetailView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}

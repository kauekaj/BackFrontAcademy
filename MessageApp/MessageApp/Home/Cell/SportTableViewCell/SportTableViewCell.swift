//
//  SportTableViewCell.swift
//  MessageApp
//
//  Created by Kaue de Assis Jacyntho on 13/12/22.
//

import UIKit

class SportTableViewCell: UITableViewCell {

    static let identifier = "SportTableViewCell"
    
    var sportTableViewCellScreen: SportTableViewCellScreen = SportTableViewCellScreen()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addSubView()
        configConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func addSubView() {
        sportTableViewCellScreen.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(sportTableViewCellScreen)
    }
    
    func configConstraints() {
        NSLayoutConstraint.activate([
            sportTableViewCellScreen.topAnchor.constraint(equalTo: self.topAnchor),
            sportTableViewCellScreen.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            sportTableViewCellScreen.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            sportTableViewCellScreen.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
    }
    
    func configConstraintsSportTableViewCellScreen() {
        sportTableViewCellScreen.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}

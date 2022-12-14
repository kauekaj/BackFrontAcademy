//
//  SportCollectionViewCellScreen.swift
//  MessageApp
//
//  Created by Kaue de Assis Jacyntho on 14/12/22.
//

import UIKit

class SportCollectionViewCellScreen: UIView {

    lazy var backgroundView: UIView = {
        let element = UIView()
        element.translatesAutoresizingMaskIntoConstraints = false
        element.backgroundColor = .green
        return element
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addView()
        configConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func addView() {
        self.addSubview(self.backgroundView)
    }

    func configConstraints() {
        NSLayoutConstraint.activate([
            backgroundView.topAnchor.constraint(equalTo: self.topAnchor),
            backgroundView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            backgroundView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            backgroundView.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
    }
    
    func configConstraintsSportTableViewCellScreen() {
        backgroundView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}

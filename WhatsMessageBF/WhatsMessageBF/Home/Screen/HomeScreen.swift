//
//  HomeScreen.swift
//  WhatsMessageBF
//
//  Created by Kaue de Assis Jacyntho on 15/12/22.
//

import UIKit

class HomeScreen: UIView {

    lazy var navigationView: NavigationView = {
        let element = NavigationView()
        element.translatesAutoresizingMaskIntoConstraints = false
        return element
    }()
    
    
    lazy var collectionView: UICollectionView = {
        let element = UICollectionView(frame: CGRect.zero, collectionViewLayout: UICollectionViewLayout.init())
        element.translatesAutoresizingMaskIntoConstraints = false
        element.showsVerticalScrollIndicator = false
        element.backgroundColor = .clear
        element.delaysContentTouches = false
        element.register(LastMessageCollectionViewCell.self, forCellWithReuseIdentifier: LastMessageCollectionViewCell.identifier)
        element.register(MessageDetailCollectionViewCell.self, forCellWithReuseIdentifier: MessageDetailCollectionViewCell.identifier)
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout.init()
        layout.scrollDirection = .vertical
        element.setCollectionViewLayout(layout, animated: false)
        return element
    }()
    
    public func delegateCollectionView(delegate: UICollectionViewDelegate, dataSource: UICollectionViewDataSource) {
        self.collectionView.delegate = delegate
        self.collectionView.dataSource = dataSource
    }
    
    public func reloadCollectionView() {
        self.collectionView.reloadData()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupView() {
        self.addSubview(navigationView)
        self.addSubview(collectionView)
    }
    
    private func setupConstraints() {
        
        NSLayoutConstraint.activate([
            
            navigationView.topAnchor.constraint(equalTo: self.topAnchor),
            navigationView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            navigationView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            navigationView.heightAnchor.constraint(equalToConstant: 140),
            
            collectionView.topAnchor.constraint(equalTo: self.navigationView.bottomAnchor),
            collectionView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
        ])
    }
    
}

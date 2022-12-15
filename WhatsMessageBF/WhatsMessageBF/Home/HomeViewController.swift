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
    
    override func loadView() {
        self.homeScreen = HomeScreen()
        self.view = self.homeScreen
        self.configHomeView()
        self.configCollectionView()
        self.configAlert()
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
}

extension HomeViewController: NavigationViewProtocol {
    func typeScreenMessage(type: TypeConversationOrContact) {
        
        switch type {
        case .contact:
            self.screenContact = true
        case .conversation:
            self.screenContact = false
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

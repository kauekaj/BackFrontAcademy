//
//  HomeViewController.swift
//  WhatsMessageBF
//
//  Created by Kaue de Assis Jacyntho on 15/12/22.
//

import UIKit

class HomeViewController: UIViewController {
    
    var homeScreen: HomeScreen?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.isHidden = true
        self.view.backgroundColor = CustomColor.appLight
    }
    
    override func loadView() {
        self.homeScreen = HomeScreen()
        self.view = self.homeScreen
    }
}

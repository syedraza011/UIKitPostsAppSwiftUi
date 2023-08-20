//
//  ViewController.swift
//  UIKitPostsAppSwiftUi
//
//  Created by Syed Raza on 8/20/23.
//

import UIKit
import SwiftUI

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    func loadPostsScene(){
        let hostingVC = UIHostingController(rootView: ContentView())
        addChild(hostingVC)
        view.addSubview(hostingVC.view)
        hostingVC.view.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            hostingVC.view.topAnchor.constraint(equalTo: view.topAnchor),
            hostingVC.view.leftAnchor.constraint(equalTo: view.leftAnchor),
            hostingVC.view.rightAnchor.constraint(equalTo: view.rightAnchor),
            hostingVC.view.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        
        ])
        
        hostingVC.didMove(toParent: self)
    }

}


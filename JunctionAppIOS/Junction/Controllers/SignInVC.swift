//
//  ViewController.swift
//  Junction
//
//  Created by Khaled Fakharany on 11/17/19.
//  Copyright © 2019 Khaled Fakharany. All rights reserved.
//

import UIKit

class SignInVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        let statusBar =  UIView()
        statusBar.frame = UIApplication.shared.statusBarFrame
        statusBar.backgroundColor = UIColor.red
        UIApplication.shared.keyWindow?.addSubview(statusBar)
    }


    @IBAction func signUpPressed(_ sender: Any) {
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let newViewController = storyBoard.instantiateViewController(withIdentifier: "RegisterVC") as! RegisterVC
        newViewController.modalPresentationStyle = .overFullScreen
        self.present(newViewController, animated: true, completion: nil)
    }
}


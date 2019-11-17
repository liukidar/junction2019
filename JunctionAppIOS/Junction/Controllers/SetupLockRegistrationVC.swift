//
//  SetupLockRegistrationVC.swift
//  Junction
//
//  Created by Khaled Fakharany on 11/17/19.
//  Copyright © 2019 Khaled Fakharany. All rights reserved.
//

import UIKit
import LTHRadioButton

class SetupLockRegistrationVC: UIViewController {

    @IBOutlet weak var otherView: UIView!
    @IBOutlet weak var myselfView: UIView!
    @IBOutlet weak var myselfBtn: UIButton!
    @IBOutlet weak var otherBtn: UIButton!
    @IBOutlet weak var otherTxtField: UITextField!
    
    let mySelfRadioBtn = LTHRadioButton(diameter: 22, selectedColor: UIColor(hex: "#253583ff")!)
    var mySelfState = true
    
    let otherRadioBtn = LTHRadioButton(diameter: 22, selectedColor: UIColor(hex: "#253583ff")!)
    var otherState = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        myselfView.addSubview(mySelfRadioBtn)
        otherView.addSubview(otherRadioBtn)
        mySelfRadioBtn.select()
        myselfView.bringSubviewToFront(myselfBtn)
        otherView.bringSubviewToFront(otherBtn)
        otherTxtField.alpha = 0.4
        // Do any additional setup after loading the view.
    }

    @IBAction func selectMyself(_ sender: Any) {
        
        if mySelfState {
            mySelfRadioBtn.deselect()
            mySelfState = !mySelfState
        }else {
            otherTxtField.alpha = 0.4
            mySelfRadioBtn.select()
            mySelfState = !mySelfState
            otherRadioBtn.deselect()
            otherState = !otherState
        }
    }
    @IBAction func selectOther(_ sender: Any) {
        if otherState {
            otherRadioBtn.deselect()
            otherState = !otherState
        }else {
            otherTxtField.alpha = 1
            otherRadioBtn.select()
            otherState = !otherState
            mySelfRadioBtn.deselect()
            mySelfState = !mySelfState
        }
    }
    @IBAction func nextPressed(_ sender: Any) {
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let newViewController = storyBoard.instantiateViewController(withIdentifier: "AddBagVC") as! AddBagVC
        newViewController.modalPresentationStyle = .fullScreen
        self.present(newViewController, animated: true, completion: nil)
    }
}

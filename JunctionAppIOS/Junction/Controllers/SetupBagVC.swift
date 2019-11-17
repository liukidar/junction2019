//
//  SetupBagVC.swift
//  Junction
//
//  Created by Khaled Fakharany on 11/17/19.
//  Copyright © 2019 Khaled Fakharany. All rights reserved.
//

import UIKit

class SetupBagVC: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        1
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String?{
        
        if pickerView == bagPicker {
            return "Bag 1"
        }else {
            return "Lock 1"
        }
    }
    

    @IBOutlet weak var bagPicker: UIPickerView!
    @IBOutlet weak var lockPicker: UIPickerView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bagPicker.dataSource = self
        lockPicker.dataSource = self
        bagPicker.delegate = self
        lockPicker.delegate = self
        // Do any additional setup after loading the view.
    }
    
    @IBAction func finishPressed(_ sender: Any) {
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let newViewController = storyBoard.instantiateViewController(withIdentifier: "FlightBag") as! FlightBag
        newViewController.modalPresentationStyle = .fullScreen
        self.present(newViewController, animated: true, completion: nil)
    }
}

//
//  AddBagVC.swift
//  Junction
//
//  Created by Khaled Fakharany on 11/17/19.
//  Copyright © 2019 Khaled Fakharany. All rights reserved.
//

import UIKit

class AddBagVC: UIViewController {

    @IBOutlet weak var counterLbl: UILabel!
    var counter = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

    @IBAction func increasePressed(_ sender: Any) {
        counter += 1
        counterLbl.text = String(counter)
    }
    @IBAction func decreasePressed(_ sender: Any) {
        if counter > 0 {
            counter -= 1
        }
        counterLbl.text = String(counter)
    }
    @IBAction func nextPressed(_ sender: Any) {
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let newViewController = storyBoard.instantiateViewController(withIdentifier: "TakePhotoVC") as! TakePhotoVC
        newViewController.modalPresentationStyle = .fullScreen
        self.present(newViewController, animated: true, completion: nil)

    }
}

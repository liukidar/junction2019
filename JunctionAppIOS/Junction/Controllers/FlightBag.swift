//
//  FlightBag.swift
//  Junction
//
//  Created by Khaled Fakharany on 11/17/19.
//  Copyright © 2019 Khaled Fakharany. All rights reserved.
//

import UIKit

class FlightBag: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func checkInPressed(_ sender: Any) {
        
        
        let qualityOfServiceClass = DispatchQoS.QoSClass.background
        let backgroundQueue = DispatchQueue.global(qos: qualityOfServiceClass)
        backgroundQueue.async(execute: {
            
            sleep(1)
            
            DispatchQueue.main.async(execute: { () -> Void in
                let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                let newViewController = storyBoard.instantiateViewController(withIdentifier: "QRViewController") as! QRViewController
                newViewController.modalPresentationStyle = .fullScreen
                self.present(newViewController, animated: true, completion: nil)
            })
        })
    }
}

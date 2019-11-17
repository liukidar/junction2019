//
//  LockSearchScreen.swift
//  Junction
//
//  Created by Khaled Fakharany on 11/17/19.
//  Copyright © 2019 Khaled Fakharany. All rights reserved.
//

import UIKit
import Pulsator
import CoreLocation

class LockSearchScreen: UIViewController, CLLocationManagerDelegate {

    @IBOutlet weak var pulseView: UIView!
    var locationManager: CLLocationManager!
    let pulsator = Pulsator()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        print("Entered")
        
        pulseView.layer.addSublayer(pulsator)
        pulsator.backgroundColor = UIColor(hex: "#253583ff")!.cgColor
        pulsator.radius = 150
        pulsator.numPulse = 3
        pulsator.animationDuration = 5
        
        locationManager = CLLocationManager()
        locationManager.delegate = self
        locationManager.requestAlwaysAuthorization()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        pulsator.start()
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if status == .authorizedAlways {
            if CLLocationManager.isMonitoringAvailable(for: CLBeaconRegion.self) {
                if CLLocationManager.isRangingAvailable() {
                    let uuid = UUID(uuidString: "B9407F30-F5F8-466E-AFF9-25556B57FE6D")!
                    let beaconRegion = CLBeaconRegion(uuid: uuid, identifier: "Mine")
                    locationManager.startMonitoring(for: beaconRegion)
//                    locationManager.startRangingBeacons(in: beaconRegion)
                    locationManager.startRangingBeacons(satisfying: CLBeaconIdentityConstraint(uuid: uuid))
                }
            }
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didRangeBeacons beacons: [CLBeacon], in region: CLBeaconRegion) {
        if beacons.count > 0 {
            for beacon in beacons {
                if beacon.rssi > -35 {
                    let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                    let newViewController = storyBoard.instantiateViewController(withIdentifier: "SetupLockRegistrationVC") as! SetupLockRegistrationVC
                    newViewController.modalPresentationStyle = .fullScreen
                    self.present(newViewController, animated: true, completion: nil)
                }
            }
        }
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}


extension UIColor {
    public convenience init?(hex: String) {
        let r, g, b, a: CGFloat

        if hex.hasPrefix("#") {
            let start = hex.index(hex.startIndex, offsetBy: 1)
            let hexColor = String(hex[start...])

            if hexColor.count == 8 {
                let scanner = Scanner(string: hexColor)
                var hexNumber: UInt64 = 0

                if scanner.scanHexInt64(&hexNumber) {
                    r = CGFloat((hexNumber & 0xff000000) >> 24) / 255
                    g = CGFloat((hexNumber & 0x00ff0000) >> 16) / 255
                    b = CGFloat((hexNumber & 0x0000ff00) >> 8) / 255
                    a = CGFloat(hexNumber & 0x000000ff) / 255

                    self.init(red: r, green: g, blue: b, alpha: a)
                    return
                }
            }
        }

        return nil
    }
}

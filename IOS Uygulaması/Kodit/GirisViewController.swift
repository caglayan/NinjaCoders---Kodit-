//
//  ViewController.swift
//  Kodit
//
//  Created by Caglayan Serbetci on 09/09/2017.
//  Copyright © 2017 Caglayan Serbetci. All rights reserved.
//

import UIKit
import CoreBluetooth

class GirisViewController: UIViewController,BluetoothEngineDelegate {

    @IBOutlet weak var koditCarHorizontalConstrait: NSLayoutConstraint!
    @IBOutlet weak var koditCarImageView: UIImageView!
    @IBOutlet weak var connectButtonHorizontalConstrait: NSLayoutConstraint!
    @IBOutlet weak var connectButton: connectButton!
    
    var bluetoothManager: BluetoothEngine!
    var foundedKodit: CBPeripheral?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        bluetoothManager = BluetoothEngine(withDelegate: self)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        koditCarHorizontalConstrait.constant = self.view.frame.size.width/2 + koditCarImageView.frame.size.width/2
        connectButtonHorizontalConstrait.constant = 0
        UIView.animate(withDuration: 1.0, animations: {
            self.view.updateConstraintsIfNeeded()
            self.view.layoutIfNeeded()
        })
    }


    func didDiscoveredNewDevice(_ discoveredPeripherals: Array<CBPeripheral>){
        for peripheral in discoveredPeripherals{
            print(peripheral)
            if peripheral.name == "BLE-1CA5" {
                foundedKodit = peripheral
            }
        }
        if foundedKodit != nil{
            bluetoothManager.connectSelectedPeripheral(withPeripheral:foundedKodit)
        }else{
            self.startAlert(withMessage: "bişey bulamadım")
        }
    }
    
    func didConnectedKoditDevice(){
        self.performSegue(withIdentifier: "toMainScreenSegue", sender: self)
    }
    
    
    
    @IBAction func connectButtonAction(_ sender: Any) {
        self.performSegue(withIdentifier: "toMainScreenSegue", sender: self)
        bluetoothManager.startScanningPeripherals()
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    private func startAlert(withMessage text: String!){
        let alert = UIAlertController(title: "Alarm", message: text, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "Tamam", style: UIAlertAction.Style.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    
    }
    
    // preapare segue
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toMainScreenSegue" {
            if let viewController = segue.destination as? MainViewController {
                // if(IndexPathNumber != nil){
                viewController.bluetoothManager = bluetoothManager  //as AnyObject
                //}
            }
        }
    }


}


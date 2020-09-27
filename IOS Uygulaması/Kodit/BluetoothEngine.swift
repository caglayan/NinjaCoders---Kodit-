//
//  BluetoothEngine.swift
//  Kodit
//
//  Created by Caglayan Serbetci on 11/09/2017.
//  Copyright © 2017 Caglayan Serbetci. All rights reserved.
//

import Foundation
import UIKit
import CoreBluetooth

enum KoditCommands: UInt8 {
    case dur
    case ileri = 161
    case geri = 162
    case sag = 163
    case sol = 164
    case unknown
}

class BluetoothEngine :NSObject, CBCentralManagerDelegate, CBPeripheralDelegate {
    open var delegate:BluetoothEngineDelegate?
    private var manager:CBCentralManager!
    private var peripheral:CBPeripheral!
    private var service:CBService!
    private var characteristic:CBCharacteristic!
    private var foundedPeripherals = Set<CBPeripheral>()

    init(withDelegate delegate: BluetoothEngineDelegate? = nil) {
        super.init()
        self.delegate = delegate
        self.manager =  CBCentralManager(delegate: self, queue: nil)
    }
    /**
     set delegate for different viewControllers
     */
    open func setDelegate(_ delegate: BluetoothEngineDelegate!) {
        self.delegate = delegate
    }
    
    /**
     Check Bluetooth if it is not Open
     - returns: Bool
     */
    open func checkBluetoothHardware() -> Bool {
        if manager.state == CBManagerState.poweredOn{
            print("Bluetooth is ready.")
            return true
        } else {
            print("There is a problem about Bluetooth.")
            return false
        }
    }
    /**
     start Scanning with Bluetooth
     */
    open func startScanningPeripherals() {
        manager.scanForPeripherals(withServices: nil, options: nil)
    }
    
    /**
     stop Scanning with Bluetooth
     */
    open func stopScanningPeripherals() {
        manager.stopScan()
    }
    
    /**
     connect selected peripheral
     - returns : Bool
     */
    open func connectSelectedPeripheral(withPeripheral peripheral: CBPeripheral!) {
        self.peripheral = peripheral
        self.peripheral.delegate = self
        self.manager.connect(peripheral, options: nil)
    }
    
    let motionTime: Double = 1.3
    open func sendCommandToKodit(command: KoditCommands){
        switch command {
        case .dur:
            peripheral.writeValue(Data.init(bytes: [160,160,160]), for: characteristic, type: CBCharacteristicWriteType.withResponse)
        case .ileri:
            peripheral.writeValue(Data.init(bytes: [161,161,161]), for: characteristic, type: CBCharacteristicWriteType.withResponse)
             _ = Timer.scheduledTimer(timeInterval: motionTime, target: self, selector: #selector(stopCommand), userInfo: nil, repeats: false)
        case .geri:
            peripheral.writeValue(Data.init(bytes: [162,162,162]), for: characteristic, type: CBCharacteristicWriteType.withResponse)
            _ = Timer.scheduledTimer(timeInterval: motionTime, target: self, selector: #selector(stopCommand), userInfo: nil, repeats: false)
        case .sag:
            peripheral.writeValue(Data.init(bytes: [163,163,163]), for: characteristic, type: CBCharacteristicWriteType.withResponse)
            _ = Timer.scheduledTimer(timeInterval: motionTime, target: self, selector: #selector(stopCommand), userInfo: nil, repeats: false)
        case .sol:
            peripheral.writeValue(Data.init(bytes: [164,164,164]), for: characteristic, type: CBCharacteristicWriteType.withResponse)
            _ = Timer.scheduledTimer(timeInterval: motionTime, target: self, selector: #selector(stopCommand), userInfo: nil, repeats: false)
        default:
            print("unrecognize dCommand")
        }
    }
    
    @objc func stopCommand(){
        peripheral.writeValue(Data.init(bytes: [160,160,160]), for: characteristic, type: CBCharacteristicWriteType.withResponse)
    
    }
    

    internal func centralManagerDidUpdateState(_ central: CBCentralManager){
        if manager.state == CBManagerState.poweredOn{
            print("Bluetooth is available.")
        } else {
            print("Bluetooth is not available.")
        }
    }
    
    internal func centralManager(_ central: CBCentralManager, didDiscover peripheral: CBPeripheral, advertisementData: [String : Any], rssi RSSI: NSNumber) {
        let device = (advertisementData as NSDictionary).object(forKey: CBAdvertisementDataLocalNameKey)as? NSString
        if device != nil {
            if !foundedPeripherals.contains(peripheral){
                foundedPeripherals.insert(peripheral)
                if delegate != nil {
                    delegate?.didDiscoveredNewDevice(Array(foundedPeripherals))
                }
            }
            print(peripheral.name ?? "No peripheral")
        }
    }
    
    internal func centralManager(_ central: CBCentralManager, didConnect peripheral: CBPeripheral) {
        if peripheral == peripheral{
            print("connected \(peripheral)")
            self.delegate?.didConnectedKoditDevice()
            peripheral.discoverServices(nil)
        }else{
            print("problem about connection")
        }
    }
    
    internal func peripheral(_ peripheral: CBPeripheral, didDiscoverServices error: Error?){
        print("discovered \(peripheral.services?.count ?? 0) services")
        peripheral.discoverCharacteristics(nil, for: peripheral.services![0])
    }
    
    internal func peripheral(_ peripheral: CBPeripheral, didDiscoverCharacteristicsFor service: CBService, error: Error?){
        print("discovered \(service.characteristics?.count ?? 0) characteristic for specific service")
        characteristic = service.characteristics?[0]
        peripheral.setNotifyValue(true, for: characteristic)
    }
    
    internal func peripheral(_ peripheral: CBPeripheral, didUpdateNotificationStateFor characteristic: CBCharacteristic, error: Error?){
        print("\(characteristic.uuid.uuidString) is notified and ready")
       // peripheral.writeValue(Data.init(bytes: [KoditCommands.ileri.rawValue,KoditCommands.ileri.rawValue,KoditCommands.ileri.rawValue]), for: characteristic, type: CBCharacteristicWriteType.withResponse)
    }

    internal func peripheral(_ peripheral: CBPeripheral, didUpdateValueFor characteristic: CBCharacteristic, error: Error?){
        let receivedValueArray = Array(characteristic.value!)
        if let error = error {
            print("error \(String(describing: error))")
        }
        print(receivedValueArray)
        
    }
    
    internal func centralManager(_ central: CBCentralManager, didDisconnectPeripheral peripheral: CBPeripheral, error: Error?) {
        print("disconnection is occured with this \(peripheral.name ?? "No one")")
        if peripheral == peripheral {
            //delegate?.didReadyElectrosalusDevice(forMode:.disconnected)
        }
    }

}


protocol BluetoothEngineDelegate: NSObjectProtocol {
    func didDiscoveredNewDevice(_ discoveredPeripherals: Array<CBPeripheral>)
    func didConnectedKoditDevice()
}

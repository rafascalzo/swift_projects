//
//  ViewController.swift
//  BluetoothAtFirstGlance
//
//  Created by Rafael VSM on 12/02/20.
//  Copyright © 2020 Rvsm. All rights reserved.
//

import UIKit
import CoreBluetooth

private let SERVICE_UUID = CBUUID(string: "7EDD4777-AADD-47B5-875E-11CFC5D661FB")
private let WR_UUID = CBUUID(string: "07A8B59F-E88F-401A-A8B8-3E9568B9DB8F")
private let WR_PROPERTIES: CBCharacteristicProperties = .write
private let WR_PERMISSIONS: CBAttributePermissions = .writeable

class ViewController: UIViewController {
    
    var centralManager: CBCentralManager!
    var peripheralManager: CBPeripheralManager!
    var selectedPeripheral: CBPeripheral!
    var textString: String?

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(white: 0.9, alpha: 1)
        centralManager = CBCentralManager(delegate: self, queue: DispatchQueue.main)
        peripheralManager = CBPeripheralManager(delegate: self, queue: nil)
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(attemptToSendText))
    }
    
    @objc func attemptToSendText() {
        let ac = UIAlertController(title: "Write your message", message: nil, preferredStyle: .alert)
        ac.addTextField()
        
        let confirm = UIAlertAction(title: "Send", style: .default) { [weak self] _ in
            guard let textField = ac.textFields?.first else { return }
            if let text = textField.text {
                self?.send(text)
            }
        }
        
        let cancel = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        ac.addAction(confirm)
        ac.addAction(cancel)
        present(ac, animated: true)
    }
    
    func send(_ text: String) {
        self.textString = text
        guard selectedPeripheral != nil  else { return }
        NSLog("%@ \(selectedPeripheral.identifier)", "Attempt to send '\(text)' to: ")
        centralManager.connect(selectedPeripheral, options: nil)
    }
}

extension ViewController: CBCentralManagerDelegate {
    
    func centralManagerDidUpdateState(_ central: CBCentralManager) {
        if central.state == .poweredOn {
            NSLog("%@ \(central.state)", "Central state: ")
            // here we scan for the devices with a UUID that is specific to our app, which filters out other BLE devices.
            self.centralManager.scanForPeripherals(withServices: [SERVICE_UUID], options: nil)
            // self.centralManager.scanForPeripherals(withServices: nil, options: nil)
        } else {
            print("central.state is powered off")
        }
    }
  
    func centralManager(_ central: CBCentralManager, didDiscover peripheral: CBPeripheral, advertisementData: [String : Any], rssi RSSI: NSNumber) {
        self.selectedPeripheral = peripheral
        // Here we can read peripheral.identifier as UUID, and read our advertisement data by the key CBAdvertisementDataLocalNameKey.
        NSLog("%@ \(peripheral.description)", "Did discover peripheral: ")
        // We read the advertisement data by the key CBAdvertisementDataLocalNameKey, which is sent by each peripheral, and list all available devices.
        if let data = advertisementData[CBAdvertisementDataLocalNameKey] {
            NSLog("%@ data: \(data)", "")
        }
    }
    
    func centralManager(_ central: CBCentralManager, didConnect peripheral: CBPeripheral) {
        NSLog("%@ \(peripheral.description)", "Did connect to peripheral:")
        peripheral.delegate = self
        peripheral.discoverServices(nil)
        selectedPeripheral = peripheral
    }
}

extension ViewController: CBPeripheralDelegate {
    
    func peripheral(_ peripheral: CBPeripheral, didDiscoverServices error: Error?) {
        NSLog("%@ \(peripheral.description)", "Did discover services of peripheral:")
        for service in peripheral.services! {
            peripheral.discoverCharacteristics(nil, for: service)
        }
    }
    
    func peripheral(_ peripheral: CBPeripheral, didDiscoverCharacteristicsFor service: CBService, error: Error?) {
       NSLog("%@ \(peripheral.description)", "Did discover characteristics for peripheral:")
        for characteristic  in service.characteristics! {
            let characterist = characteristic as CBCharacteristic
            if characterist.uuid.isEqual(WR_UUID) {
                if let messageText = textString {
                    let data = messageText.data(using: .utf8)!
                    peripheral.writeValue(data, for: characterist, type: CBCharacteristicWriteType.withResponse)
                }
            }
        }
    }
}

extension ViewController: CBPeripheralManagerDelegate {
    
    func peripheralManagerDidUpdateState(_ peripheral: CBPeripheralManager) {
        if peripheral.state == .poweredOn {
            NSLog("%@ \(peripheral.state)", "Peripheral state: ")
            let serialService = CBMutableService(type: SERVICE_UUID, primary: true)
            let writeCaracteristics = CBMutableCharacteristic(type: WR_UUID, properties: WR_PROPERTIES, value: nil, permissions: WR_PERMISSIONS)
            serialService.characteristics = [writeCaracteristics]
            peripheralManager.add(serialService)
            
            let advertisementData = String(format: "%@ %@", "Rafael aaaa" ,"CoreBluetooth")
            peripheralManager.startAdvertising([CBAdvertisementDataServiceUUIDsKey: [SERVICE_UUID], CBAdvertisementDataLocalNameKey: advertisementData])
        } else {
            print("not on")
        }
    }
    
    func peripheralManager(_ peripheral: CBPeripheralManager, didReceiveWrite requests: [CBATTRequest]) {
        NSLog("%@ \(peripheral.description)", "Did receive write of peripheral:")
        for request in requests {
            if let value = request.value {
                let messageText = String(data: value, encoding: .utf8)!
                let ac = UIAlertController(title: messageText, message: nil, preferredStyle: .alert)
                ac.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
                DispatchQueue.main.async { [weak self] in
                    self?.present(ac, animated: true)
                }
            }
            self.peripheralManager.respond(to: request, withResult: .success)
        }
    }
}



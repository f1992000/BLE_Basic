//
//  ViewController.swift
//  BLETest
//
//  Created by  DARFON on 2019/8/27.
//  Copyright © 2019  DARFON. All rights reserved.
//

import UIKit
import CoreBluetooth

var MacCentralManager: CBCentralManager!
var TargetPeripheral: CBPeripheral!
var TargetCharacteristic: CBCharacteristic!
var TargetService: CBService!

let connectUUID = CBUUID(string: "ef680100-9b35-4933-9b10-52ffa9740042")
//let connectUUID = CBUUID(string: "6e400001-b5a3-f393-e0a9-e50e24dcca9e")
let heartRateServiceCBUUID = CBUUID(string: "ef680200-9b35-4933-9b10-52ffa9740042")
let UUID1 = CBUUID(string: "EF680201-9B35-4933-9B10-52FFA9740042")
let UUID2 = CBUUID(string: "EF680202-9B35-4933-9B10-52FFA9740042")
let UUID3 = CBUUID(string: "EF680203-9B35-4933-9B10-52FFA9740042")
let UUID4 = CBUUID(string: "EF680204-9B35-4933-9B10-52FFA9740042")
let UUID5 = CBUUID(string: "EF680205-9B35-4933-9B10-52FFA9740042")
let UUID6 = CBUUID(string: "EF680206-9B35-4933-9B10-52FFA9740042")

class ViewController: UIViewController, CBCentralManagerDelegate, CBPeripheralDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        MacCentralManager = CBCentralManager(delegate: self, queue: nil)
    }

    
    func centralManagerDidUpdateState(_ central: CBCentralManager) {
        //检查蓝牙设备是否有在更新
        if central.state == CBManagerState.poweredOn {
            print("did update:\(central.state)")
            // 蓝牙设备确实有反应了开始搜索
            central.scanForPeripherals(withServices: [connectUUID], options: nil)
            print("Start Scanning")
        } else {
            //蓝牙设备没有更新的话，报告原因
            print("BLE on this Mac is not ready")
            switch central.state {
            case .unknown:
                print("蓝牙central.state is .unknown")
            case .resetting:
                print("蓝牙central.state is .resetting")
            case .unsupported:
                print("蓝牙central.state is .unsupported")
            case .unauthorized:
                print("蓝牙central.state is .unauthorized")
            case .poweredOff:
                print("蓝牙central.state is .poweredOff")
            case .poweredOn:
                print("蓝牙central.state is .poweredOn")
            @unknown default:
                print("UnKnowError")
            }
        }
    }
    
    
    func centralManager(_ central: CBCentralManager, didDiscover peripheral: CBPeripheral, advertisementData: [String : Any], rssi RSSI: NSNumber) {
        print("BLE Device identified: \(peripheral)")
        TargetPeripheral = peripheral
        TargetPeripheral.delegate = self  // 初始化peripheral的delegate
        MacCentralManager.stopScan()
        MacCentralManager.connect(TargetPeripheral) //连接
        print("\(peripheral) is connected") // 调试用
    }
    
    
    func centralManager(_ central: CBCentralManager, didConnect peripheral: CBPeripheral) {
        print("Connection Confirmed!")
        TargetPeripheral.discoverServices([heartRateServiceCBUUID])
        print("Target Service Confirmed!")
    }
    
    
    func peripheral(_ peripheral: CBPeripheral, didDiscoverServices error: Error?) {
        guard let services = peripheral.services else { return }
        for service in services {
            peripheral.discoverCharacteristics(nil, for: service)   //陈列所有的service和旗下的characteristics
            print("Identified TargetServices \(service.uuid.uuidString)")
            if service.uuid.isEqual(heartRateServiceCBUUID) { //寻找指定UUID的服务
                print("Identified TargetServices \(service.uuid.uuidString)")
                TargetService = service as CBService
            }
            
        }
    }
    
    func peripheral(_ peripheral: CBPeripheral, didDiscoverCharacteristicsFor service: CBService, error: Error?) {
        guard let characteristics = TargetService.characteristics else { return }
        print("Characteristics identified")  // 调试用

        for characteristic in characteristics {
            print(characteristic)

            if characteristic.properties.contains(.read) {
                print("\(characteristic.uuid): properties contains .read")  //找到read方式的characteristics并读取
                peripheral.readValue(for: characteristic)
            }
            if characteristic.properties.contains(.notify) {
                print("\(characteristic.uuid): properties contains .notify")  //找到notify方式的characteristics并读取
                peripheral.setNotifyValue(true, for: characteristic)
            }

            // 也可以找指定UUID的characteristic特征
            if characteristic.isEqual(heartRateServiceCBUUID) {
                print("\(characteristic.uuid): properties contains UUID")  //找到指定UUID的特征然后下面采取read或者notify
                peripheral.setNotifyValue(true, for: characteristic)
                peripheral.readValue(for: characteristic)
            }
        }
    }
    
    
    func peripheral(_ peripheral: CBPeripheral, didUpdateValueFor characteristic: CBCharacteristic, error: Error?) {
        switch characteristic.uuid {
        case UUID1:
            guard let characteristicData = characteristic.value else { return }
            print(("Temperature_1: \(characteristicData[0])"))

        case UUID2:
            guard let characteristicData = characteristic.value else { return }
            print(("Pressure_2: \(characteristicData[0])"))
            
        case UUID3:
            guard let characteristicData = characteristic.value else { return }
            print(("Humidity_3: \(characteristicData[0])"))
            
        case UUID4:
            guard let characteristicData = characteristic.value else { return }
            print(("AirQuality_4: \(characteristicData[0])"))
            
        case UUID5:
            guard let characteristicData = characteristic.value else { return }
            print(("Color_5: \(characteristicData[0])"))
        
        case UUID6:
            guard let characteristicData = characteristic.value else { return }
            print(("Environment_6: \(characteristicData[0])"))
            
        default:
            print("Unhandled Characteristic UUID: \(characteristic.uuid)")
        }
    }
}

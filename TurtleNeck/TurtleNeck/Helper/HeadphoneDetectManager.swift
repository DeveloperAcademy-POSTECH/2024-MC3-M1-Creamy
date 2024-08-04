////
////  DeviceManager.swift
////  TurtleNeck
////
////  Created by Hyun Jaeyeon on 8/3/24.
////
//
//import Foundation
//import CoreBluetooth
//
//class AirPodsDetector: NSObject, ObservableObject {
//    private var centralManager: CBCentralManager!
//    private var airPodsConnectedCallback: ((Bool) -> Void)?
//
//    override init() {
//        super.init()
//        centralManager = CBCentralManager(delegate: self, queue: nil)
//    }
//    
//    func checkAirPodsConnection(completion: @escaping (Bool) -> Void) {
//        airPodsConnectedCallback = completion
//        centralManager.scanForPeripherals(withServices: nil, options: nil)
//    }
//}
//
//extension AirPodsDetector: CBCentralManagerDelegate {
//    func centralManagerDidUpdateState(_ central: CBCentralManager) {
//        // Check for Bluetooth state
//        switch central.state {
//        case .poweredOn:
//            centralManager.scanForPeripherals(withServices: nil, options: nil)
//        default:
//
//            break
//        }
//    }
//    
//    func centralManager(_ central: CBCentralManager, didDiscover peripheral: CBPeripheral, advertisementData: [String : Any], rssi RSSI: NSNumber) {
//        if let name = peripheral.name, name.contains("AirPods") {
//            airPodsConnectedCallback?(true)
//            centralManager.stopScan()
//        } else {
//            airPodsConnectedCallback?(false)
//        }
//    }
//}
//

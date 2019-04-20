//
//  ViewController.swift
//  Project22
//
//  Created by kirsty darbyshire on 19/04/2019.
//  Copyright © 2019 nocto. All rights reserved.
//

import UIKit
import CoreLocation

class ViewController: UICollectionViewController, CLLocationManagerDelegate {

    var locationManager: CLLocationManager?
    var beaconInformation = [BeaconInfo]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        locationManager = CLLocationManager()
        locationManager?.delegate = self
        locationManager?.requestAlwaysAuthorization()
        
        view.backgroundColor = .black
        
        // set a default nothing has been found cell here probably...
    }

    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if status == .authorizedAlways {
            if CLLocationManager.isMonitoringAvailable(for: CLBeaconRegion.self) {
                if CLLocationManager.isRangingAvailable() {
                    startScanning()
                }
            }
        }
    }
    
    func startScanning() {
        addBeacon(uuid: "5A4BCFCE-174E-4BAC-A814-092E77F6B7E5", name: "5A4", major: 123, minor: 456)
        addBeacon(uuid: "92AB49BE-4127-42F4-B532-90fAF1E26491", name: "TwoCanoes", major: 987, minor: 654)
        collectionView.reloadData()
    }
    
    func addBeacon(uuid uuidString: String, name: String, major: CLBeaconMajorValue, minor: CLBeaconMinorValue) {
        let uuid = UUID(uuidString: uuidString)!
        let region = CLBeaconRegion(proximityUUID: uuid, major: major, minor: minor, identifier: "\(name) beacon")
        beaconInformation.append(
            BeaconInfo(uuid: uuid, shortName: name, region: region, detected: false, proximity: .unknown))
        locationManager?.startMonitoring(for: region)
        locationManager?.startRangingBeacons(in: region)
    }
    
    func locationManager(_ manager: CLLocationManager, didRangeBeacons beacons: [CLBeacon], in region: CLBeaconRegion) {
        if let beacon = beacons.first {
            print("beacon \(beacon.proximityUUID) has been detected")
            // find beacon info with this uuid
            for possibleBeacon in beaconInformation {
                if possibleBeacon.uuid == beacon.proximityUUID {
                    print("matched beacon \(possibleBeacon)")
                    possibleBeacon.proximity = beacon.proximity
                    possibleBeacon.delegate?.update(distance: beacon.proximity)
                    collectionView.reloadData()
                }
            }
        }
    }
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return beaconInformation.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "beacon", for: indexPath) as? BeaconCell else { fatalError("Unable to dequeue a beacon cell") }
        cell.beaconInfo = beaconInformation[indexPath.row]
        cell.beaconInfo.delegate = cell
        cell.update(distance: cell.beaconInfo.proximity)
        return cell
    }



}





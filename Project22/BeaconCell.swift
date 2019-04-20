//
//  BeaconCollectionViewCell.swift
//  Project22
//
//  Created by kirsty darbyshire on 20/04/2019.
//  Copyright © 2019 nocto. All rights reserved.
//

import UIKit
import CoreLocation

class BeaconCell: UICollectionViewCell {
    @IBOutlet var distanceReading: UILabel!
    
    var beaconInfo: BeaconInfo!
    
    func update(distance: CLProximity) {
        print("updating a beacon cell for \(beaconInfo.shortName)")
        UIView.animate(withDuration: 1) {
            switch distance {
            case .far:
                self.backgroundColor = .blue
                self.distanceReading.text = "\(self.beaconInfo.shortName) FAR"
            case .near:
                self.backgroundColor = .orange
                self.distanceReading.text = "\(self.beaconInfo.shortName) NEAR"
            case .immediate:
                self.backgroundColor = .red
                self.distanceReading.text = "\(self.beaconInfo.shortName) RIGHT HERE"
            default:
                self.backgroundColor = .gray
                self.distanceReading.text = "\(self.beaconInfo.shortName) UNKNOWN"
            }
        }
    }
    
}

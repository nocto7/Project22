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
    @IBOutlet var circle: UIView!
    
    var beaconInfo: BeaconInfo!
    
    func setup() {
        circle.layer.cornerRadius = 128
        circle.backgroundColor = .black
    }
    
    func update(distance: CLProximity) {
        print("updating a beacon cell for \(beaconInfo.shortName)")
        UIView.animate(withDuration: 1) {
            switch distance {
            case .far:
                self.circle.backgroundColor = .blue
                self.circle.transform = CGAffineTransform(scaleX: 0.2, y: 0.2)
                self.distanceReading.text = "\(self.beaconInfo.shortName)\nFAR"
            case .near:
                self.circle.backgroundColor = .orange
                self.circle.transform = CGAffineTransform(scaleX: 0.6, y: 0.6)
                self.distanceReading.text = "\(self.beaconInfo.shortName)\nNEAR"
            case .immediate:
                self.circle.backgroundColor = .red
                self.circle.transform = CGAffineTransform(scaleX: 1, y: 1)
                self.distanceReading.text = "\(self.beaconInfo.shortName)\nRIGHT HERE"
            default:
                self.circle.backgroundColor = .gray
                self.circle.transform = CGAffineTransform(scaleX: 0.01, y: 0.01)
                self.distanceReading.text = "\(self.beaconInfo.shortName)\nUNKNOWN"
            }
        }
    }
    
}

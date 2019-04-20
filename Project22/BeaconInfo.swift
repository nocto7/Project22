//
//  BeaconInfo.swift
//  Project22
//
//  Created by kirsty darbyshire on 20/04/2019.
//  Copyright © 2019 nocto. All rights reserved.
//

import Foundation
import CoreLocation

class BeaconInfo {
    var uuid: UUID
    var shortName: String
    var region: CLBeaconRegion
    var detected: Bool
    var proximity: CLProximity
    var delegate: BeaconCell?
    
    init(uuid: UUID, shortName: String, region: CLBeaconRegion, detected: Bool, proximity: CLProximity) {
        self.uuid = uuid
        self.shortName = shortName
        self.region = region
        self.detected = detected
        self.proximity = proximity
    }
}

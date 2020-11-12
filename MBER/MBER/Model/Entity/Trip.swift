//
//  Trip.swift
//  MBER
//
//  Created by SEONGJUN on 2020/11/12.
//

import CoreLocation

enum TripState: Int {
    case requested
    case denied
    case accepted
    case driverArrived
    case inProgress
    case arrivedAtDestination
    case completed
}

struct Trip {
    var pickupCoordinates: CLLocationCoordinate2D!
    var destinationCoordinates: CLLocationCoordinate2D!
    let passengerUid: String!
    var driverUid: String?
    var state: TripState!
}

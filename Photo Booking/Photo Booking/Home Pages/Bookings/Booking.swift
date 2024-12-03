//
//  Booking.swift
//  Photo Booking
//
//  Created by Alex Yang on 12/3/24.
//

import Foundation
import SwiftUI

struct Booking: Codable, Hashable {
    let provider: String
    let location: String
    let description: String
    let date: String
    let price: String
}

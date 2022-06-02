//
//  targetLocation.swift
//  tab
//
//  Created by Faruk Yılmaz on 24.05.2022.
//

import Foundation

class TargetLocation: ObservableObject {
    @Published var targetLat: Double = 0.0
    @Published var targetLon: Double = 0.0
}

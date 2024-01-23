//
//  MotionManager.swift
//  TheMovieDB
//
//  Created by Kelian Daste on 18/01/2024.
//

import SwiftUI
import CoreMotion

class MotionManager: ObservableObject {
    
    private let motionManager = CMMotionManager()

    @Published private(set) var xAxis: Double = 0.0
    @Published private(set) var yAxis: Double = 0.0

    @Published private(set) var shimmerProgress: Double = 0.0
    @Published private(set) var shimmerProgressX: Double = 0.0
    @Published private(set) var shimmerProgressY: Double = 0.0
    
    func startMonitoringMotionUpdates() {
        
        guard self.motionManager.isDeviceMotionAvailable else {
            print("Device motion not available")
            return
        }
        
        self.motionManager.deviceMotionUpdateInterval = 0.01
        
        self.motionManager.startDeviceMotionUpdates(to: .main) { motion, error in
            guard let motion else { return }
            
            let scaleFactor: Double = 0.1 //Facteur d'echelle pour la rotation
            
            let degreesX = motion.rotationRate.x * scaleFactor
            let degreesY = motion.rotationRate.y * scaleFactor
            
            withAnimation {
                self.xAxis += degreesX
                self.yAxis += degreesY
                
                self.xAxis = max(min(self.xAxis, 30), -30)
                self.yAxis = max(min(self.yAxis, 30), -30)
                
                self.shimmerProgress = abs(max(self.xAxis, self.yAxis) / 30)
                self.shimmerProgressX = self.xAxis * 10
                self.shimmerProgressY = self.yAxis * 10
            }
//            print("X: \(self.xAxis)")
//            print("Y: \(self.yAxis)")
        }
    }
    
    func stopMonitoringMotionUpdates() {
        self.motionManager.stopDeviceMotionUpdates()
    }
}

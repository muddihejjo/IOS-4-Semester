//
//  AccelerometerSpeedometer.swift
//  SensorSpeed
//
//  Created by muddi hejjo on 09/04/2019.
//  Copyright © 2019 muddi hejjo. All rights reserved.
//
import CoreMotion

class AccelerometerSpeedometer {
    
    var motionManager = CMMotionManager()
    
    
    func getMotionManager() -> CMMotionManager {
        
        return motionManager
        
    }
    
    
    func setupMotionManager() {
        
        if (motionManager.isAccelerometerAvailable) {
            motionManager.accelerometerUpdateInterval = 0.1
            motionManager.startAccelerometerUpdates()
        } else {
            print("Accelerometer not availible on this device")
        }
    }
    
    func getAccelerationValues() -> (x:Double, y:Double, z:Double) {
        let accel = motionManager.accelerometerData?.acceleration
        return (x: accel!.x, y: accel!.y, z: accel!.z)
    
    }
    init(){
        setupMotionManager()
    }

}


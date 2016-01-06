//
//  MotionReading.swift
//  SuperCornHole
//
//  Created by Clinton Medbery on 12/1/15.
//  Copyright © 2015 Programadores Sans Frontieres. All rights reserved.
//

import Foundation

class MotionReading {
    
    var gravity: Gravity
    var acceleration: Acceleration
    //var quaternion: Quaternion
    
    
    init(gravityX: Double, gravityY: Double, gravityZ: Double, accelerationX: Double, accelerationY: Double, accelerationZ: Double){
        self.gravity = Gravity(gravityX: gravityX, gravityY: gravityY, gravityZ: gravityZ)
        self.acceleration = Acceleration(accelerationX: accelerationX, accelerationY: accelerationY, accelerationZ: accelerationZ)
        //self.quaternion = Quaternion(quaternionW: quaternionW, quaternionX: quaternionX, quaternionY: quaternionY, quaternionZ: quaternionZ)
        
    }
    
    func printHeader(){
        print("Gravity X,Gravity Y,Gravity Z,Acceleration X,Acceleration Y,Acceleration Z,Quaternion W,Quaternion X,Quaternion Y,Quaternion Z")
        
    }
    
    func printReading(){
        print("Gravity X: \(gravity.x)")
        print("Gravity Y: \(gravity.y)")
        print("Gravity Z: \(gravity.z)")
        

        print("Acceleration X: \(acceleration.x)")
        print("Acceleration Y: \(acceleration.y)")
        print("Acceleration Z: \(acceleration.z)")

    }
    
    func printReadingCSV(){
        print("\(gravity.x),\(gravity.y),\(gravity.z),\(acceleration.x),\(acceleration.y),\(acceleration.z)")
    }
    
    class Gravity {
        
        var x: Double
        var y: Double
        var z: Double
        
        init(gravityX: Double, gravityY: Double, gravityZ: Double){
            self.x = gravityX
            self.y = gravityY
            self.z = gravityZ
        }
        
    }
    
    class Acceleration {
        var x: Double
        var y: Double
        var z: Double
        
        init(accelerationX: Double, accelerationY: Double, accelerationZ: Double){
            self.x = accelerationX
            self.y = accelerationY
            self.z = accelerationZ
        }
    }
    
//    class Quaternion {
//        var w: Double
//        var x: Double
//        var y: Double
//        var z: Double
//        
//        init(quaternionW: Double, quaternionX: Double, quaternionY: Double, quaternionZ: Double){
//            self.w = quaternionW
//            self.x = quaternionX
//            self.y = quaternionY
//            self.z = quaternionZ
//        }
//    }
}
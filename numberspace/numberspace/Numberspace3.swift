//
//  NumberSpace.swift
//  numberspace
//
//  Created by donghoon bae on 2016. 9. 11..
//  Copyright © 2016년 Forethink. All rights reserved.
//

import UIKit
import SwiftyJSON

@IBDesignable
class NumberSpaceThree: UIView {
    
    
    var stateColor: UIColor = UIColor.blueColor()
    @IBInspectable var strokeColor: UIColor = UIColor.whiteColor()
    @IBInspectable var radius: CGSize = CGSizeMake(5, 5)
    @IBInspectable var xRepeat: Int = 0
    @IBInspectable var yRepeat: Int = 0
    
    var dataSetJSON = "numberspace44.12percent"
    
    @IBAction func dataSetOne(sender:AnyObject) {
        dataSetJSON = "numberspace10percent"
    }
    
    @IBAction func dataSetTwo(sender:AnyObject) {
        dataSetJSON = "numberspace30percent"
    }
    
    @IBAction func dataSetThree(sender:AnyObject) {
        dataSetJSON = "numberspace44.12percent"
    }
    
    @IBAction func dataSetFour(sender:AnyObject) {
        dataSetJSON = "numberspace70percent"
    }
    
    var selectedCellNumber: Int = 16
    var statesArray: Array = [""]
    var statesText: String! = nil
    var transferIndex: AnyObject!  = nil
    
    let width = UIScreen.mainScreen().bounds.width
    
    func readJson() {
        
        if let path = NSBundle.mainBundle().pathForResource(dataSetJSON, ofType: "json") {
            do {
                let data = try NSData(contentsOfURL: NSURL(fileURLWithPath: path), options: NSDataReadingOptions.DataReadingMappedIfSafe)
                let jsonObj = JSON(data: data)
                if jsonObj != JSON.null {
                    
                    //do
                    statesArray.removeAll()
                    let count = jsonObj["NUMBERSPACE"].count - 1
                    print("counting: \(count)")
                    for i in 0...count {
                        statesArray.append(jsonObj["NUMBERSPACE"][i]["STATES"].string!)
                    }
                    
                }
                else {
                    print("could not get json from file, make sure that file contains valid json.")
                }
            } catch let error as NSError {
                print(error.localizedDescription)
            }
        } else {
            print("Invalid filename/path.")
        }
        print("\(statesArray)")
    }
    
    override func drawRect(rect: CGRect) {
        
        readJson()
        
        
        var i = 0
        var yloop = 0
        var xOffset: Int = 0
        var yOffset: Int = 0
        let gap = 1
        let cellWidth: Int = 3
        let cellHeight: Int = 3
        
        while yloop < 100 {
            yOffset = yOffset + cellHeight + gap
            let yoff = CGFloat(yOffset)
            
            while i < 100 {
                xOffset = xOffset + cellWidth + gap
                let xoff = CGFloat(xOffset)
                let rect = CGRect(x: xoff, y: yoff, width:3, height: 3)
                let squarePath : UIBezierPath = UIBezierPath(roundedRect: rect, byRoundingCorners: UIRectCorner.AllCorners, cornerRadii: radius)
                let index = (yloop * 100) + i
                print ("index: \(index)::\(statesArray[index])")
                if statesArray[index] == "free" {
                    stateColor = UIColor.lightGrayColor()
                } else {
                    stateColor = UIColor.redColor()
                }
                
                i = i + 1
                strokeColor.setStroke()
                squarePath.stroke()
                stateColor.setFill()
                squarePath.fill()
                
            }
            i = 0
            xOffset = 0
            
            yloop = yloop + 1
        }
        //print("\(statesArray)")
    }
    
}
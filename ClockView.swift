//
//  ClockView.swift
//  HomeWork11
//
//  Created by Владислав Вишняков on 13.05.2021.
//

import UIKit

@IBDesignable
class ClockView: UIView {
    
    var isSetuped = false

    @IBInspectable var roundedViewColor: UIColor = UIColor.green {
        didSet { roundedView.backgroundColor = roundedViewColor }
    }

    private let topMarker = UIView()
    private let leftMarker = UIView()
    private let rightMarker = UIView()
    private let bottomMarker = UIView()
    
    private let hourLine = UIView()
    
    private let roundedView = UIView()
    
    private let minuteLine = UIView()
    
    private let secondLine = UIView()
    
    var markerSize: CGFloat = 4
    var marketLenght: CGFloat = 12
    var markerColor = UIColor.blue
    

    /// MARK: Часовая стрелка
    
    var hourLineOffset: CGFloat = 55
    @IBInspectable var hourLineSize: CGFloat = 20 {
        didSet { layoutIfNeeded() }
    }
    @IBInspectable var hourLineColor: UIColor = UIColor.green {
        didSet { hourLine.backgroundColor = hourLineColor}
    }
    
    
    ///MARK: Минутная стрелка
    

    var minuteLineOffset: CGFloat = 40
    @IBInspectable var minuteLineSize: CGFloat = 10 {
        didSet { layoutIfNeeded()}
    }
    @IBInspectable var minuteLineColor: UIColor = UIColor.yellow {
        didSet { minuteLine.backgroundColor = minuteLineColor }
    }
    
    ///MARK: Секундная стрелка
    

    var secondLineOffset: CGFloat = 4
    @IBInspectable var secondLineSize: CGFloat = 4 {
        didSet {layoutIfNeeded()}
    }
    @IBInspectable var secondLineColor: UIColor = UIColor.green {
        didSet { secondLine.backgroundColor = secondLineColor }
    }
    
    
    ///MARK: Текущее время
    var timer = Timer()

    @objc func updateHours(){
        let calendar = Calendar.current
        let date = Date()
        
        let hours: CGFloat = CGFloat(calendar.component(.hour, from: date))
        let minutes: CGFloat = CGFloat(calendar.component(.minute, from: date))
        let seconds: CGFloat = CGFloat(calendar.component(.second, from: date))
        
    
        let angle = CGFloat.pi * 2 * (CGFloat(hours) / CGFloat(12))
        hourLine.transform = CGAffineTransform(rotationAngle: angle)
        let min = CGFloat.pi * 2 * (CGFloat(minutes) / CGFloat(60))
        minuteLine.transform = CGAffineTransform(rotationAngle: min)
        let sec = CGFloat.pi * 2 * (CGFloat(seconds) / CGFloat(60))
        secondLine.transform = CGAffineTransform(rotationAngle: sec)
        
        print(hours,minutes,seconds)
        
    }
    
    
    
    
    
    override func layoutSubviews() {
        
        if isSetuped { return }
        isSetuped = true
        
        super.layoutSubviews()
        func timers(){
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(updateHours), userInfo: nil, repeats: true)
        }
        
        let w = frame.size.width
        let h = frame.size.height
        
        hourLine.layer.anchorPoint = CGPoint(x: 0.5, y: 1)
        hourLine.frame = CGRect(x: w / 2 - hourLineSize / 2, y: hourLineOffset, width: hourLineSize, height: h / 2 - hourLineOffset)
        hourLine.backgroundColor = hourLineColor
        
        minuteLine.layer.anchorPoint = CGPoint(x: 0.5, y: 1)
        minuteLine.frame = CGRect(x: w / 2 - minuteLineSize / 2, y: minuteLineOffset, width: minuteLineSize, height: h / 2 - minuteLineOffset)
        minuteLine.backgroundColor = minuteLineColor
        
        secondLine.layer.anchorPoint = CGPoint(x: 0.5, y: 1)
        secondLine.frame = CGRect(x: w / 2 - secondLineSize / 2, y: secondLineOffset, width: secondLineSize, height: h / 2 - secondLineOffset)
        secondLine.backgroundColor = secondLineColor
        
        
        roundedView.frame = CGRect(x: w / 2 - 10, y: h / 2 - 10, width: 20, height: 20)
        roundedView.backgroundColor = roundedViewColor
        roundedView.layer.cornerRadius = 8
        
        updateHours()
        timers()
        
        
        topMarker.frame = CGRect(x: w / 2 - markerSize, y: 0, width: markerSize, height: marketLenght)
        bottomMarker.frame = CGRect(x: w / 2 - markerSize, y: h - marketLenght, width: markerSize, height: marketLenght)
        leftMarker.frame = CGRect(x: 0,y: h / 2 - markerSize / 2, width: marketLenght, height: markerSize)
        rightMarker.frame = CGRect(x: w - marketLenght,y: h / 2 - markerSize / 2, width: marketLenght, height: markerSize)
        
        for v in [topMarker,leftMarker,rightMarker,bottomMarker] {
            v.backgroundColor = markerColor
        }
        
        layer.cornerRadius = frame.size.width / 2

        for v in [ topMarker,leftMarker,rightMarker,bottomMarker, hourLine,  hourLine, minuteLine, secondLine, roundedView] {
            addSubview(v)

        }

    }

}



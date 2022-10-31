//
//  CountdownView.swift
//  My Progress
//
//  Created by Alexander Petrenko on 29.10.2022.
//

import UIKit

class CountdownView {
    
    var timer: Timer?
    var progress: Time!
    var labelCounter: UILabel!
    
    func configure(progress: Time, frameView: UIView) {
        
        let frameWidth = frameView.frame.width
        self.progress = progress
        
        let secondsInDegrees = Double(Time.getSecondsBetweenStartFinish(progress: self.progress)) / 720
        let currentAngle = CGFloat(540 - abs(Double(Time.getSecondsTillFinish(progress: self.progress)) / secondsInDegrees))
        
        createCountdownCounter()
        // background circle
        frameView.layer.addSublayer(setCircle(startAngle: -180, endAngle: 540, circleWith: 60, circleColor: UIColor.lightGray.cgColor, frameWidth: frameWidth, needAnimation: false))
        // taken circle
        frameView.layer.addSublayer(setCircle(startAngle: -180, endAngle: currentAngle, circleWith: 45, circleColor: UIColor.systemPink.cgColor, frameWidth: frameWidth, needAnimation: false))
        // counter circle
        frameView.layer.addSublayer(setCircle(startAngle: currentAngle, endAngle: 540, circleWith: 45, circleColor: UIColor.systemPink.cgColor, frameWidth: frameWidth, needAnimation: true))
        
        frameView.addSubview(setLabel(frameWidth: frameWidth))
        
       getLabel(frameView: frameView)
    }
    
    private func setLabel(frameWidth: CGFloat) -> UILabel {
        
        let label = UILabel(frame: CGRect(x: frameWidth / 2 - 160, y: frameWidth / 2 - 285, width: 150, height: 21))
        label.center = CGPoint(x: frameWidth / 2, y: frameWidth / 2)
        label.textAlignment = .center
        if Time.getSecondsTillFinish(progress: self.progress) <= 0 {
            label.text = "You did it!"
        } else {
            label.text = "\(Time.getDateTillFinish(progress: self.progress)) left"
        }
        label.font = UIFont(name: label.font.fontName, size: 12)
        label.restorationIdentifier = "labelCounter"
        
        return label
    }
    
    private func getLabel(frameView: UIView)  {
        
        for label in frameView.subviews {
            if let labelCounter = label as? UILabel {
                if labelCounter.restorationIdentifier ==  "labelCounter" {
                    self.labelCounter = labelCounter
                    break
                }
            }
        }
    }
    
    
    private func setCircle(startAngle: CGFloat, endAngle: CGFloat, circleWith: CGFloat, circleColor: CGColor, frameWidth: CGFloat, needAnimation: Bool) -> CAShapeLayer{
        let segmentPath = createSegment(startAngle: startAngle, endAngle: endAngle, frameWidth: frameWidth)
        let segmentLayer = CAShapeLayer()
        segmentLayer.path = segmentPath.cgPath
        segmentLayer.lineWidth = circleWith
        segmentLayer.strokeColor = circleColor
        segmentLayer.fillColor = UIColor.clear.cgColor
        
        if needAnimation { addCircleAnimation(to: segmentLayer) }
        
        return segmentLayer
    }
    
    private func createSegment(startAngle: CGFloat, endAngle: CGFloat, frameWidth: CGFloat) -> UIBezierPath {
        return UIBezierPath(arcCenter: CGPoint(x: frameWidth / 2, y: frameWidth / 2), radius: frameWidth / 6, startAngle: startAngle.toRadians(), endAngle: endAngle.toRadians(), clockwise: true)
    }
    
    private func addCircleAnimation(to layer: CALayer) {
        let drawAnimation = CABasicAnimation(keyPath: "strokeEnd")
        drawAnimation.duration = Time.getDateFromString(date: self.progress.finishDate).timeIntervalSinceNow // counter speed in seconds
        drawAnimation.repeatCount = 1.0
        drawAnimation.isRemovedOnCompletion = false
        drawAnimation.fromValue = 0
        drawAnimation.toValue = 1
        drawAnimation.timingFunction = CAMediaTimingFunction(name: .linear)
        layer.add(drawAnimation, forKey: "drawCircleAnimation")
    }
    
    private func createCountdownCounter() {
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(handleTimer), userInfo: nil, repeats: true)
    }
    
    @objc func handleTimer(_ timer: Timer) {
    
        if Time.getSecondsTillFinish(progress: self.progress) <= 0 {
            timer.invalidate()
            labelCounter.text = "You did it!"
        } else {
            labelCounter.text = "\(Time.getDateTillFinish(progress: self.progress)) left"
        }
        
        
    }
    
    
}

extension CGFloat {
    func toRadians() -> CGFloat {
        return self * CGFloat(Double.pi) / 360.0
    }
}


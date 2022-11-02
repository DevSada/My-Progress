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
    var radius: CGFloat!
    
    func configure(progress: Time?, frameView: UIView, counterType: CounterViewTypes) -> UIView{
        
        
        self.progress = progress
        
        let frameWidth = frameView.frame.width
        var circleWidth: CGFloat = frameWidth / 7
        radius = frameWidth / 3
        let startAngle: CGFloat = 180
        let endAngle: CGFloat = 540
        
        let countdownView = UIView(frame: CGRect(x: 0, y: 0, width: frameWidth, height: frameWidth))
        
        if counterType == .cell
        {
            radius = frameWidth / 6
            circleWidth = frameWidth / 2
        }
        
        // MARK: - background circle
        countdownView.layer.addSublayer(setCircle(startAngle: -startAngle, endAngle: endAngle, circleWith: circleWidth, circleColor: UIColor.lightGray.cgColor, frameWidth: frameWidth, needAnimation: false))
        
        if counterType != .add {
            
            let secondsInDegrees = Double(DataManager.getSecondsBetweenStartFinish(progress: self.progress)) / (startAngle + endAngle)
            let currentAngle = CGFloat(endAngle - abs(Double(DataManager.getSecondsTillFinish(progress: self.progress)) / secondsInDegrees))
            
            // MARK: - taken circle
            countdownView.layer.addSublayer(setCircle(startAngle: -startAngle, endAngle: currentAngle, circleWith: circleWidth * 0.75, circleColor: UIColor.systemPink.cgColor, frameWidth: frameWidth, needAnimation: false))
            
            // MARK: - counter circle
            countdownView.layer.addSublayer(setCircle(startAngle: currentAngle, endAngle: endAngle, circleWith: circleWidth * 0.75, circleColor: UIColor.systemPink.cgColor, frameWidth: frameWidth, needAnimation: true))
            
            countdownView.addSubview(setLabel(frameWidth: frameWidth))
            
            createCountdownCounter()
            getLabelForCounter(frameView: countdownView)
        }
        
        countdownView.restorationIdentifier = "countdownView"
        
        return countdownView
    }
    
    private func setLabel(frameWidth: CGFloat) -> UILabel {
        
        let label = UILabel(frame: CGRect(x: frameWidth / 2 - 160, y: frameWidth / 2 - 285, width: 150, height: 21))
        label.center = CGPoint(x: frameWidth / 2, y: frameWidth / 2)
        label.textAlignment = .center
        if DataManager.getSecondsTillFinish(progress: self.progress) <= 0 {
            label.text = "You did it!"
        } else {
            label.text = "\(DataManager.getDateTillFinish(progress: self.progress)) left"
        }
        label.font = UIFont(name: label.font.fontName, size: 12)
        label.restorationIdentifier = "labelCounter"
        
        return label
    }
    
    private func getLabelForCounter(frameView: UIView)  {
        
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
        return UIBezierPath(arcCenter: CGPoint(x: frameWidth / 2, y: frameWidth / 2), radius: radius, startAngle: startAngle.toRadians(), endAngle: endAngle.toRadians(), clockwise: true)
    }
    
    private func addCircleAnimation(to layer: CALayer) {
        let drawAnimation = CABasicAnimation(keyPath: "strokeEnd")
        drawAnimation.duration = DataManager.getDateFromString(date: self.progress.finishDate).timeIntervalSinceNow // counter speed in seconds
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
        
        if DataManager.getSecondsTillFinish(progress: self.progress) <= 0 {
            timer.invalidate()
            labelCounter.text = "You did it!"
        } else {
            labelCounter.text = "\(DataManager.getDateTillFinish(progress: self.progress)) left"
        }
        
        
    }
    
    
}

extension CGFloat {
    func toRadians() -> CGFloat {
        return self * CGFloat(Double.pi) / 360.0
    }
}


//
//  CountdownViewController.swift
//  My Progress
//
//  Created by Alexander Petrenko on 28.10.2022.
//

import UIKit

class CountdownViewController: UIViewController {
    
    var progress: Time!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        CountdownView().configure(progress: progress, frameView: self.view)
    }
    
    
    
//    
//    
//    let startTime: Double = 0
//    var finishTime = Time.getSecondsTillFinish()
//    var timer: Timer?
//    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        
//        let secondsInDegrees = Double(Time.getSecondsBetweenStartFinish()) / 720
//        let currentAngle = CGFloat(540 - abs(Double(Time.getSecondsTillFinish()) / secondsInDegrees))
//        
//        createCountdownCounter()
//        // background circle
//        createCircle(startAngle: -180, endAngle: 540, circleWith: 60, circleColor: UIColor.lightGray.cgColor, needAnimation: false)
//        // taken circle
//        createCircle(startAngle: -180, endAngle: currentAngle, circleWith: 45, circleColor: UIColor.systemPink.cgColor, needAnimation: false)
//        // counter circle
//        createCircle(startAngle: currentAngle, endAngle: 540, circleWith: 45, circleColor: UIColor.systemPink.cgColor, needAnimation: true)
//        
//        let label = UILabel(frame: CGRect(x: self.view.frame.midX - 160, y: self.view.frame.midY - 285, width: 200, height: 21))
//        label.center = CGPoint(x: self.view.frame.midX, y: self.view.frame.midY)
//        label.textAlignment = .center
//        if Time.getSecondsTillFinish() <= 0 {
//            label.text = "You did it!"
//        } else {
//            label.text = "\(Time.getDateTillFinish()) left"
//        }
//        label.font = UIFont(name: label.font.fontName, size: 12)
//        label.restorationIdentifier = "labelCounter"
//        self.view.addSubview(label)
//        
//    }
//    
//    private func createSegment(startAngle: CGFloat, endAngle: CGFloat) -> UIBezierPath {
//        return UIBezierPath(arcCenter: CGPoint(x: self.view.frame.midX, y: self.view.frame.midY), radius: 150, startAngle: startAngle.toRadians(), endAngle: endAngle.toRadians(), clockwise: true)
//    }
//    
//    private func createCircle(startAngle: CGFloat, endAngle: CGFloat, circleWith: CGFloat, circleColor: CGColor, needAnimation: Bool) {
//        let segmentPath = createSegment(startAngle: startAngle, endAngle: endAngle)
//        let segmentLayer = CAShapeLayer()
//        segmentLayer.path = segmentPath.cgPath
//        segmentLayer.lineWidth = circleWith
//        segmentLayer.strokeColor = circleColor
//        segmentLayer.fillColor = UIColor.clear.cgColor
//        
//        
//        self.view.layer.addSublayer(segmentLayer)
//        
//        if needAnimation { addCircleAnimation(to: segmentLayer) }
//    }
//    
//    private func addCircleAnimation(to layer: CALayer) {
//        let drawAnimation = CABasicAnimation(keyPath: "strokeEnd")
//        drawAnimation.duration = Time.getFinishDate().timeIntervalSinceNow // counter speed in seconds
//        drawAnimation.repeatCount = 1.0
//        drawAnimation.isRemovedOnCompletion = false
//        drawAnimation.fromValue = 0
//        drawAnimation.toValue = 1
//        drawAnimation.timingFunction = CAMediaTimingFunction(name: .linear)
//        layer.add(drawAnimation, forKey: "drawCircleAnimation")
//    }
//    
//    private func createCountdownCounter() {
//        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(handleTimer), userInfo: nil, repeats: true)
//    }
//    
//    @objc func handleTimer(_ timer: Timer) {
//        
//        for label in self.view.subviews {
//            if let labelCounter = label as? UILabel {
//                if labelCounter.restorationIdentifier ==  "labelCounter" {
//                    if Time.getSecondsTillFinish() <= 0 {
//                        timer.invalidate()
//                        labelCounter.text = "You did it!"
//                    } else {
//                        labelCounter.text = "\(Time.getDateTillFinish()) left"
//                    }
//                }
//            }
//        }
//        
//    }
//    
    
}


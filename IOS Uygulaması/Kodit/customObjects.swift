//
//  customObjects.swift
//  Kodit
//
//  Created by Caglayan Serbetci on 10/09/2017.
//  Copyright © 2017 Caglayan Serbetci. All rights reserved.
//

import Foundation
import UIKit

class connectButton: UIButton {
    public var ispressed = false
    
    override func draw(_ rect: CGRect) {
        KoditSytleKit.drawConnectButton(pressedConnectButton:ispressed)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        self.ispressed = true
        self.setNeedsDisplay()
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesEnded(touches, with: event)
        self.ispressed = false
        self.setNeedsDisplay()
    }
}

class sendButton: UIButton {
    public var isUnpressed = true
    public var isStartAnimation = false
    public var animationAngle: CGFloat = 0
    private var timer: Timer?
    
    override func draw(_ rect: CGRect) {
        KoditSytleKit.drawSendButton(startAnimationConnectButton: isStartAnimation, angleOfRotationConnectButton: CGFloat(animationAngle), unPressedSendButton: isUnpressed)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        self.isUnpressed = false
        self.setNeedsDisplay()
        
        
    }
    
    public func startAnimation(){
        self.isStartAnimation = true
        self.setNeedsDisplay()
        if timer == nil {
            timer = Timer.scheduledTimer(timeInterval: 0.001, target: self, selector: #selector(startAnimationForTimer), userInfo: nil, repeats: true)
            timer!.fire()
        }
    }
    public func stopAnimation(){
        self.isStartAnimation = false
        self.setNeedsDisplay()
        if timer != nil {
            timer!.invalidate()
            timer = nil
        }
    }

    @objc func startAnimationForTimer() {
        self.setNeedsDisplay()
        animationAngle -= 2
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesEnded(touches, with: event)
        self.isUnpressed = true
        self.setNeedsDisplay()
    }
}

class RemoveView: UIView {
    
    override init(frame: CGRect) {
        super.init(frame:frame)
        let imageView = UIImageView(frame: CGRect(x: self.center.x-100, y: self.center.y-100, width: 200, height: 200))
        imageView.image = UIImage(named: "trash_image.png")
        self.addSubview(imageView)
        self.backgroundColor = UIColor.lightGray
        self.alpha = 0.5
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        fatalError("init(coder:) has not been implemented")
    }
}





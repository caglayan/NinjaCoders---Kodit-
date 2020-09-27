//
//  CodeBlocks.swift
//  Coditto
//
//  Created by Caglayan Serbetci on 31/08/2017.
//  Copyright © 2017 Caglayan Serbetci. All rights reserved.
//

import UIKit

class CodeBlocks: UIView{
    private var panGestureRecognizer: UIPanGestureRecognizer!
    open var isShadowOccured: Bool!
    open var delegate: CodeBlocksDelegate?
    open var command: KoditCommands?
    open var type: CodeBlockType?
    
    /**
     draw func
     */
    override func draw(_ rect: CGRect) {
        print("This method is a override method for a uiview for drawing something in layer")
    }
    
    /**
     Class initialization
     */
    init(frame: CGRect, delegate internaldelegate:CodeBlocksDelegate?) {
        super.init(frame: frame)
        self.delegate = internaldelegate
        self.panGestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(gestureRecognize(_:)))
        self.addGestureRecognizer(panGestureRecognizer)
        self.backgroundColor = .clear
        self.isShadowOccured = false
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.isShadowOccured = false
    }
    /**
     Class deinitializaion
     */
    deinit{
        print("deinitialization occurs")
    }
    
    /**
     gesture recognizes in this method
     */
    @objc private func gestureRecognize(_ gestureRecognizer: UIPanGestureRecognizer){
        self.delegate?.panPressRecognized(gestureRecognizer: gestureRecognizer)
        let translation = gestureRecognizer.translation(in: self)
        self.center = CGPoint(x: self.center.x + translation.x, y: self.center.y + translation.y)
        gestureRecognizer.setTranslation(.zero, in: self)
    }
    
    
    private func addShadowToCodelock(){
        self.layer.shadowColor = UIColor.white.cgColor
        self.layer.shadowOffset = CGSize(width: 0, height: 0)
        self.layer.shadowRadius = 10.0
        self.layer.shadowOpacity = 1.0
        let animation = CABasicAnimation(keyPath: "shadowOpacity")
        animation.fromValue = 0.0
        animation.toValue = 1.0
        animation.duration = 0.5
        self.layer.add(animation, forKey: animation.keyPath)
        
    }
    
    private func removeShadowCodeBlock() {
        let animation = CABasicAnimation(keyPath: "shadowOpacity")
        animation.fromValue = 1.0
        animation.toValue = 0.0
        animation.duration = 0.5
        self.layer.shadowOpacity = 0.0
        self.layer.add(animation, forKey: animation.keyPath)
        self.isShadowOccured = false
    }

    /**
     shadow animation polymorphisim
     */
    open func addShadow(){
        if self.isShadowOccured == false {
            self.addShadowToCodelock()
            self.isShadowOccured = true
            return
        }
    }
    
    /**
     shadow animation polymorphisim
     */
    open func removeShadow(){
        if self.isShadowOccured == true {
            self.removeShadowCodeBlock()
            self.isShadowOccured = false
        }
    }
    
    /**
     Booleon value for enable gesture recognizer
     */
    open func disablePanGesture(){
        self.panGestureRecognizer.isEnabled = false
    }
    
    open func enablePanGesture(){
        self.panGestureRecognizer.isEnabled = true
    }
    
}

protocol CodeBlocksDelegate:NSObjectProtocol {
    func panPressRecognized(gestureRecognizer recognizer:UIGestureRecognizer)
}


class startBlock: CodeBlocks {

    init(center: CGPoint?, delegate internaldelegate:CodeBlocksDelegate?) {
        let frameSize = CGSize(width: 150, height: 50)
        let frameOrigin = CGPoint(x: center!.x - frameSize.width/2, y: center!.y - frameSize.height/2)
        let frame = CGRect(origin: frameOrigin, size: frameSize)
        super.init(frame: frame, delegate: internaldelegate)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    
    override func draw(_ rect: CGRect) {
        KoditSytleKit.drawStartBlock()
    }
}


class NBLRBlock_ileri: CodeBlocks {
    
    init(center: CGPoint?, delegate internaldelegate:CodeBlocksDelegate?) {
        let frameSize = CGSize(width: 150, height: 50)
        let frameOrigin = CGPoint(x: center!.x - frameSize.width/2, y: center!.y - frameSize.height/2)
        let frame = CGRect(origin: frameOrigin, size: frameSize)
        super.init(frame: frame, delegate: internaldelegate)
        type = CodeBlockType(mainType:.yon, subType: .ileri)
        command = KoditCommands.ileri

    }
    
    override func draw(_ rect: CGRect) {
        KoditSytleKit.drawNLBRBlockileri()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class NBLRBlock_geri: CodeBlocks {
 
    init(center: CGPoint?, delegate internaldelegate:CodeBlocksDelegate?) {
        let frameSize = CGSize(width: 150, height: 50)
        let frameOrigin = CGPoint(x: center!.x - frameSize.width/2, y: center!.y - frameSize.height/2)
        let frame = CGRect(origin: frameOrigin, size: frameSize)
        super.init(frame: frame, delegate: internaldelegate)
        type = CodeBlockType(mainType:.yon, subType: .geri)
        command = KoditCommands.geri

    }
    
    override func draw(_ rect: CGRect) {
        KoditSytleKit.drawNLBRBlockgeri()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class NBLRBlock_sag: CodeBlocks {
 
    init(center: CGPoint?, delegate internaldelegate:CodeBlocksDelegate?) {
        let frameSize = CGSize(width: 150, height: 50)
        let frameOrigin = CGPoint(x: center!.x - frameSize.width/2, y: center!.y - frameSize.height/2)
        let frame = CGRect(origin: frameOrigin, size: frameSize)
        super.init(frame: frame, delegate: internaldelegate)
        type = CodeBlockType(mainType:.yon, subType: .sag)
        command = KoditCommands.sag
    }
    
    override func draw(_ rect: CGRect) {
        KoditSytleKit.drawNLBRBlocksag()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class NBLRBlock_sol: CodeBlocks {
 
    init(center: CGPoint?, delegate internaldelegate:CodeBlocksDelegate?) {
        let frameSize = CGSize(width: 150, height: 50)
        let frameOrigin = CGPoint(x: center!.x - frameSize.width/2, y: center!.y - frameSize.height/2)
        let frame = CGRect(origin: frameOrigin, size: frameSize)
        super.init(frame: frame, delegate: internaldelegate)
        type = CodeBlockType(mainType:.yon, subType: .sol)
        command = KoditCommands.sol
    }
    
    override func draw(_ rect: CGRect) {
        KoditSytleKit.drawNLBRBlocksol()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class Komut_ses: CodeBlocks {
    
    init(center: CGPoint?, delegate internaldelegate:CodeBlocksDelegate?) {
        let frameSize = CGSize(width: 150, height: 50)
        let frameOrigin = CGPoint(x: center!.x - frameSize.width/2, y: center!.y - frameSize.height/2)
        let frame = CGRect(origin: frameOrigin, size: frameSize)
        super.init(frame: frame, delegate: internaldelegate)
    }
    
    override func draw(_ rect: CGRect) {
        KoditSytleKit.drawKomutBlockses()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class Komut_led: CodeBlocks {
    
    init(center: CGPoint?, delegate internaldelegate:CodeBlocksDelegate?) {
        let frameSize = CGSize(width: 150, height: 50)
        let frameOrigin = CGPoint(x: center!.x - frameSize.width/2, y: center!.y - frameSize.height/2)
        let frame = CGRect(origin: frameOrigin, size: frameSize)
        super.init(frame: frame, delegate: internaldelegate)
    }
    
    override func draw(_ rect: CGRect) {
        KoditSytleKit.drawKomutBlockled()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}







//
//class StartBlock: CodeBlocks {
//    private var shadowLayer: CALayer!
//    open var isShadowOccured: Bool!
//
//    override init(frame: CGRect, delegate internaldelegate:CodeBlocksDelegate?) {
//        var startBlockFrame = CGRect(x: 0, y: 0, width: 100, height: 50)
//        startBlockFrame.origin = frame.origin
//        super.init(frame: startBlockFrame, delegate: internaldelegate)
//        self.isShadowOccured = false
//    }
//
//    override func draw(_ rect: CGRect) {
//        let shapeLayer = createShapeLayer()
//        self.layer.addSublayer(shapeLayer)
//    }
//
//    private func createShapeLayer()->CAShapeLayer{
//        let path = UIBezierPath()
//        path.move(to: CGPoint(x: 0, y: 10))
//        path.addArc(withCenter: CGPoint(x:10, y:10), radius:10, startAngle:CGFloat.pi, endAngle:(CGFloat.pi/2)*3, clockwise: true)
//        path.addLine(to: CGPoint(x:self.bounds.size.width-10, y: 0))
//        path.addArc(withCenter: CGPoint(x:self.bounds.size.width-10, y:10), radius: 10, startAngle:(CGFloat.pi/2)*3, endAngle:0, clockwise: true)
//        path.addLine(to: CGPoint(x:self.bounds.size.width, y:self.bounds.size.height-10))
//        path.addArc(withCenter: CGPoint(x:self.bounds.size.width-10, y:self.bounds.size.height-20), radius: 10, startAngle:0, endAngle:CGFloat.pi/2, clockwise: true)
//        path.addLine(to: CGPoint(x:(self.bounds.size.width/3)-10, y:self.bounds.size.height-10))
//        path.addArc(withCenter: CGPoint(x:(self.bounds.size.width/3), y:self.bounds.size.height-10), radius: 10, startAngle:0, endAngle:CGFloat.pi, clockwise: true)
//        path.addLine(to: CGPoint(x:0, y:self.bounds.size.height-10))
//        path.close()
//        let layer = CAShapeLayer()
//        layer.path=path.cgPath
//      //  layer.fillColor = Palette.palette_yellow.cgColor
//        return layer
//    }
//
//    private func addShadowToStartBlock(){
//        shadowLayer = CALayer()
//        shadowLayer.shadowColor = UIColor.green.cgColor
//        shadowLayer.shadowOffset = CGSize(width: 0, height: 0)
//        shadowLayer.shadowRadius = 10.0
//        shadowLayer.shadowOpacity = 1.0
//        let animation = CABasicAnimation(keyPath: "shadowOpacity")
//        animation.fromValue = 0.0
//        animation.toValue = 1.0
//        animation.duration = 0.3
//        shadowLayer.add(animation, forKey: animation.keyPath)
//        shadowLayer.addSublayer(createShapeLayer())
//        self.layer.addSublayer(shadowLayer)
//    }
//
//    private func removeShadowToStartBlock(){
//        let animation = CABasicAnimation(keyPath: "shadowOpacity")
//        animation.fromValue = 1.0
//        animation.toValue = 0.0
//        animation.duration = 0.3
//        shadowLayer.shadowOpacity = 0.0
//        shadowLayer.add(animation, forKey: animation.keyPath)
//    }
//
//    override func removeShadow(){
//        guard self.isShadowOccured == false else {
//            self.removeShadowToStartBlock()
//            self.isShadowOccured = false
//            return
//        }
//    }
//
//    override func addShadow(){
//        guard self.isShadowOccured else {
//            self.addShadowToStartBlock()
//            self.isShadowOccured = true
//            return
//        }
//    }
//
//    required init?(coder aDecoder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
//}
//    private func createShapeLayer()->CAShapeLayer{
//        let path = UIBezierPath()
//        path.move(to: CGPoint(x:0,y:10))
//        path.addLine(to: CGPoint(x:self.bounds.size.width/3-10,y:10))
//        path.addArc(withCenter: CGPoint(x:self.bounds.size.width/3,y:10), radius: 10, startAngle: CGFloat.pi, endAngle: 0, clockwise: false)
//        path.addLine(to: CGPoint(x:self.bounds.size.width-10, y: 10))
//        path.addArc(withCenter: CGPoint(x:self.bounds.size.width-10, y:20), radius: 10, startAngle:(CGFloat.pi/2)*3, endAngle:0, clockwise: true)
//        path.addLine(to: CGPoint(x:self.bounds.size.width, y:self.bounds.size.height-10))
//        path.addArc(withCenter: CGPoint(x:self.bounds.size.width-10, y:self.bounds.size.height-20), radius: 10, startAngle:0, endAngle:CGFloat.pi/2, clockwise: true)
//        path.addLine(to: CGPoint(x:(self.bounds.size.width/3)-10, y:self.bounds.size.height-10))
//        path.addArc(withCenter: CGPoint(x:(self.bounds.size.width/3), y:self.bounds.size.height-10), radius: 10, startAngle:0, endAngle:CGFloat.pi, clockwise: true)
//        path.addLine(to: CGPoint(x:0, y:self.bounds.size.height-10))
//        path.close()
//        let layer = CAShapeLayer()
//        layer.path=path.cgPath
//        //layer.fillColor = Palette.palette_main.cgColor
//        return layer
//    }


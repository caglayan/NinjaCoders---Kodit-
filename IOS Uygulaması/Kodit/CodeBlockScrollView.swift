//
//  CodeBlockScrollView.swift
//  Kodit
//
//  Created by Caglayan Serbetci on 10/09/2017.
//  Copyright © 2017 Caglayan Serbetci. All rights reserved.
//

import UIKit

public struct CodeBlockType {
    enum type{
        case yon
        case komut
    }
    
    enum subtype{
        case ileri
        case geri
        case sol
        case sag
        case ses
        case led
    }
    
    let mainType: type!
    let subType: subtype!
}

class CodeBlockScrollView: UIScrollView {

    public var delegateCodeBlockScroolView: CodeBlockScrollViewDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.contentSize = CGSize.init(width: frame.size.width, height: frame.size.height+30)
        createYonBloklarıView(frame)
    }
    
    public func addRemoveView(removeView: UIView!){
        self.addSubview(removeView)
    }
    
    private func createYonBloklarıView(_ frame: CGRect){
        let yonBlokLabel = UILabel.init(frame: CGRect(x: 25, y: 40, width: 250, height: 40))
        yonBlokLabel.text = "yön blokları"
        yonBlokLabel.textAlignment = .center
        yonBlokLabel.textColor = UIColor.white
        yonBlokLabel.font = UIFont(name: "HelveticaNeue-Bold", size: 30)
        self.addSubview(yonBlokLabel)
        
        let yonBlokWhiteLine = UIView.init(frame: CGRect(x: 25, y: 80, width: 250, height: 1))
        yonBlokWhiteLine.backgroundColor = UIColor.white
        self.addSubview(yonBlokWhiteLine)
        
        let ileri = ileriCodeBlock(frame: CGRect(x: 25, y: 120, width: 150, height: 50))
        self.addSubview(ileri)
        
        let sag = sagCodeBlock(frame: CGRect(x: 25, y: 210, width: 150, height: 50))
        self.addSubview(sag)
        
        let sol = solCodeBlock(frame: CGRect(x: 25, y: 300, width: 150, height: 50))
        self.addSubview(sol)
        
        let geri = geriCodeBlock(frame: CGRect(x: 25, y: 390, width: 150, height: 50))
        self.addSubview(geri)
        
        let komutBlokLabel = UILabel.init(frame: CGRect(x: 25, y: 500, width: 250, height: 40))
        komutBlokLabel.text = "komut blokları"
        komutBlokLabel.textAlignment = .center
        komutBlokLabel.textColor = UIColor.white
        komutBlokLabel.font = UIFont(name: "HelveticaNeue-Bold", size: 30)
        self.addSubview(komutBlokLabel)

        let komutLabelWhiteLine = UIView.init(frame: CGRect(x: 25, y: 540, width: 250, height: 1))
        komutLabelWhiteLine.backgroundColor = UIColor.white
        self.addSubview(komutLabelWhiteLine)
        
        let ses = sesCodeBlock(frame: CGRect(x: 25, y: 580, width: 150, height: 50))
        self.addSubview(ses)
        
        let led = ledCodeBlock(frame: CGRect(x: 25, y: 670, width: 150, height: 50))
        self.addSubview(led)


    
    }
    // nib awaken
    override func awakeFromNib() {
        super.awakeFromNib()
        self.contentSize = CGSize.init(width: frame.size.width, height: frame.size.height+30)
        createYonBloklarıView(frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    public func touchedCodeBlocks(blocktype type: CodeBlockType, locationOfGesture: CGPoint, state: Int){
        delegateCodeBlockScroolView?.touchedCodeBlock(blocktype: type, locationOfGesture: locationOfGesture, state: state)
    }
    

}














protocol  CodeBlockScrollViewDelegate {
    func touchedCodeBlock(blocktype type: CodeBlockType, locationOfGesture: CGPoint, state: Int)
}

















internal class ileriCodeBlock: UIView{
    
    public let type = CodeBlockType(mainType:.yon, subType: .ileri)
    var longGestureRecognizer: UILongPressGestureRecognizer!
    
    override init(frame: CGRect) {
        super.init(frame:frame)
        self.backgroundColor = UIColor.clear
        longGestureRecognizer = UILongPressGestureRecognizer(target: self, action: #selector(gestureRecognize(_:)))
        longGestureRecognizer.numberOfTouchesRequired = 1
        longGestureRecognizer.minimumPressDuration = 0.0
        longGestureRecognizer.allowableMovement = 1.0
        self.addGestureRecognizer(longGestureRecognizer)
    }
    
    @objc private func gestureRecognize(_ gestureRecognizer: UILongPressGestureRecognizer){
            switch gestureRecognizer.state {
            case .began:
                print("tap began")
                let translation = gestureRecognizer.location(in: (self.superview as! CodeBlockScrollView))
                (self.superview as! CodeBlockScrollView).touchedCodeBlocks(blocktype: type, locationOfGesture: translation, state: 1)
            case .changed:
                let translation = gestureRecognizer.location(in: (self.superview as! CodeBlockScrollView))
                (self.superview as! CodeBlockScrollView).touchedCodeBlocks(blocktype: type, locationOfGesture: translation, state: 2)
            case .ended:
                let translation = gestureRecognizer.location(in: (self.superview as! CodeBlockScrollView))
                (self.superview as! CodeBlockScrollView).touchedCodeBlocks(blocktype: type, locationOfGesture: translation, state: 3)
                print("tap ended")
            default:
                print("gesture in different state")
            }
    }

    override func draw(_ rect: CGRect) {
        KoditSytleKit.drawNLBRBlockileri()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}

internal class sagCodeBlock: UIView{
    
    public let type = CodeBlockType(mainType:.yon, subType: .sag)
    var longGestureRecognizer: UILongPressGestureRecognizer!
    
    override init(frame: CGRect) {
        super.init(frame:frame)
        self.backgroundColor = UIColor.clear
        longGestureRecognizer = UILongPressGestureRecognizer(target: self, action: #selector(gestureRecognize(_:)))
        longGestureRecognizer.numberOfTouchesRequired = 1
        longGestureRecognizer.minimumPressDuration = 0.0
        longGestureRecognizer.allowableMovement = 1.0
        self.addGestureRecognizer(longGestureRecognizer)
    }
    
    @objc private func gestureRecognize(_ gestureRecognizer: UILongPressGestureRecognizer){
        switch gestureRecognizer.state {
        case .began:
            print("tap began")
            let translation = gestureRecognizer.location(in: (self.superview as! CodeBlockScrollView))
            (self.superview as! CodeBlockScrollView).touchedCodeBlocks(blocktype: type, locationOfGesture: translation, state: 1)
        case .changed:
            let translation = gestureRecognizer.location(in: (self.superview as! CodeBlockScrollView))
            (self.superview as! CodeBlockScrollView).touchedCodeBlocks(blocktype: type, locationOfGesture: translation, state: 2)
        case .ended:
            let translation = gestureRecognizer.location(in: (self.superview as! CodeBlockScrollView))
            (self.superview as! CodeBlockScrollView).touchedCodeBlocks(blocktype: type, locationOfGesture: translation, state: 3)
            print("tap ended")
        default:
            print("gesture in different state")
        }
    }
    
    override func draw(_ rect: CGRect) {
        KoditSytleKit.drawNLBRBlocksag()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}

internal class solCodeBlock: UIView{
    
    public let type = CodeBlockType(mainType:.yon, subType: .sol)
    var longGestureRecognizer: UILongPressGestureRecognizer!
    
    override init(frame: CGRect) {
        super.init(frame:frame)
        self.backgroundColor = UIColor.clear
        longGestureRecognizer = UILongPressGestureRecognizer(target: self, action: #selector(gestureRecognize(_:)))
        longGestureRecognizer.numberOfTouchesRequired = 1
        longGestureRecognizer.minimumPressDuration = 0.0
        longGestureRecognizer.allowableMovement = 1.0
        self.addGestureRecognizer(longGestureRecognizer)
    }
    
    @objc private func gestureRecognize(_ gestureRecognizer: UILongPressGestureRecognizer){
        switch gestureRecognizer.state {
        case .began:
            print("tap began")
            let translation = gestureRecognizer.location(in: (self.superview as! CodeBlockScrollView))
            (self.superview as! CodeBlockScrollView).touchedCodeBlocks(blocktype: type, locationOfGesture: translation, state: 1)
        case .changed:
            let translation = gestureRecognizer.location(in: (self.superview as! CodeBlockScrollView))
            (self.superview as! CodeBlockScrollView).touchedCodeBlocks(blocktype: type, locationOfGesture: translation, state: 2)
        case .ended:
            let translation = gestureRecognizer.location(in: (self.superview as! CodeBlockScrollView))
            (self.superview as! CodeBlockScrollView).touchedCodeBlocks(blocktype: type, locationOfGesture: translation, state: 3)
            print("tap ended")
        default:
            print("gesture in different state")
        }
    }
    
    override func draw(_ rect: CGRect) {
        KoditSytleKit.drawNLBRBlocksol()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}

internal class geriCodeBlock: UIView{
    
    public let type = CodeBlockType(mainType:.yon, subType: .geri)
    var longGestureRecognizer: UILongPressGestureRecognizer!
    
    override init(frame: CGRect) {
        super.init(frame:frame)
        self.backgroundColor = UIColor.clear
        longGestureRecognizer = UILongPressGestureRecognizer(target: self, action: #selector(gestureRecognize(_:)))
        longGestureRecognizer.numberOfTouchesRequired = 1
        longGestureRecognizer.minimumPressDuration = 0.0
        longGestureRecognizer.allowableMovement = 1.0
        self.addGestureRecognizer(longGestureRecognizer)
    }
    
    @objc private func gestureRecognize(_ gestureRecognizer: UILongPressGestureRecognizer){
        switch gestureRecognizer.state {
        case .began:
            print("tap began")
            let translation = gestureRecognizer.location(in: (self.superview as! CodeBlockScrollView))
            (self.superview as! CodeBlockScrollView).touchedCodeBlocks(blocktype: type, locationOfGesture: translation, state: 1)
        case .changed:
            let translation = gestureRecognizer.location(in: (self.superview as! CodeBlockScrollView))
            (self.superview as! CodeBlockScrollView).touchedCodeBlocks(blocktype: type, locationOfGesture: translation, state: 2)
        case .ended:
            let translation = gestureRecognizer.location(in: (self.superview as! CodeBlockScrollView))
            (self.superview as! CodeBlockScrollView).touchedCodeBlocks(blocktype: type, locationOfGesture: translation, state: 3)
            print("tap ended")
        default:
            print("gesture in different state")
        }
    }
    
    override func draw(_ rect: CGRect) {
        KoditSytleKit.drawNLBRBlockgeri()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    
}

internal class sesCodeBlock: UIView{
    
    public let type = CodeBlockType(mainType:.komut, subType: .ses)
    var longGestureRecognizer: UILongPressGestureRecognizer!
    
    override init(frame: CGRect) {
        super.init(frame:frame)
        self.backgroundColor = UIColor.clear
        longGestureRecognizer = UILongPressGestureRecognizer(target: self, action: #selector(gestureRecognize(_:)))
        longGestureRecognizer.numberOfTouchesRequired = 1
        longGestureRecognizer.minimumPressDuration = 0.0
        longGestureRecognizer.allowableMovement = 1.0
        self.addGestureRecognizer(longGestureRecognizer)
    }
    
    @objc private func gestureRecognize(_ gestureRecognizer: UILongPressGestureRecognizer){
        switch gestureRecognizer.state {
        case .began:
            print("tap began")
            let translation = gestureRecognizer.location(in: (self.superview as! CodeBlockScrollView))
            (self.superview as! CodeBlockScrollView).touchedCodeBlocks(blocktype: type, locationOfGesture: translation, state: 1)
        case .changed:
            let translation = gestureRecognizer.location(in: (self.superview as! CodeBlockScrollView))
            (self.superview as! CodeBlockScrollView).touchedCodeBlocks(blocktype: type, locationOfGesture: translation, state: 2)
        case .ended:
            let translation = gestureRecognizer.location(in: (self.superview as! CodeBlockScrollView))
            (self.superview as! CodeBlockScrollView).touchedCodeBlocks(blocktype: type, locationOfGesture: translation, state: 3)
            print("tap ended")
        default:
            print("gesture in different state")
        }
    }
    override func draw(_ rect: CGRect) {
        KoditSytleKit.drawKomutBlockses()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}


internal class ledCodeBlock: UIView{
    
    public let type = CodeBlockType(mainType:.komut, subType: .led)
    var longGestureRecognizer: UILongPressGestureRecognizer!
    
    override init(frame: CGRect) {
        super.init(frame:frame)
        self.backgroundColor = UIColor.clear
        longGestureRecognizer = UILongPressGestureRecognizer(target: self, action: #selector(gestureRecognize(_:)))
        longGestureRecognizer.numberOfTouchesRequired = 1
        longGestureRecognizer.minimumPressDuration = 0.0
        longGestureRecognizer.allowableMovement = 1.0
        self.addGestureRecognizer(longGestureRecognizer)
    }
    
    @objc private func gestureRecognize(_ gestureRecognizer: UILongPressGestureRecognizer){
        switch gestureRecognizer.state {
        case .began:
            print("tap began")
            let translation = gestureRecognizer.location(in: (self.superview as! CodeBlockScrollView))
            (self.superview as! CodeBlockScrollView).touchedCodeBlocks(blocktype: type, locationOfGesture: translation, state: 1)
        case .changed:
            let translation = gestureRecognizer.location(in: (self.superview as! CodeBlockScrollView))
            (self.superview as! CodeBlockScrollView).touchedCodeBlocks(blocktype: type, locationOfGesture: translation, state: 2)
        case .ended:
            let translation = gestureRecognizer.location(in: (self.superview as! CodeBlockScrollView))
            (self.superview as! CodeBlockScrollView).touchedCodeBlocks(blocktype: type, locationOfGesture: translation, state: 3)
            print("tap ended")
        default:
            print("gesture in different state")
        }
    }
    
    override func draw(_ rect: CGRect) {
        KoditSytleKit.drawKomutBlockled()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}












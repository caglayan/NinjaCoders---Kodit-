//
//  BlockEngine.swift
//  Coditto
//
//  Created by Caglayan Serbetci on 08/09/2017.
//  Copyright © 2017 Caglayan Serbetci. All rights reserved.
//

import UIKit

class BlockEngine: NSObject {
    
    open var mainCommands = Array<CodeBlocks>()
    open var freeCommands = Array<CodeBlocks>()
    open var removeView: RemoveView?
    
    /**
     initialize blockengine
     */
    init(startBlock:CodeBlocks!, removeViewFrame: CGRect!){
        super.init()
        mainCommands.append(startBlock)
        self.removeView = RemoveView(frame: removeViewFrame)
        self.removeView?.isHidden = true
    }
    
    open func addFreeCommands(add block:CodeBlocks){
        freeCommands.append(block)
        print("free blocks number: \(freeCommands.count)")
    }
    
    open func checkLocationOfBlocks(_ checkedBlock:CodeBlocks!){
        if mainCommands.count != 0 {
            if (mainCommands.last!.frame.intersects(checkedBlock.frame)){
                print("intersection Occured")
                self.addShadowMainCommands()
            }else{
                self.removeShadowMainCommands()
            }
            if (checkedBlock.frame.intersects((removeView?.frame)!)){
                print("intersection remove View Occured")
                if (removeView?.isHidden)! {
                    removeView?.isHidden = false
                }
            }
        }
    }
    
    private func addShadowMainCommands(){
        for codeBlock in mainCommands {
            codeBlock.addShadow()
        }
    }
    
    private func removeShadowMainCommands(){
        for codeBlock in mainCommands {
            codeBlock.removeShadow()
        }
    }
    
    open func checkLastLocationOfBlocks(_ checkedBlock:CodeBlocks!){
        var addedCodeBlock = checkedBlock
        if mainCommands.count != 0 {
            if mainCommands.last == addedCodeBlock {
                mainCommands.removeLast()
                if !(self.mainCommands.last is startBlock) {
                    self.mainCommands.last?.enablePanGesture()
                }
            }
            if (mainCommands.last?.frame.intersects(checkedBlock.frame))!{
                print("intersection last occured")
                UIView.animate(withDuration: 0.3, animations: { 
                    checkedBlock.layer.frame.origin = CGPoint(x: (self.mainCommands.last?.frame.origin.x)!+1, y: (self.mainCommands.last?.frame.origin.y)!+(self.mainCommands.last?.frame.size.height)!-10)
                }, completion: { _ in
                    self.removeShadowMainCommands()
                    if !(self.mainCommands.last is startBlock) {
                        self.mainCommands.last?.disablePanGesture()
                    }
                    self.mainCommands.append(addedCodeBlock!)
                    
                })
            }else{
                self.removeShadowMainCommands()
            }
            
            if (addedCodeBlock?.frame.intersects((self.removeView?.frame)!))!{
                print("block will removed")
                self.removeView?.isHidden = true
                UIView.animate(withDuration: 0.3, animations: {
                    addedCodeBlock?.alpha = 0
                },completion: { _ in
                    addedCodeBlock?.removeFromSuperview()
                    addedCodeBlock = nil
                })
                
            }else{
               removeView?.isHidden = true
            }
            
        }
    }
}

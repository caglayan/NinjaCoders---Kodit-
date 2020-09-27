//
//  MainViewController.swift
//  Kodit
//
//  Created by Caglayan Serbetci on 10/09/2017.
//  Copyright © 2017 Caglayan Serbetci. All rights reserved.
//

import UIKit

class MainViewController: UIViewController,CodeBlockScrollViewDelegate,CodeBlocksDelegate {
    var bluetoothManager: BluetoothEngine!
    var blockEngine: BlockEngine!
    var timer : Timer?
    @IBOutlet weak var codeBlockScrollView: CodeBlockScrollView!
    @IBOutlet weak var startBlock: startBlock!
    @IBOutlet weak var connectButton: sendButton!
    @IBAction func connectButtonAction(_ sender: Any) {
        if blockEngine.mainCommands.count == 1 {
            self.startAlert(withMessage: "hiç bir şey eklemedin ama :(")
        }else{
            connectButton.startAnimation()
            //bluetoothManager.sendCommandToKodit(command: blockEngine.mainCommands[1].command!)
            if timer == nil {
                timer = Timer.scheduledTimer(timeInterval: 1.5, target: self, selector: #selector(sendMainCommands), userInfo: nil, repeats: true)
                timer!.fire()
            }
        }
    }
    
    var mainCodeBlockOrder = 1 // default added startBlock
    @objc func sendMainCommands(){
        bluetoothManager.sendCommandToKodit(command: blockEngine.mainCommands[mainCodeBlockOrder].command!)
        mainCodeBlockOrder = mainCodeBlockOrder + 1
        if mainCodeBlockOrder == blockEngine.mainCommands.count {
            if timer != nil {
                timer!.invalidate()
                timer = nil
                mainCodeBlockOrder = 1
                timer = Timer.scheduledTimer(timeInterval: 1.5, target: self, selector: #selector(stop), userInfo: nil, repeats: true)
                timer!.fire()
            }
        }
    }
    
    
    ///// BURALAR SAÇMA GECE 1
    var k = 0
    @objc func stop() {
        k = k + 1
        if timer != nil && k == 2 {
            timer!.invalidate()
            timer = nil
            connectButton.stopAnimation()
            k = 0
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        codeBlockScrollView.delegateCodeBlockScroolView = self
        // initialize Blockengine
        blockEngine =  BlockEngine.init(startBlock: startBlock, removeViewFrame: codeBlockScrollView.frame)
    }
    
    override func viewDidAppear(_ animated: Bool) {
         codeBlockScrollView.addRemoveView(removeView: blockEngine.removeView!)
    }
    
    // scrollVeiw Delegate
    var willMovedView: CodeBlocks!
    func  touchedCodeBlock(blocktype type: CodeBlockType, locationOfGesture: CGPoint, state: Int) {
        switch state {
        case 1:
            print("new block is created")
            if type.mainType == CodeBlockType.type.yon && type.subType == CodeBlockType.subtype.ileri {
                let ileriNLBRBlock = NBLRBlock_ileri(center: locationOfGesture, delegate: self)
                self.view.addSubview(ileriNLBRBlock)
                ileriNLBRBlock.addShadow()
                willMovedView = ileriNLBRBlock
            }else if type.mainType == CodeBlockType.type.yon && type.subType == CodeBlockType.subtype.geri {
                let geriNLBRBlock = NBLRBlock_geri(center: locationOfGesture, delegate: self)
                self.view.addSubview(geriNLBRBlock)
                geriNLBRBlock.addShadow()
                willMovedView = geriNLBRBlock
            }else if type.mainType == CodeBlockType.type.yon && type.subType == CodeBlockType.subtype.sag {
                let sagNLBRBlock = NBLRBlock_sag(center: locationOfGesture, delegate: self)
                self.view.addSubview(sagNLBRBlock)
                sagNLBRBlock.addShadow()
                willMovedView = sagNLBRBlock
            }else if type.mainType == CodeBlockType.type.yon && type.subType == CodeBlockType.subtype.sol {
                let solNLBRBlock = NBLRBlock_sol(center: locationOfGesture, delegate: self)
                self.view.addSubview(solNLBRBlock)
                solNLBRBlock.addShadow()
                willMovedView = solNLBRBlock
            }else if type.mainType == CodeBlockType.type.komut && type.subType == CodeBlockType.subtype.ses {
                let sesBlock = Komut_ses(center: locationOfGesture, delegate: self)
                self.view.addSubview(sesBlock)
                sesBlock.addShadow()
                willMovedView = sesBlock
            }else if type.mainType == CodeBlockType.type.komut && type.subType == CodeBlockType.subtype.led {
                let ledBlock = Komut_led(center: locationOfGesture, delegate: self)
                self.view.addSubview(ledBlock)
                ledBlock.addShadow()
                willMovedView = ledBlock
            }
        case 2:
            willMovedView.center = locationOfGesture
            blockEngine.checkLocationOfBlocks(willMovedView)
        case 3:
            willMovedView.removeShadow()
            blockEngine.checkLastLocationOfBlocks(willMovedView)
        default:
            print("unrecognized state")
        }
    }
    
    // Code Blcoks Delegate
    
    func panPressRecognized(gestureRecognizer recognizer: UIGestureRecognizer) {
        let codeBlock = (recognizer.view as! CodeBlocks)
        switch recognizer.state {
        case .began:
            print("pan press began")
            codeBlock.addShadow()
            blockEngine.checkLocationOfBlocks(codeBlock)
        case .ended:
            print("pan press ended")
            codeBlock.removeShadow()
            blockEngine.checkLastLocationOfBlocks(codeBlock)
        case .failed:
            print("pan press failed")
            codeBlock.removeShadow()
            blockEngine.checkLastLocationOfBlocks(codeBlock)
        case .cancelled:
            print("pan press cancelled")
            codeBlock.removeShadow()
            blockEngine.checkLastLocationOfBlocks(codeBlock)
        case .changed:
            print("pan press continue")
            blockEngine.checkLocationOfBlocks(codeBlock)
        default:
            print("different state")
        }
        
    }
    
    private func startAlert(withMessage text: String!){
        let alert = UIAlertController(title: "Alarm", message: text, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "Tamam", style: UIAlertAction.Style.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
        
    }
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
 }

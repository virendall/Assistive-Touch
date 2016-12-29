//
//  AssistiveTouch.swift
//  AssistiveDemo
//
//  Created by DS on 29/12/16.
//  Copyright © 2016 DS. All rights reserved.
//

import UIKit

class AssistiveTouch: UIWindow {
    
    static var instance:AssistiveTouch = AssistiveTouch(frame: UIScreen.main.bounds)
    var canDrag:Bool = true{
        didSet{
            self.panGesture.isEnabled = canDrag
        }
    }
    var isFullScreen:Bool = false;
    var smallSize:CGRect = CGRect(x: 0, y: 100, width: 50, height: 50)
    let kScreenSize = UIScreen.main.bounds.size;
    var touchView:UIView!
    var touchButton:UIButton!
    var panGesture:UIPanGestureRecognizer!
    // MARK: init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.commonInIt()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.commonInIt()
    }
    
    // MARK: init touch view
    
    func commonInIt(){
        self.touchView = UIView(frame: smallSize)
        self.touchButton = UIButton(frame:touchView.bounds)
        self.touchButton.backgroundColor = UIColor.black
        self.touchView.backgroundColor = UIColor.black
        self.touchButton.addTarget(self, action: #selector(touchButtonClick(sender:)), for: .touchUpInside)
        self.touchView.addSubview(self.touchButton)
        self.touchView.isUserInteractionEnabled = true
        self.panGesture = UIPanGestureRecognizer()
        self.panGesture.addTarget(self, action: #selector(panGestureHandle(panGesture:)))
        self.touchView.addGestureRecognizer(self.panGesture)
        self.canDrag = true
        self.addSubview(self.touchView)
    }
    
    func touchButtonClick(sender:UIButton){
        var frame = smallSize
        if isFullScreen {
            isFullScreen = false
            self.canDrag = true
            self.touchButton.isHidden = false
        } else{
            isFullScreen = true
            self.touchButton.isHidden = true
            smallSize = touchView.frame
            let tviewSize = CGSize(width:kScreenSize.width-20, height: kScreenSize.width-20)
            frame = CGRect(x: (kScreenSize.width - tviewSize.width)/2, y: (kScreenSize.height - tviewSize.width)/2, width: tviewSize.width, height: tviewSize.height)
            self.canDrag = false
        }
        UIView.animate(withDuration: 0.3, delay: 0, options: .curveEaseOut, animations: {
            self.touchView.frame = frame
        }, completion: nil)
        
    }
    func showAssistiveTouch(){
        self.isHidden = false
    }
    
    func hideAssistiveTouch(){
        self.isHidden = true
    }
    
    // MARK: Pangesture view
    
    func panGestureHandle(panGesture:UIPanGestureRecognizer){
        switch panGesture.state {
        case .changed:
            let contentViewH = self.touchView.bounds.size.height / 2
            var newCenter = self.touchView.center
            newCenter.y += panGesture.translation(in: self).y
            newCenter.x += panGesture.translation(in: self).x
            panGesture.setTranslation(CGPoint.zero, in: self)
            
            if(newCenter.y > contentViewH && newCenter.y < (kScreenSize.height - contentViewH)){
                self.touchView.center = newCenter
            }
            break;
        
        case .cancelled, .ended:
            var center = self.touchView.center;
            if (self.touchView.center.x > (kScreenSize.width/2)){
                center.x = kScreenSize.width - self.touchView.frame.size.width/2;
            }else{
                center.x = self.touchView.frame.size.width/2;
            }
            UIView.animate(withDuration: 0.3, delay: 0, options: .curveEaseOut, animations: {
                self.touchView.center = center;
            }, completion: nil)
            break;
            
        default:
            break
        }
    }
    
    
    // MARK change properties
    override var isHidden: Bool{
        didSet{
            self.backgroundColor = .clear
        }
    }
    
    override func point(inside point: CGPoint, with event: UIEvent?) -> Bool {
        var allowTouch:Bool = false;
        if self.touchView.frame.contains(point) {
            allowTouch = true;
//            if(isFullScreen){
//                self.touchButtonClick(sender: self.touchButton)
//            }
        }else{
            self.touchButtonClick(sender: self.touchButton)
        }
        if (self.rootViewController != nil)
        {
            allowTouch = true;
        }
        return allowTouch
    }
}

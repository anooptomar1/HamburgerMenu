//
//  ViewController.swift
//  HamburgerMenu
//
//  Created by Anoop tomar on 2/25/15.
//  Copyright (c) 2015 devtechie.com. All rights reserved.
//

import UIKit

enum MenuState{
    case leftOpen
    case none
}

class ViewController: UIViewController, MainViewControllerDelegate, UIGestureRecognizerDelegate {

    var mainViewCtrl: MainViewController?
    var menuViewCtrl: MenuViewController?
    
    var currentState = MenuState.none

    override func viewDidLoad() {
        super.viewDidLoad()
        
        mainViewCtrl = self.storyboard?.instantiateViewControllerWithIdentifier("mainVC") as? MainViewController
        
        mainViewCtrl?.delegate = self
        addMainView()
        addGestures()
    }
    
    func addMainView(){
        self.view.addSubview(mainViewCtrl!.view)
        self.addChildViewController(mainViewCtrl!)
        mainViewCtrl!.didMoveToParentViewController(self)
    }
    
    func addGestures(){
        let panGesture = UIPanGestureRecognizer(target: self, action: "handlePan:")
        self.mainViewCtrl!.view.addGestureRecognizer(panGesture)
    }
    
    func handlePan(recognizer: UIPanGestureRecognizer){
        let gestureLTR = recognizer.velocityInView(view).x > 0
        
        switch recognizer.state{
        
        case .Began:
            if(currentState == MenuState.none){
                if(gestureLTR){
                    initLeftMenu()
                }
            }
        case .Changed:
            recognizer.view!.center.x = recognizer.view!.center.x + recognizer.translationInView(view).x
            recognizer.setTranslation(CGPointZero, inView: view)
        case .Ended:
            if(menuViewCtrl != nil){
                let movedHalf = recognizer.view!.center.x > view.bounds.size.width
                if(movedHalf){
                    addLeftMenu()
                }else{
                    removeLeftMenu()
                }
            }else{
                animateMenu(0)
            }
            
        default: break
        }
    }
    
    func toggleMenu() {
        if(menuViewCtrl == nil){
            initLeftMenu()
            addLeftMenu()
        }else{
            removeLeftMenu()
        }
    }
    
    func animateMenu(transfer: CGFloat, completion: ((Bool) -> Void)! = nil){
        UIView.animateWithDuration(0.5, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0, options: UIViewAnimationOptions.CurveEaseOut, animations: {
            self.mainViewCtrl!.view.frame.origin.x = transfer
            }, completion: completion)
    }
    
    func initLeftMenu(){
        currentState = MenuState.leftOpen
        menuViewCtrl = self.storyboard?.instantiateViewControllerWithIdentifier("menuVC") as? MenuViewController
        
        self.view.insertSubview(menuViewCtrl!.view, atIndex: 0)
        self.addChildViewController(menuViewCtrl!)
        menuViewCtrl?.didMoveToParentViewController(mainViewCtrl)
    }
    
    func addLeftMenu(){
        animateMenu(self.mainViewCtrl!.view.frame.width - 50)
    }
    
    func removeLeftMenu(){
        
        animateMenu(0, completion: {
            finished in
            self.currentState = MenuState.none
            self.menuViewCtrl!.view.removeFromSuperview()
            self.menuViewCtrl!.removeFromParentViewController()
            self.menuViewCtrl = nil
        })
    }

}


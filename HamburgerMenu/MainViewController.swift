//
//  MainViewController.swift
//  HamburgerMenu
//
//  Created by Anoop tomar on 2/25/15.
//  Copyright (c) 2015 devtechie.com. All rights reserved.
//

import UIKit

protocol MainViewControllerDelegate: class{
    
    func toggleMenu()

}

class MainViewController: UIViewController {

    weak var delegate: MainViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func onButton(sender: UIButton) {
        
        self.delegate?.toggleMenu()
        
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

//
//  MenuViewController.swift
//  Flags
//
//  Created by Stephen Henderson on 2015-11-17.
//  Copyright © 2015 hevets. All rights reserved.
//

import UIKit
import Chameleon

class MenuViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func viewWillAppear(animated: Bool) {
        self.navigationController?.setNavigationBarHidden(true, animated: false)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
}

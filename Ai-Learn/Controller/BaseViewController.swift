//
//  BaseViewController.swift
//  Ai-Learn
//
//  Created by V.mio002 on 2/26/20.
//  Copyright © 2020 VmioSystem. All rights reserved.
//

import UIKit

class BaseViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
     
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
           super.viewWillAppear(animated)
           navigationController?.setNavigationBarHidden(true, animated: animated)
       }
    
}

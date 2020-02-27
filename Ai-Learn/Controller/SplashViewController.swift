//
//  SplashViewController.swift
//  Ai-Learn
//
//  Created by V.mio002 on 2/26/20.
//  Copyright © 2020 VmioSystem. All rights reserved.
//

import UIKit
import CoreLocation

class SplashViewController: BaseViewController, CLLocationManagerDelegate {

    @IBOutlet weak var versionLabel: UILabel!
    
    var currentLocation: CLLocation?
    var locationManager: CLLocationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let infoDict = Bundle.main.infoDictionary,
            let appVer = infoDict["CFBundleShortVersionString"] {
            versionLabel.text = "Ver.\(appVer)"
        }
        setNeedsStatusBarAppearanceUpdate()
        locationManager.delegate = self
        locationManager.requestAlwaysAuthorization()
    }
    
    override func viewDidAppear(_ animated: Bool) {
          super.viewDidAppear(animated)
          DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1) {
              if UserDefaults.standard.string(forKey: "companyCode") != nil {
                  
                  let domain = UserDefaults.standard.string(forKey: "domain")  ?? ""
                  let kmsCompany = UserDefaults.standard.string(forKey: "kmsCompany")  ?? ""
                  MIO_HOST = domain
                  KMS_ROOT = kmsCompany
                  let loginVC = LoginViewController()
                  self.navigationController?.pushViewController(loginVC, animated: true)
              } else {
                  let companyCodeVC = CompanyCodeViewController()
                  self.navigationController?.pushViewController(companyCodeVC, animated: true)
              }
          }
      }
    
}

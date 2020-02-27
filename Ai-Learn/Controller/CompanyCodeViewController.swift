//
//  CompanyCodeViewController.swift
//  Ai-Learn
//
//  Created by V.mio002 on 2/26/20.
//  Copyright © 2020 VmioSystem. All rights reserved.
//

import UIKit
import SVProgressHUD
import Alamofire

class CompanyCodeViewController: BaseViewController {

    @IBOutlet weak var viewContent: UIView!
    @IBOutlet weak var companyCodeTextField: UITextField!
    @IBOutlet weak var companyCodeButton: UIButton!
    
    var dismissLogin: Bool = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.viewContent.layer.masksToBounds = true
        self.viewContent.layer.borderColor = #colorLiteral(red: 0.9862299272, green: 1, blue: 0.8979426906, alpha: 1)
        self.viewContent.layer.borderWidth = 1.0
        self.viewContent.layer.cornerRadius = 4.0
        
        self.companyCodeButton.layer.shadowColor = UIColor.black.cgColor
        self.companyCodeButton.layer.shadowRadius = 3.0
        self.companyCodeButton.layer.shadowOpacity = 0.3
        self.companyCodeButton.layer.shadowOffset = CGSize(width: 4, height: 4)
        self.companyCodeButton.layer.masksToBounds = false
        
        self.companyCodeTextField.delegate = self
        
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tap)
    }
  
    @IBAction func onSelectCompany(_ sender: UIButton) {
        if InternetConnectionManager.isConnectedToNetwork() {
            self.requestCompany()
        } else {
            SVProgressHUD.show(withStatus: "認証サーバーに接続出来ません。ネットワーク環境を確認してください。")
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 2) {
                SVProgressHUD.dismiss()
            }
        }
    }
}

extension CompanyCodeViewController: UITextFieldDelegate {
    @objc func dismissKeyboard() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
    }
    
    func requestCompany() {
           SVProgressHUD.show()
                 let paramCompany: Parameters = ["app_token":"6c17d2af3d615c155d90408a8d281fe0", "company_code": companyCodeTextField.text ?? ""]
                 
                 Alamofire.request(CHOOSE_COMPANY, method: .post, parameters: paramCompany, encoding: JSONEncoding.default).responseJSON { (response) in
                     switch response.result {
                     case .success( _):
                         if let valueString = response.result.value as? [String: Any] {
                             if valueString["success"] != nil {
                                 let data = valueString["data"] as? [String: Any]
                                 let kmsHost = data!["kms"] as? String
                                 let name = data!["name"] as? String
                                 let domain = data!["domain"] as? String
                                 MIO_HOST = domain!
                                 KMS_ROOT = kmsHost!
                                 URL_LIST_MEMO = MIO_HOST + "/api/v1/memo/list"
                                 URL_LOGIN = MIO_HOST + "/api/v1/user/login"
                                 URL_CATEGORY = MIO_HOST + "/api/v1/category/list"
                                 UserDefaults.standard.set("CompanyCodeSuccess", forKey: "companyCode")
                                 UserDefaults.standard.set(domain!, forKey: "domain")
                                 UserDefaults.standard.set(name!, forKey: "nameCompany")
                                 UserDefaults.standard.set(kmsHost!, forKey: "kmsCompany")

                                 let loginVC = LoginViewController()
                                 SVProgressHUD.dismiss()
                                
                                 if self.dismissLogin == true {
                                     self.navigationController?.pushViewController(loginVC, animated: true)
                                 } else {
                                   self.navigationController?.popViewController(animated: false)
                                 }
                                 
                             } else {
                                 SVProgressHUD.show(withStatus: "会社コードが不正です。")
                                 DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 2) {
                                     SVProgressHUD.dismiss()
                                 }
                             }
                         }
                     case .failure( _):
                       SVProgressHUD.show(withStatus: "会社コードが不正です。")
                       DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 2) {
                           SVProgressHUD.dismiss()
                       }
                     }
                 }
       }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        view.endEditing(true)
    }
    
}

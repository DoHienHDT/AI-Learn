//
//  LoginViewController.swift
//  Ai-Learn
//
//  Created by V.mio002 on 2/26/20.
//  Copyright © 2020 VmioSystem. All rights reserved.
//

import UIKit
import Alamofire
import SVProgressHUD

class LoginViewController: BaseViewController {
    
    @IBOutlet weak var versionLabel: UILabel!
    @IBOutlet weak var nameCompanyLabel: UILabel!
    
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var passWordTextField: UITextField!
    @IBOutlet weak var btnLoginButton: UIButton!
    
    var uuid: String = UIDevice.current.identifierForVendor!.uuidString
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.btnLoginButton.layer.masksToBounds = true
        self.btnLoginButton.layer.cornerRadius = 4.0
        self.passWordTextField.delegate = self
        
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tap)
        
        let tapLabel = UITapGestureRecognizer(target: self, action: #selector(tapLabelNameCompany))
        self.nameCompanyLabel.isUserInteractionEnabled = true
        self.nameCompanyLabel.addGestureRecognizer(tapLabel)
        self.infoVersion()
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        let name = UserDefaults.standard.string(forKey: "nameCompany")
        let userName = UserDefaults.standard.string(forKey: "yourname")  ?? ""
        let passWord = UserDefaults.standard.string(forKey: "password")  ?? ""
               
        self.nameCompanyLabel.text = name ?? ""
        
        if userName != "" && passWord != "" {
            self.nameTextField.text = userName
            self.passWordTextField.text = passWord
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.5) {
                SVProgressHUD.show()
                self.loginButtonTapped()
            }
        }
    }
    
    
    @IBAction func loginButtonTouched(_ sender: Any) {
        if InternetConnectionManager.isConnectedToNetwork() {
            SVProgressHUD.show()
            self.loginButtonTapped()
        } else {
            SVProgressHUD.show(withStatus: "認証サーバーに接続出来ません。ネットワーク環境を確認してください。")
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 2) {
                SVProgressHUD.dismiss()
            }
        }
    }
}
extension LoginViewController: UITextFieldDelegate {
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
    @objc func tapLabelNameCompany() {
        let companyVc = CompanyCodeViewController()
        companyVc.dismissLogin = false
        self.navigationController?.pushViewController(companyVc, animated: true)
    }
    
    func infoVersion() {
        if let infoDict = Bundle.main.infoDictionary,
            let appVer = infoDict["CFBundleShortVersionString"] {
            versionLabel.text = "Ver.\(appVer)"
        }
    }
    
    @objc func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            if self.view.frame.origin.y == 0 {
                self.view.frame.origin.y -= keyboardSize.height
            }
        }
    }

    @objc func keyboardWillHide(notification: NSNotification) {
        if self.view.frame.origin.y != 0 {
            self.view.frame.origin.y = 0
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
          view.endEditing(true)
      }
    
    func loginButtonTapped() {
        
        let paramLogin: Parameters = ["username": nameTextField.text ?? "", "password": passWordTextField.text ?? "", "kind": 5, "uuid" : uuid, "app_token": "6c17d2af3d615c155d90408a8d281fe0"]
        
        Alamofire.request(URL_LOGIN, method: .post, parameters: paramLogin, encoding: JSONEncoding.default).responseJSON { (response) in
            switch response.result {
            case .success( _):
                if let valueString = response.result.value as? [String: Any] {
                    if let status = valueString["status"] as? String {
                        if status == "success" {
                            SVProgressHUD.show(withStatus: status)
                            UserDefaults.standard.set(self.nameTextField.text!, forKey: "yourname")
                            UserDefaults.standard.set(self.passWordTextField.text!, forKey: "password")
                            Globals.name_client = self.nameTextField.text!
                            Globals.id_client = self.uuid
                            let arVC = ARViewController()
                            self.navigationController?.pushViewController(arVC, animated: true)
                        } else {
                            SVProgressHUD.show(withStatus: status)
                            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 2) {
                                SVProgressHUD.dismiss()
                            }
                        }
                    }
                } else {
                    SVProgressHUD.dismiss()
                }
            case .failure(let error):
             SVProgressHUD.show(withStatus: error as? String)
              DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 2) {
                  SVProgressHUD.dismiss()
              }
            }
        }
    }
}

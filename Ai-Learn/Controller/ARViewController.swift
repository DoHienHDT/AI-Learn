//
//  ARViewController.swift
//  Ai-Learn
//
//  Created by V.mio002 on 2/26/20.
//  Copyright © 2020 VmioSystem. All rights reserved.
//

import UIKit
import SVProgressHUD
import ARCL
import Alamofire
import CoreLocation
import WebKit

class ARViewController: BaseViewController {
    
    @IBOutlet weak var arView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var webView: UIView!
    @IBOutlet weak var loadSpiner: UIActivityIndicatorView!
    @IBOutlet weak var viewContent: UIView!
    @IBOutlet weak var settingButton: UIButton!
    @IBOutlet weak var checkAllCollectionView: UICollectionView!
    @IBOutlet weak var categoryCollectionView: UICollectionView!
    @IBOutlet weak var viewSetting: UIView!
    @IBOutlet weak var logOutButton: UIButton!
    @IBOutlet weak var distanceLabel: UILabel!
    
    var memo = [Memo]()
    let locationManager: CLLocationManager = CLLocationManager()
    var sceneLocationView = SceneLocationView()
    var listLocationNode = [LocationAnnotationNode]()
    var distance = 20.0
    var wkWebView : WKWebView!
    
    var listCategory = [Category]()
    var categoryAll = Category(id: 99, name: "Selected None", select: 1)
    var checkSelected = 0
    var categorys = [Int]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        SVProgressHUD.dismiss()
        
        sceneLocationView.run()
        sceneLocationView.locationNodeTouchDelegate = self
        arView.addSubview(sceneLocationView)
        self.requestDataLatLng()
        self.getCategory()
        
        self.viewContent.layer.masksToBounds = true
        self.viewContent.layer.borderColor = #colorLiteral(red: 0.9862299272, green: 1, blue: 0.8979426906, alpha: 1)
        self.viewContent.layer.borderWidth = 1.0
        self.viewContent.layer.cornerRadius = 4.0
        
        let cellNib = UINib(nibName: "CategoryCollectionViewCell", bundle: nil)
        self.checkAllCollectionView.register(cellNib, forCellWithReuseIdentifier: "CategoryCollectionViewCell")
        self.categoryCollectionView.register(cellNib, forCellWithReuseIdentifier: "CategoryCollectionViewCell")
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        sceneLocationView.frame = arView.bounds
    }
    
    @IBAction func logOutButtonTapped(_ sender: UIButton) {
        let alert = UIAlertController(title: "ログアウトしても宜しいですか？", message: nil, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "はい", style: .destructive, handler: { _ in
            
            self.navigationController?.popViewController(animated: false)
            
            UserDefaults.standard.removeObject(forKey: "yourname")
            UserDefaults.standard.removeObject(forKey: "password")
            UIApplication.shared.isIdleTimerDisabled = false
        }))
        alert.addAction(UIAlertAction(title: "いいえ", style: .cancel, handler:nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    @IBAction func closeWebViewButtonTapped(_ sender: UIButton) {
        self.removeSubview()
        self.webView.isHidden = true
        self.viewContent.isHidden = true
        self.settingButton.isHidden = false
    }
    @IBAction func settingButtonTapped(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
        if sender.isSelected == true {
            logOutButton.isHidden = true
            viewSetting.isHidden = false
        } else {
            logOutButton.isHidden = false
            viewSetting.isHidden = true
        }
    }
    
    @IBAction func sliderButtonTapped(_ sender: UISlider) {
        DispatchQueue.main.async {
            if Int(sender.value) < 1 || Int(sender.value) == 1{
                sender.value = 1
                self.distanceLabel.text = "\(1)"
                self.distance = 1.0
            }else if Int(sender.value) > 1 && Int(sender.value) < 2 || Int(sender.value) == 2{
                sender.value = 2
                self.distanceLabel.text = "\(2)"
                self.distance = 2.0
            }else if Int(sender.value) > 2 && Int(sender.value) < 3 || Int(sender.value) == 3{
                sender.value = 3
                self.distanceLabel.text = "\(3)"
                self.distance = 3.0
            }else if Int(sender.value) > 3 && Int(sender.value) < 4 || Int(sender.value) == 4{
                sender.value = 4
                self.distanceLabel.text = "\(5)"
                self.distance = 5.0
            }else if Int(sender.value) > 4 && Int(sender.value) < 5 || Int(sender.value) == 5{
                sender.value = 5
                self.distanceLabel.text = "\(10)"
                self.distance = 10
            }else if Int(sender.value) > 5 && Int(sender.value) < 6 || Int(sender.value) == 6{
                sender.value = 6
                self.distanceLabel.text = "\(20)"
                self.distance = 20
            }
        }
    }
}

extension ARViewController: UICollectionViewDataSource,UICollectionViewDelegate{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == checkAllCollectionView{
            return 1
        }else{
            return listCategory.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == checkAllCollectionView{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CategoryCollectionViewCell", for: indexPath) as! CategoryCollectionViewCell
            cell.layer.cornerRadius = 5
            cell.viewSelected.backgroundColor = .clear
            if self.checkSelected == self.listCategory.count{
                cell.nameCategory.textColor = UIColor.white
                cell.nameCategory.text = "Selected None"
            }else{
                cell.nameCategory.textColor = UIColor(red: 38.25/255, green: 173.4/255, blue: 96.6/255, alpha: 1)
                cell.nameCategory.text = "Selected All"
            }
            return cell
        }else{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CategoryCollectionViewCell", for: indexPath) as! CategoryCollectionViewCell
            let catego = listCategory[indexPath.item]
            cell.nameCategory.text = catego.name
            cell.layer.cornerRadius = 5
            if listCategory[indexPath.item].select == 1{
                cell.viewSelected.backgroundColor = UIColor(red: 38.25/255, green: 173.4/255, blue: 96.6/255, alpha: 1)
            }else{
                cell.viewSelected.backgroundColor = .clear
            }
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
         if collectionView == checkAllCollectionView{
             categoryAll.select = -categoryAll.select!
             if categoryAll.select == 1{
                 self.checkSelected = self.listCategory.count
                 for cate in listCategory{
                     cate.select = 1
                     self.categorys.append(cate.id!)
                     self.categoryCollectionView.reloadData()
                 }
                 self.checkAllCollectionView.reloadData()
             }else{
                 self.checkSelected = 0
                 for cate in listCategory{
                     cate.select = -1
                     self.categoryCollectionView.reloadData()
                 }
                 self.categorys = []
                 
                 self.checkAllCollectionView.reloadData()
             }
         }else{
             listCategory[indexPath.item].select = -listCategory[indexPath.item].select!
             if listCategory[indexPath.item].select == -1{
                 self.checkSelected = self.checkSelected - 1
                 for i in 0...self.categorys.count-1{
                     if self.categorys[i] == listCategory[indexPath.row].id {
                         categorys[i] = -1
                     }
                 }
                 categoryAll.select = -1
                 categoryCollectionView.reloadData()
                 self.checkAllCollectionView.reloadData()
             }else{
                 self.checkSelected = self.checkSelected + 1
                 self.categorys.append(listCategory[indexPath.row].id!)
                 if self.categorys.count == self.listCategory.count{
                     categoryAll.select = 1
                 }
                 self.checkAllCollectionView.reloadData()
                 categoryCollectionView.reloadData()
             }
         }
       
         SVProgressHUD.show(withStatus: "loading")
         SVProgressHUD.dismiss(withDelay: 4) {}
     }
}

extension ARViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == checkAllCollectionView{
            let width = categoryAll.name?.count ?? 5
            return CGSize.init(width: width * 10, height: 50)
        }else{
            let category = listCategory[indexPath.item]
            let width = category.name?.count ?? 5
            return CGSize.init(width: width * 20, height: 50)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, layout
        collectionViewLayout: UICollectionViewLayout,
                        minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
}

extension ARViewController: LNTouchDelegate {
    func locationNodeTouched(node: LocationNode) {}
    
    func annotationNodeTouched(node: AnnotationNode) {
        for valueMemo in memo {
            if valueMemo.id == Int(node.name!)!{
                self.viewContent.isHidden = false
                self.titleLabel.text = valueMemo.title
                
                if valueMemo.link_video != "" || valueMemo.link_pdf != "" {
                    self.viewContent.isHidden = false
                    webView.isHidden = false
                    settingButton.isHidden = true
                 
                    wkWebView = WKWebView(frame: self.webView.frame)
                    wkWebView.translatesAutoresizingMaskIntoConstraints = false
                    wkWebView.isUserInteractionEnabled = true
                    wkWebView.navigationDelegate = self
                    webView.addSubview(self.wkWebView)
                    
                    wkWebView.tag = 100
                    
                    NSLayoutConstraint.activate([
                        wkWebView.leadingAnchor.constraint(equalTo: webView.leadingAnchor, constant: 0),
                        wkWebView.trailingAnchor.constraint(equalTo: webView.trailingAnchor, constant: 0),
                        wkWebView.topAnchor.constraint(equalTo: webView.topAnchor, constant: 0),
                        wkWebView.bottomAnchor.constraint(equalTo: webView.bottomAnchor, constant: 0)
                    ])
                    
                    var stringUrl = String()
                    
                    if valueMemo.link_video != "" {
                        stringUrl = valueMemo.link_video
                    } else {
                        stringUrl = valueMemo.link_pdf
                    }
                    let url = URL(string: stringUrl.encodeUrl()!)
                    let request = URLRequest(url: url!)
                    wkWebView.load(request)
                }
            }
        }
    }
    
    func removeSubview() {
        if let viewWithTag = self.wkWebView.viewWithTag(100) {
            viewWithTag.removeFromSuperview()
        }else{
            print("No!")
        }
    }
}

extension String
{
    func encodeUrl() -> String?
    {
        return self.addingPercentEncoding( withAllowedCharacters: NSCharacterSet.urlQueryAllowed)
    }
    func decodeUrl() -> String?
    {
        return self.removingPercentEncoding
    }
}

extension ARViewController: WKNavigationDelegate {
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        loadSpiner.isHidden = false
        loadSpiner.startAnimating()
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        self.webView.alpha = 1
        loadSpiner.isHidden = true
        loadSpiner.stopAnimating()
        // hide activity indicator
    }
    func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
        // hide activity indicator
    }
}

extension ARViewController {
    
    func getCategory(){
         Alamofire.request(URL_CATEGORY).responseJSON { (response) in
             if let JSON = response.result.value as? [String: Any]{
                 guard let data = JSON["data"] as? [[String: Any]] else {return}
                 let cateOther = Category.init(id: 0, name: "その他", select: 1)
                 for item in data {
                     let id = item["id"] as? Int ?? 100
                     let name = item["name"] as? String ?? "その他"
                     let category = Category.init(id: id, name: name, select: 1)
                     self.listCategory.append(category)
                     self.categorys.append(id)
                 }
                 self.listCategory.append(cateOther)
                 self.categorys.append(0)
                 self.checkSelected = self.listCategory.count
                 DispatchQueue.main.async {
                     self.categoryCollectionView.reloadData()
                 }
             }
         }
     }
    
    
    func requestDataLatLng() {
        
        let paramLogin: Parameters = ["username": Globals.name_client]
        Alamofire.request(URL_LIST_MEMO, method: .get, parameters: paramLogin).responseJSON { response in
            switch response.result {
            case .success( _):
                if let valueString = response.result.value as? [String: Any] {
                    if let status = valueString["status"] as? String {
                        if status == "success" {
                            let data_origin = valueString["data_origin"] as? [[String: Any]]
                            
                            for valueData in data_origin! {
                                let id = valueData["id"] as? Int
                                let content = valueData["content"] as? String
                                let title = valueData["title"] as? String
                                let link_video = valueData["link_video"] as? String
                                let link_pdf = valueData["link_pdf"] as? String
                                let lat = valueData["lat"] as? String
                                let lng = valueData["lng"] as? String
                                let pin_type = valueData["pin_type"] as? String
                                
                                let appendDataMemo: Memo = Memo(id: id!, title: title ?? "", content: content ?? "", link_video: link_video ?? "", link_pdf: link_pdf ?? "", lat: lat ?? "", lng: lng ?? "", pin_type: pin_type ?? "")
                                self.memo.append(appendDataMemo)
                            }
                            self.setupLocationDevice()
                            self.updateLocationDevice()
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
    
    func setupLocationDevice() {
        if CLLocationManager.locationServicesEnabled() {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
            locationManager.startUpdatingLocation()
            Timer.scheduledTimer(timeInterval: 5, target: self, selector: #selector(self.updateLocationDevice), userInfo: nil, repeats: true)
        }
    }
    
    @objc func updateLocationDevice() {
        Timer.scheduledTimer(timeInterval: 4.75, target: self, selector: #selector(self.removeParent), userInfo: nil, repeats: false)
        
        if self.locationManager.location != nil && self.memo.count != 0 {
            for valueMemo in memo {
                let dist = getDistanceFromPointToDevice(latDevice: self.locationManager.location!.coordinate.latitude, lonDevice:
                    self.locationManager.location!.coordinate.longitude, latPoint: Double(valueMemo.lat)! , lonPoint: Double(valueMemo.lng)!)
                
                if valueMemo.pin_type != "" {
                    if dist < self.distance || dist == self.distance {
                        if dist < 1 || dist == 1 {
                            self.addPoint(lat: Double(valueMemo.lat)!, lon: Double(valueMemo.lng)!, name: valueMemo.id.description, img: valueMemo.pin_type , height: 100, width: 60)
                        } else if dist < 3 && dist > 1 || dist == 3 {
                            self.addPoint(lat: Double(valueMemo.lat)! , lon: Double(valueMemo.lng)!, name: valueMemo.id.description, img: valueMemo.pin_type, height: 100, width: 60)
                        } else if dist < 10 && dist > 3 || dist == 10 {
                            self.addPoint(lat: Double(valueMemo.lat)! , lon:Double(valueMemo.lng)!, name: valueMemo.id.description, img: valueMemo.pin_type, height: 90, width: 50)
                        }  else if dist > 10 {
                            self.addPoint(lat: Double(valueMemo.lat)! , lon:Double(valueMemo.lng)!, name: valueMemo.id.description, img: valueMemo.pin_type, height: 80, width: 40)
                        }
                    }
                }
            }
        }
    }
    
    @objc func removeParent() {
        for node in listLocationNode{
            node.annotationNode.removeFromParentNode()
            sceneLocationView.removeAllNodes()
            sceneLocationView.scene.removeAllParticleSystems()
        }
    }
    
    func getDistanceFromPointToDevice(latDevice: Double,lonDevice: Double,latPoint: Double,lonPoint: Double) -> Double {
        let R: Double = 6371.0 // kilometres
        let φ1 = latDevice * .pi / 180
        let φ2 = latPoint * .pi / 180
        let Δφ = (latPoint-latDevice) * .pi / 180
        let Δλ = (lonPoint-lonDevice) * .pi / 180
        
        let a = sin(Δφ/2) * sin(Δφ/2) +
            cos(φ1) * cos(φ2) *
            sin(Δλ/2) * sin(Δλ/2);
        let c = 2 * atan2(sqrt(a), sqrt(1-a))
        
        let d = R * c
        return d
    }
    
    func addPoint(lat: Double, lon: Double, name: String, img: String, height: CGFloat, width: CGFloat){
        let coordinate = CLLocationCoordinate2D(latitude: lat, longitude: lon)
        let location = CLLocation(coordinate: coordinate, altitude: 0)
        let imgView = UIImageView(image: UIImage.init(named: img))
        imgView.frame.size.height = height
        imgView.frame.size.width = width
        
        let annotationNode = LocationAnnotationNode(location: location, view: imgView)
        sceneLocationView.addLocationNodeWithConfirmedLocation(locationNode: annotationNode)
        
        annotationNode.annotationNode.name = name
        listLocationNode.append(annotationNode)
    }
    
}

extension ARViewController: CLLocationManagerDelegate {
    
}

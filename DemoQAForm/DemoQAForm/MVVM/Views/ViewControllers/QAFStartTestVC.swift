//
//  QAFStartTestVC.swift
//  DemoQAForm
//
//  Created by Bharat Byan on 23/08/18.
//  Copyright © 2018 Bharat Byan. All rights reserved.
//

import UIKit
import NVActivityIndicatorView
import SwiftyJSON

class QAFStartTestVC: UIViewController {
    
    var arrayModelQuestions: [QAFViewModelQuestion] = []

    // MARK:-- View's Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        NotificationCenter.default.addObserver(self, selector: #selector(reachabilityChanged(note:)), name: .reachabilityChanged, object: internetReachability)
        do{
            try internetReachability.startNotifier()
        }catch{
            print("could not start reachability notifier")
        }
        
        // Hide the navigation bar on the this view controller
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        internetReachability.stopNotifier()
        NotificationCenter.default.removeObserver(self, name: .reachabilityChanged, object: internetReachability)
        
        // Show the navigation bar on other view controllers
        self.navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "segID_QAFQuestionListVC" {
            let vc = segue.destination as! QAFQuestionListVC
            vc.arrayViewModelQuestions = arrayModelQuestions
        }
    }
    
    // MARK:-- Custom Methods
    
    func checkInternet() {
        
        //Displaying Activity Indicator
        showIndicator()
        
        //Checking internet connectivity
        switch internetReachability.connection {
        case .wifi:
            callAPI()
        case .cellular:
            callAPI()
        case .none:
            noInternet()
        }
    }
    
    // No internet sub-method
    func noInternet() {
        
        self.hideIndicator()
        self.popupAlert(title: "Info", message: "Please check your internet connection.", actionTitles: ["Ok"], actions:[{action1 in
            }, nil])
    }
    
    // Creating request
    func callAPI() {
        self.arrayModelQuestions = []
        
        QAFManagerQuestionsList.sharedInstance.delegateManager = self
        QAFManagerQuestionsList.sharedInstance.createRequest()
    }
    
    // Reachibility observer
    @objc func reachabilityChanged(note: Notification) {
        
        let reachability = note.object as! Reachability
        
        switch reachability.connection {
        case .wifi:
            print("Reachable via WiFi")
        case .cellular:
            print("Reachable via Cellular")
        case .none:
            print("Network not reachable")
        }
    }
    
     // MARK:-- Outlets
    @IBAction func actBtnLogin(_ sender: Any) {
        checkInternet()
//        convertPlist()
    }
    
    func convertPlist() {
        
        guard let documentDirectoryUrl = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else { return }
        let fileUrl = documentDirectoryUrl.appendingPathComponent("Persons.json")

        if let url = Bundle.main.url(forResource:"default", withExtension: "plist") {
            do {
                let data = try Data(contentsOf:url)
                let dict = try PropertyListSerialization.propertyList(from: data, options: [], format: nil) as! [String:Any]
                let jsonData = try JSONSerialization.data(withJSONObject: dict, options: [])
                try jsonData.write(to: fileUrl, options: [])
            } catch {
                print(error)
            }
        }
    }
}

extension QAFStartTestVC: VSManagerVogueListProtocol {
    
    // MARK:-- Network Protocol Delegation
    
    func sendData(arrayOfViewModel: Array<QAFViewModelQuestion>, error: Error?) {
        
        if error == nil {
            
            arrayModelQuestions = arrayOfViewModel
            
            DispatchQueue.main.async {
                self.hideIndicator()
                self.performSegue(withIdentifier: "segID_QAFQuestionListVC", sender: nil)
            }
        }else {
            self.hideIndicator()
            self.popupAlert(title: "Error", message: error?.localizedDescription, actionTitles: ["Ok"], actions:[{action1 in
                }, nil])
        }
    }
}

extension QAFStartTestVC: NVActivityIndicatorViewable {
    
    // MARK:-- Activity Indicator Protocol Delegation
    
    func showIndicator() {
        let size = CGSize(width: 70, height: 70)
        
        DispatchQueue.main.async {
            self.startAnimating(size, message: "Loading...", type: NVActivityIndicatorType(rawValue: 22), fadeInAnimation: nil)
        }
        
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.5) {
            NVActivityIndicatorPresenter.sharedInstance.setMessage("Fetching Form Data...")
        }
    }
    
    func hideIndicator() {
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.2) {
            self.stopAnimating(nil)
        }
    }
}


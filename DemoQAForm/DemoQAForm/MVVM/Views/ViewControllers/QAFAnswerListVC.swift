//
//  QAFAnswerListVC.swift
//  DemoQAForm
//
//  Created by Bharat Byan on 23/08/18.
//  Copyright © 2018 Bharat Byan. All rights reserved.
//

import UIKit

class QAFAnswerListVC: UIViewController {
    
    var modelQuestion: QAFViewModelQuestion?
    
    @IBOutlet weak var tblAnswerOptions: UITableView!
    @IBOutlet weak var btnDone: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        updateUI()
    }
    
    func updateUI() {
        //Adding custom header view to tableView
        let headerNib = UINib.init(nibName: "QAFAnswerHeaderView", bundle: Bundle.main)
        tblAnswerOptions.register(headerNib, forHeaderFooterViewReuseIdentifier: "QAFAnswerHeaderView")
        
        if modelQuestion?.type == 2 {
            tblAnswerOptions.allowsMultipleSelection = true
        }
    }
    
    @IBAction func actBtnDone(_ sender: Any) {
        
        updateData()
        self.navigationController?.popViewController(animated: true)
    }
    
    func updateData() {

        let indeXPaths = tblAnswerOptions.indexPathsForSelectedRows

        modelQuestion?.user_selected_answers = []

        if indeXPaths?.count != nil {

            for indeXPath in indeXPaths! {

                modelQuestion?.user_selected_answers?.append(indeXPath.row)
                modelQuestion?.isAnswered = true
            }
        }
    }
}

extension QAFAnswerListVC: UITableViewDataSource, UITableViewDelegate {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (modelQuestion?.options_answers.count)!
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tblAnswerOptions.dequeueReusableCell(withIdentifier: "cell_AnswerList", for: indexPath) as! QAFAnswersListCell
        
        cell.configureCell(withAnswer: (modelQuestion?.options_answers[indexPath.row].0)!)
        
        if (modelQuestion?.options_answers[indexPath.row].1)! {
            cell.accessoryType = UITableViewCell.AccessoryType.checkmark
            cell.isSelected = true
            cell.setSelected(true, animated: true)
            
        }else{
            cell.accessoryType = UITableViewCell.AccessoryType.none
            cell.isSelected = false
            cell.setSelected(false, animated: true)
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: "QAFAnswerHeaderView") as! QAFAnswerHeaderView
        
        
        
        if modelQuestion?.type == 1 {
            
            let strDetails = modelQuestion?.description
            let str_SubDetails = "Choose 1 correct answer from the followings:"
            let strTitle_Details = NSMutableAttributedString(string: strDetails! + "\n" + str_SubDetails)
            
            if let font1 = UIFont(name: "HelveticaNeue-Medium", size: 16), let font2 = UIFont(name: "HelveticaNeue-Light", size: 12){
                strTitle_Details.addAttribute(NSAttributedString.Key.font, value: font1, range: NSMakeRange(0, strDetails!.count))
                strTitle_Details.addAttribute(NSAttributedString.Key.font, value: font2, range: NSMakeRange(strDetails!.count, str_SubDetails.count+1))
            }
            
            headerView.lblTitle.attributedText = strTitle_Details
        }
        
        if modelQuestion?.type == 2 {
            let strDetails =  modelQuestion?.description
            let str_SubDetails = "Choose ALL correct answer/answers from the followings:"
            let strTitle_Details = NSMutableAttributedString(string: strDetails! + "\n" + str_SubDetails)
            
            if let font1 = UIFont(name: "HelveticaNeue-Medium", size: 16), let font2 = UIFont(name: "HelveticaNeue-Light", size: 12){
                strTitle_Details.addAttribute(NSAttributedString.Key.font, value: font1, range: NSMakeRange(0, strDetails!.count))
                strTitle_Details.addAttribute(NSAttributedString.Key.font, value: font2, range: NSMakeRange(strDetails!.count, str_SubDetails.count+1))
            }
            
            headerView.lblTitle.attributedText = strTitle_Details
        }
        
        return headerView
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let cell = tblAnswerOptions.cellForRow(at: indexPath)
        
        cell!.accessoryType = UITableViewCell.AccessoryType.checkmark
        cell!.isSelected = true
        
        modelQuestion?.options_answers[indexPath.row].1 = true
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        
        let cell = tblAnswerOptions.cellForRow(at: indexPath)
        
        cell!.accessoryType = UITableViewCell.AccessoryType.none
        cell!.isSelected = false
        
        modelQuestion?.options_answers[indexPath.row].1 = false        
    }
}

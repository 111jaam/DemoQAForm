//
//  QAFQuestionListVC.swift
//  DemoQAForm
//
//  Created by Bharat Byan on 23/08/18.
//  Copyright © 2018 Bharat Byan. All rights reserved.
//

import UIKit
import JsonSerializerSwift

class QAFQuestionListVC: UIViewController {
    
    var indexRow = 0
    var arrayViewModelQuestions: [QAFViewModelQuestion] = []

    @IBOutlet weak var tblQuestionList: UITableView!
    @IBOutlet weak var btnFinish: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        updateUI()
    }
    
    //Updating UI componets
    func updateUI() {
        
        let strDetails = "Finish Test"
        let str_SubDetails = "Click here to export test data as JSON"
        let strTitle_Details = NSMutableAttributedString(string: strDetails + "\n" + str_SubDetails)
        
        if let font1 = UIFont(name: "HelveticaNeue-Medium", size: 16), let font2 = UIFont(name: "HelveticaNeue-Light", size: 10){
            strTitle_Details.addAttribute(NSAttributedString.Key.font, value: font1, range: NSMakeRange(0, strDetails.count))
            strTitle_Details.addAttribute(NSAttributedString.Key.font, value: font2, range: NSMakeRange(strDetails.count, str_SubDetails.count+1))
        }
        
        self.btnFinish.setAttributedTitle(strTitle_Details, for: .normal)
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        
        if segue.identifier == "segID_QAFAnswerListVC" {
            let vc = segue.destination as! QAFAnswerListVC
            vc.modelQuestion = arrayViewModelQuestions[indexRow]
        }
    }
    
    //************************************************************************
    //This is where you can custom build the JSON (String form) from the Objects
    //************************************************************************
    @IBAction func actBtnFinishTest(_ sender: Any) {
        
        let jsonData = JSONSerializer.toJson(arrayViewModelQuestions)
        print(jsonData)
       
        let filename = getDocumentsDirectory().appendingPathComponent("output.json")
        do {
            try jsonData.write(to: filename, atomically: true, encoding: String.Encoding.utf8)
        } catch {
            // failed to write file – bad permissions, bad filename, missing permissions, or more likely it can't be converted to the encoding
        }
    }
    
    func getDocumentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
}

extension QAFQuestionListVC: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrayViewModelQuestions.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell_QuestionList") as! QAFQuestionListCell
        cell.lblQuestion.text = arrayViewModelQuestions[indexPath.row].title

        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        indexRow = indexPath.row
        
        self.performSegue(withIdentifier: "segID_QAFAnswerListVC", sender: nil)
    }
}

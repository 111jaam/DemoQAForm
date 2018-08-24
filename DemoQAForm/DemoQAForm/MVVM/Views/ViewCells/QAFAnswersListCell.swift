//
//  QAFAnswersListCell.swift
//  DemoQAForm
//
//  Created by Bharat Byan on 23/08/18.
//  Copyright © 2018 Bharat Byan. All rights reserved.
//

import UIKit

class QAFAnswersListCell: UITableViewCell {

    @IBOutlet weak var btnAnswer: UIButton!
    @IBOutlet weak var lblAnswer: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
//        self.accessoryType = selected ? .checkmark : .none
    }
    
    func configureCell(withAnswer answer: String) {
        lblAnswer.text = answer
    }
}

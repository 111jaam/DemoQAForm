//
//  QAFQuestionListCell.swift
//  DemoQAForm
//
//  Created by Bharat Byan on 23/08/18.
//  Copyright © 2018 Bharat Byan. All rights reserved.
//

import UIKit

class QAFQuestionListCell: UITableViewCell {

    @IBOutlet weak var lblQuestion: UILabel!
    @IBOutlet weak var btnQuestion: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
}

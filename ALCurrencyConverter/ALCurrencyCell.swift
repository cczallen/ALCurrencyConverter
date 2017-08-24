//
//  ALCurrencyCell.swift
//  ALCurrencyConverter
//
//  Created by ALLENMAC on 2017/8/24.
//  Copyright © 2017年 ALLENMAC. All rights reserved.
//

import UIKit

class ALCurrencyCell: UITableViewCell {
    
    // MARK: Definitions
    
    @IBOutlet weak var leftLabel: UILabel!
    @IBOutlet weak var rightLabel: UILabel!
    
    
    
    // MARK: - Life Cycle
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

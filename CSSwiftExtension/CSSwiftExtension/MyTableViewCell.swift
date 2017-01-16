//
//  MyTableViewCell.swift
//  CSSwiftExtension
//
//  Created by Chris Hu on 17/01/16.
//  Copyright © 2016年 com.icetime17. All rights reserved.
//

import UIKit

class MyTableViewCell: UITableViewCell {

    
    @IBOutlet weak var myImageView: UIImageView!
    
    @IBOutlet weak var myLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

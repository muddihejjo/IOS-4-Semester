//
//  TableViewCell.swift
//  TapAppDemo
//
//  Created by muddi hejjo on 03/05/2019.
//  Copyright © 2019 muddi hejjo. All rights reserved.
//

import UIKit



class TableViewCell: UITableViewCell {
    var url = URL(string: "")
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        self.textLabel?.highlightedTextColor = UIColor.white
        let backgroundView = UIView()
        backgroundView.backgroundColor = UIColor.init(hue: 1.41, saturation: 0.86, brightness: 0.84, alpha: 1)
        self.selectedBackgroundView = backgroundView
        self.textLabel?.textColor = UIColor.lightGray
        
    }

}

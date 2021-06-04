//
//  VideoViewCell.swift
//  AndersonGonzalez-lab4FinalVersion
//
//  Created by Anderson Gonzalez on 7/19/20.
//  Copyright © 2020 Anderson Gonzalez. All rights reserved.
//
import WebKit
import UIKit

class VideoViewCell: UITableViewCell {
    @IBOutlet weak var theVideoWeb: WKWebView!
    
    @IBOutlet weak var theDescription: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

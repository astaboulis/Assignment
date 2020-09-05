//
//  TopStoriesCell.swift
//  Assignment
//
//  Created by Angelos Staboulis on 3/9/20.
//  Copyright © 2020 Angelos Staboulis. All rights reserved.
//

import UIKit

class TopStoriesCell: UITableViewCell {
    @IBOutlet var img: UIImageView!
    @IBOutlet var title: UILabel!
    @IBOutlet var pubdate: UILabel!
    
    @IBOutlet var btnDetailsPage: UIButton!
    @IBOutlet var btnAddBookmark: UIButton!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

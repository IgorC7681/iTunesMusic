//
//  TableViewCell.swift
//  iTunesMusic
//
//  Created by TaiYi Chien on 2022/11/19.
//

import UIKit

class TableViewCell: UITableViewCell {
    
    @IBOutlet weak var coverImageView: UIImageView!
    @IBOutlet weak var artistNameLabel: UILabel!
    @IBOutlet weak var collectionNameLabel: UILabel!
    @IBOutlet weak var trackNameLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        artistNameLabel.textColor = .red
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

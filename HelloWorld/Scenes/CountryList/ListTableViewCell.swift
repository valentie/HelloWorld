//
//  ListTableViewCell.swift
//  HelloWorld
//
//  Created by creativeme on 12/2/2563 BE.
//  Copyright © 2563 creativeme. All rights reserved.
//

import UIKit

class ListTableViewCell: UITableViewCell {
    
    @IBOutlet weak var flagImage: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func setUpObject(object: CellDisplayModel) {
        nameLabel.text = object.name
        guard let svgUrl = URL(string: object.flag) else { return }
        
        let bitmapSize = CGSize(width: 60, height: 40)
        self.flagImage.sd_setImage(with: svgUrl, placeholderImage: UIImage(named: "noImage"), options: [], context: [.imageThumbnailPixelSize : bitmapSize])
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}

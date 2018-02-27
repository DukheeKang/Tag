//
//  TagCollectionViewCell.swift
//  JACom
//
//  Created by HyeounMin Kim on 2016. 12. 13..
//  Modified by Jose Kang on 2017 06.14
//  Copyright © 2016년 중앙일보. All rights reserved.
//

import UIKit

class TagCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var tagLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.layer.borderWidth = 1
        self.layer.cornerRadius = 12
        self.layer.borderColor = UIColor(rgb:0xd6d6d6).cgColor
        self.backgroundColor = UIColor(rgb:0xf5f5f5)
    }

}

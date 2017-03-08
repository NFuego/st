//
//  OpenTimeCell.swift
//  momoStore
//
//  Created by SSStand on 29/12/2016.
//  Copyright © 2016 MomoDidi. All rights reserved.
//

import UIKit
import SnapKit
import ImageLoader
import Toucan

class OpenTimeCell : UITableViewCell {
    
    let padding: CGFloat = 5
    
    var lbTime: UILabel!
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        backgroundColor = UIColor.clear
        
        //        (255,64,129)
        let textualColor = UIColor(colorLiteralRed: 1, green: 64/255.0, blue: 129/255.0, alpha: 1)
        
        lbTime = UILabel()
        lbTime.textColor = textualColor
        
        self.addSubview(lbTime)
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        //        background.frame = CGRectMake(0, padding, frame.width, frame.height - 2 * padding)
        //        typeLabel.frame = CGRectMake(padding, (frame.height - 25)/2, 40, 25)
        //        priceLabel.frame = CGRectMake(frame.width - 100, padding, 100, frame.height - 2 * padding)
        //        nameLabel.frame = CGRectMake(CGRectGetMaxX(typeLabel.frame) + 10, 0, frame.width - priceLabel.frame.width - (CGRectGetMaxX(typeLabel.frame) + 10), frame.height)
    }
}

// MARK- change funcs
extension OpenTimeCell {
    func update(time:String ){
    }
}


        
        
        

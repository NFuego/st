//
//  MemberCell.swift
//  momoStore
//
//  Copyright © 2016年 MomoDidi. All rights reserved.

import UIKit
import SnapKit
import ImageLoader
import Toucan
import Kingfisher

class MemberCell : UITableViewCell {
    
    let padding: CGFloat = 5
    
    var img:UIImageView!
    var lbName: UILabel!
    var petImg:UIImageView!
    var lbPetName:UILabel!
    let processor = RoundCornerImageProcessor(cornerRadius: 100)
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        backgroundColor = UIColor.clear

//        (255,64,129)
        let textualColor = UIColor(colorLiteralRed: 1, green: 64/255.0, blue: 129/255.0, alpha: 1)
        
        img = UIImageView()
        lbName = UILabel()
        lbName.textColor = textualColor
        petImg = UIImageView()
        lbPetName = UILabel()
        lbPetName.textColor = textualColor
        
        self.addSubview(img)
        self.addSubview(lbName)
        self.addSubview(petImg)
        self.addSubview(lbPetName)

        self.img.snp.makeConstraints({ (make) in
                
                make.height.width.equalTo(65)
                make.leading.equalTo(20)
                make.centerY.equalTo(self)
//                make.bottom.equalTo(10)
            })
            
//            self.img.layer.cornerRadius = self.img.frame.size.width / 2
//            self.img.clipsToBounds = true

          self.petImg.snp.makeConstraints({ (make) in
                
                make.height.width.equalTo(35)
//                make.centerY.equalTo(self).offset(13)
                make.bottom.equalToSuperview()
                make.centerX.equalTo(self.img.snp.right).offset(8)
//                make.bottom.equalTo(10)
            })
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

extension MemberCell {
    
    func update(name:String, imgURL :String, petName:String, petImgURL:String) {
        let userImgUrl = URL(string: MDAppURI.imgURL + imgURL)
        let petImgUrl = URL(string: MDAppURI.imgURL + petImgURL)

//        http://54.145.164.44:8888/avatars/thumb/missing.png

        img.kf.setImage(with: userImgUrl, placeholder: nil, options: [.processor(processor),.transition(.fade(0.2))])
//        self.img.kf.setImage(with: userImgUrl, options: [.transition(.fade(0.2))], progressBlock: {
//            receivedsize, totalsize in
//            let percentage = (Float(receivedsize) / Float(totalsize)) * 100.0
//            print("downloading progress: \(percentage)%")
////            myindicator.percentage = percentage
//        })
//        img.kf.setImage(with: userImgUrl, placeholder: nil, options: [.transition(.fade(0.2)),.transition(.fade(0.2))])


        img.kf.indicatorType = .activity

//        img.load.request(with: imgURL, onCompletion: {_ in
//            
//                    })imvMember

//
        petImg.kf.setImage(with: petImgUrl, placeholder:nil, options:[.processor(processor),.transition(.fade(0.2))])
//        petImg.kf.setImage(with: petImgUrl, placeholder:nil, options:[.transition(.fade(0.2)),.transition(.fade(0.2))])
        petImg.kf.indicatorType = .activity

//        self.petImg.load.request(with: petImgURL , onCompletion: {_ in
//
//            self.performSelector(onMainThread: #selector(self.layoutImgs), with: nil, waitUntilDone: false)
//        })

        lbPetName.text = petName
        lbName.text = name
        
        lbName.snp.makeConstraints { (make) in
            make.left.equalTo(img.snp.right).offset(50)
            make.centerY.equalTo(self)
        }
    }
    
    func layoutImgs(){
        
        let petIMG = Toucan(image: self.petImg.image!).maskWithRoundedRect(cornerRadius: 30).image //self.petImg.image
        self.petImg.image = petIMG
        
        
        self.img.snp.makeConstraints({ (make) in
                
                make.height.width.equalTo(65)
                make.leading.equalTo(20)
                make.centerY.equalTo(self)
//                make.bottom.equalTo(10)
            })
            
            self.img.layer.cornerRadius = self.img.frame.size.width / 2
            self.img.clipsToBounds = true
        
          self.petImg.snp.makeConstraints({ (make) in
                
                make.height.width.equalTo(35)
//                make.centerY.equalTo(self).offset(13)
                make.bottom.equalToSuperview()
                make.centerX.equalTo(self.img.snp.right).offset(8)
//                make.bottom.equalTo(10)
            })
            
//            self.petImg.layer.cornerRadius = self.petImg.frame.size.width / 2
//            self.petImg.clipsToBounds = true
//            self.petImg.layer.borderWidth = 1
//            self.petImg.layer.masksToBounds = false
//            self.petImg.layer.borderColor = UIColor.black.cgColor
//            self.petImg.layer.cornerRadius = self.petImg.frame.height/2
//            self.petImg.clipsToBounds = true
        
        self.setNeedsDisplay()
        self.setNeedsLayout()
    }
    
    
}


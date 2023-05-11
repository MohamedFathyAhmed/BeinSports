//
//  ImageViewExtension.swift
//  BeinSports
//
//  Created by mo_fathy on 06/05/2023.
//


import Foundation
import UIKit
import Kingfisher

extension UIImageView{
    
    func downloadImage(url : String? , placeHolder : UIImage?){
        let processor = DownsamplingImageProcessor(size: self.bounds.size)
        |> RoundCornerImageProcessor(cornerRadius: 20)
        self.kf.indicatorType = .activity
        let urlImg = URL(string: url ?? "")
        self.kf.setImage(
            with: urlImg ,
            placeholder: placeHolder,
            options: [
            .processor(processor) ,
            .scaleFactor(UIScreen.main.scale),
            .transition(.fade(1)) ,
            .cacheOriginalImage ,
        ]
    )
    }
    
    func roundedImage(){
        self.contentMode = .scaleAspectFit
        self.layer.borderWidth = 1.0
        self.layer.masksToBounds = false
        self.layer.borderColor = UIColor.white.cgColor
        self.layer.cornerRadius = self.frame.size.width / 2
        self.clipsToBounds = true
    }
}

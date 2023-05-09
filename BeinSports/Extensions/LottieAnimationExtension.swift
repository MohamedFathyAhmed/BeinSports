//
//  LottieAnimationExtension.swift
//  BeinSports
//
//  Created by mo_fathy on 06/05/2023.
//

import Foundation
import Lottie

extension AnimationView{
    
    func setUpMyView(name : String){
        self.animation = .named(name)
        self.contentMode = .scaleAspectFit
        self.loopMode = .loop
        self.play()
        self.animationSpeed = 1
    }
}

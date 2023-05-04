//
//  LauchScreenVC.swift
//  BeinSports
//
//  Created by mo_fathy on 02/05/2023.
//

import UIKit
import Lottie
class LauchScreenVC: UIViewController {

    @IBOutlet weak var Animationview: AnimationView!
    var timer = Timer()

    override func viewDidLoad() {

      super.viewDidLoad()
      
      // 1. Set animation content mode
      
        Animationview.contentMode = .scaleAspectFit
      
      // 2. Set animation loop mode
      
        Animationview.loopMode = .loop
      
      // 3. Adjust animation speed
      
        Animationview.animationSpeed = 0.7
      
      // 4. Play animation
        Animationview.play()
        //updateTimer is obj c not swift
       
        timer = Timer.scheduledTimer(timeInterval: 3.0, target:self, selector: #selector(updateTimer), userInfo:nil, repeats: false)
        
    }
  
    @objc func updateTimer() {
        timer.invalidate() 
        let vc = storyboard?.instantiateViewController(withIdentifier: "Home" ) as! UINavigationController
        vc.modalPresentationStyle = .fullScreen

        present (vc, animated : true )
    }

}

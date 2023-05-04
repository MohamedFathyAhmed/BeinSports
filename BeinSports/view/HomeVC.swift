//
//  ViewController.swift
//  BeinSports
//
//  Created by mo_fathy on 01/05/2023.
//

import UIKit

class HomeVC: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    var sports = ["football","basketball","cricket","tennis"]
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.register(UINib(nibName: "CustomCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "CustomCollectionViewCell")

    
        
    }


}













extension HomeVC:UICollectionViewDataSource ,UICollectionViewDelegate ,UICollectionViewDelegateFlowLayout{
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return sports.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CustomCollectionViewCell", for: indexPath) as! CustomCollectionViewCell
       cell.sportName.text=sports[indexPath.row]
       cell.sportName.textColor = .black
       cell.sportsImageView.image = UIImage(named: "football")
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (collectionView.frame.width / 2) - 10, height: (collectionView.frame.height / 2) - 10)
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
       
        let vc = storyboard?.instantiateViewController(withIdentifier: "LeaguesTableVC" ) as! LeaguesTableVC
        vc.sport = sports[indexPath.row]
        navigationController? .pushViewController(vc , animated : true )
    }
    
}



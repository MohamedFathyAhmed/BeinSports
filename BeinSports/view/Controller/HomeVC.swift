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
    
    override func viewWillAppear(_ animated: Bool) {
        collectionView.reloadData()
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
       cell.animationLotte.setUpMyView(name: sports[indexPath.row])
       return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (collectionView.frame.width / 2) - 1 , height: (collectionView.frame.height / 2) - 5 )
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
       
        let vc = storyboard?.instantiateViewController(withIdentifier: "LeaguesTableVC" ) as! LeaguesTableVC
        vc.sport = sports[indexPath.row]
        navigationController? .pushViewController(vc , animated : true )
    }
    
}



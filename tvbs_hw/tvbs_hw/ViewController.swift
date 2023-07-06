//
//  ViewController.swift
//  tvbs_hw
//
//  Created by Jimmy on 2023/7/5.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var shortVideoCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
//        shortVideoCollectionView.register(ShortVideoCell.self, forCellWithReuseIdentifier: "ShortVideoCell")
        shortVideoCollectionView.register(UINib(nibName: "ShortVideoCell", bundle: nil), forCellWithReuseIdentifier: "ShortVideoCell")

    }

    @IBAction func onClickTest(_ sender: Any) {
        shortVideoCollectionView.reloadData()
    }
    
}

extension ViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ShortVideoCell", for: indexPath) as! ShortVideoCell
        
        cell.titleLabel.text = "\(indexPath.row)"

        return cell
    }
    
    
}

extension ViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        print("### layout")
        return CGSize(width: shortVideoCollectionView.frame.size.width, height: shortVideoCollectionView.frame.size.height)
//        return CGSize(width: (shortVideoCollectionView.frame.size.width ,height: shortVideoCollectionView.frame.size.height))
    }
}

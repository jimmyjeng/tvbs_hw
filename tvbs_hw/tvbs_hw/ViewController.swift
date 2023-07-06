//
//  ViewController.swift
//  tvbs_hw
//
//  Created by Jimmy on 2023/7/5.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var shortVideoCollectionView: UICollectionView!
    
    var isStart = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        shortVideoCollectionView.register(UINib(nibName: "ShortVideoCell", bundle: nil), forCellWithReuseIdentifier: "ShortVideoCell")
        
    }
    
    func playVideo(cell:UICollectionViewCell, row:Int) {
        guard let cell = cell as? ShortVideoCell else {
            return
        }
        let fileNmae = String(format: "%02d", row)
        let videoPath = Bundle.main.path(forResource: fileNmae, ofType: "mp4")!
        let videoURL = URL(fileURLWithPath: videoPath)
        let player = AVPlayer(url: videoURL)
        let playerLayer = AVPlayerLayer(player: player)
        
        playerLayer.frame = cell.bounds
        playerLayer.name = "Video"
        cell.videoView.layer.addSublayer(playerLayer)
        player.play()
    }
    
    func removeVideo(cell:UICollectionViewCell,row:Int) {
        guard let cell = cell as? ShortVideoCell, let layers = cell.videoView.layer.sublayers else {
            return
        }
        for layer in layers {
            if layer.name == "Video" {
                layer.removeFromSuperlayer()
            }
        }
    }
    
    @IBAction func onClickTest(_ sender: Any) {
        isStart = true
        shortVideoCollectionView.reloadData()
    }
    
}

extension ViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return isStart ? 5 : 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ShortVideoCell", for: indexPath) as! ShortVideoCell
        
        cell.titleLabel.text = "\(indexPath.row)"
        
        return cell
    }
}

extension ViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        playVideo(cell: cell, row: indexPath.row)
    }
    
    func collectionView(_ collectionView: UICollectionView, didEndDisplaying cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        removeVideo(cell: cell, row: indexPath.row)
    }
}

extension ViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: shortVideoCollectionView.frame.size.width, height: shortVideoCollectionView.frame.size.height)
    }
    
}

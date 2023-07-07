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
    
    let viewModel: ViewModel = ViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        shortVideoCollectionView.register(UINib(nibName: "ShortVideoCell", bundle: nil), forCellWithReuseIdentifier: "ShortVideoCell")
        viewModel.loadingDelegate = self
        viewModel.loadData()
    }
    
    
    func playVideo(cell:UICollectionViewCell, row:Int) {
        
        guard let cell = cell as? ShortVideoCell else {
            return
        }
        
//        if let url = URL(string: "https://audio-ssl.itunes.apple.com/apple-assets-us-std-000001/AudioPreview118/v4/69/0e/98/690e98db-440d-cb0c-2bff-91b00a05bdda/mzaf_1674062311671795807.plus.aac.p.m4a") {
//           let player = AVQueuePlayer()
//           let item = AVPlayerItem(url: url)
//           looper = AVPlayerLooper(player: player, templateItem: item)
//           player.play()
//        }
        
        if let data = viewModel.getData(index: row) {
            let videoPath = Bundle.main.path(forResource: data.url, ofType: "")!
            let videoURL = URL(fileURLWithPath: videoPath)
            let player = AVPlayer(url: videoURL)
            let playerLayer = AVPlayerLayer(player: player)
            
            playerLayer.frame = cell.bounds
            playerLayer.name = "Video"
            cell.videoView.layer.addSublayer(playerLayer)
            player.play()
            // TODO: prepeat video
            
        }
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
        if let data = viewModel.getData(index: 0) {
            print(data)
        }
    }
    
}

extension ViewController: LoadingDelegate {
    func loadingDone() {
        shortVideoCollectionView.reloadData()
    }
    
    func loadingFail(code: Int, message: String) {
        // TODO: show alert

    }
}

extension ViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.numberOfItemsInSection(section: section)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ShortVideoCell", for: indexPath) as! ShortVideoCell
        
        if let data = viewModel.getData(index: indexPath.row) {
            cell.setup(model: data)
        } else {
            cell.reset()
        }
        
        cell.likeAction = { [weak self] in
            guard let self = self else { return }
            viewModel.changeLike(index: indexPath.row)
        }
        
        cell.dislikeAction = { [weak self] in
            guard let self = self else { return }

            viewModel.changeDislike(index: indexPath.row)

        }
        
        return cell
    }
}

extension ViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        playVideo(cell: cell, row: indexPath.row)
        
        if (viewModel.isLastData(index: indexPath.row)) {
            viewModel.loadData()
        }
        
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

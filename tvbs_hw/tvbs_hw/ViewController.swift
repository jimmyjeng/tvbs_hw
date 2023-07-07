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
        // Test Button
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
        
        cell.reset()

        if let data = viewModel.getData(index: indexPath.row) {
            cell.setup(model: data)
        }
        
        cell.likeAction = { [weak self] in
            guard let self = self else { return }
            viewModel.changeLike(index: indexPath.row)
            cell.updateUI()
        }
        
        cell.dislikeAction = { [weak self] in
            guard let self = self else { return }
            viewModel.changeDislike(index: indexPath.row)
            cell.updateUI()
        }
        
        return cell
    }
}

extension ViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        guard let cell = cell as? ShortVideoCell else {
            return
        }
        
        cell.playVideo()
        
        if (viewModel.isLastData(index: indexPath.row)) {
            viewModel.loadData()
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didEndDisplaying cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        removeVideo(cell: cell, row: indexPath.row)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = shortVideoCollectionView.cellForItem(at: indexPath)

        guard let cell = cell as? ShortVideoCell else {
            return
        }
        
        cell.playorPause()
    }
}

extension ViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: shortVideoCollectionView.frame.size.width, height: shortVideoCollectionView.frame.size.height)
    }
    
}

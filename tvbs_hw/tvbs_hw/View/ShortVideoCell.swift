//
//  ShortVideoCell.swift
//  tvbs_hw
//
//  Created by Jimmy on 2023/7/6.
//

import UIKit

class ShortVideoCell: UICollectionViewCell {
    
    @IBOutlet weak var likeButton: UIButton!
    @IBOutlet weak var likeCountLabel: UILabel!
    @IBOutlet weak var disLikeButton: UIButton!
    @IBOutlet weak var videoView: UIView!
    
    var data: VideoModel!
    var likeAction : (() -> Void)? = nil
    var dislikeAction : (() -> Void)? = nil

    func reset() {
        likeButton.isSelected = false
        disLikeButton.isSelected = false
        likeCountLabel.text = ""
    }
    
    func setup(model: VideoModel) {
        data = model
        updateUI()
    }
    
    func updateUI() {
        likeButton.isSelected = data.isLike
        disLikeButton.isSelected = data.isDislike
        likeCountLabel.text = String(data.likeCount)
    }
    
    @IBAction func onClickLike(_ sender: Any) {
        if let action = likeAction
        {
            // local change first, then send api
            if (data.isLike) {
                data.isLike = false
                data.likeCount -= 1
                updateUI()
            } else {
                data.isLike = true
                data.likeCount += 1
                updateUI()
            }

            action()
        }
    }
    
    @IBAction func onClickDisLike(_ sender: Any) {
        if let action = dislikeAction
        {
            // local change first, then send api
            if (data.isDislike) {
                data.isDislike = false
                updateUI()
            } else {
                data.isDislike = true
                updateUI()
            }
            action()
        }
    }
    
}

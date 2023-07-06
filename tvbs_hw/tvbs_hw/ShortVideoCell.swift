//
//  ShortVideoCell.swift
//  tvbs_hw
//
//  Created by Jimmy on 2023/7/6.
//

import UIKit

class ShortVideoCell: UICollectionViewCell {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var likeButton: UIButton!
    @IBOutlet weak var disLikeButton: UIButton!
    
    @IBOutlet weak var videoView: UIView!
    
    @IBAction func onClickLike(_ sender: Any) {
        likeButton.isSelected = !likeButton.isSelected
    }
    
    @IBAction func onClickDisLike(_ sender: Any) {
        disLikeButton.isSelected = !disLikeButton.isSelected

    }
    
}

//
//  ShortVideoCell.swift
//  tvbs_hw
//
//  Created by Jimmy on 2023/7/6.
//

import UIKit
import AVFoundation

class ShortVideoCell: UICollectionViewCell {
    
    @IBOutlet weak var likeButton: UIButton!
    @IBOutlet weak var likeCountLabel: UILabel!
    @IBOutlet weak var disLikeButton: UIButton!
    @IBOutlet weak var videoView: UIView!
    @IBOutlet weak var playPauseImageView: UIImageView!
    
    var data: VideoModel!
    var player = AVQueuePlayer()
    var looper: AVPlayerLooper?

    var autoHideTimer: Timer!

    var likeAction : (() -> Void)? = nil
    var dislikeAction : (() -> Void)? = nil

    func reset() {
        if autoHideTimer != nil, autoHideTimer.isValid {
            autoHideTimer.invalidate()
            autoHideTimer = nil
        }

        likeButton.isSelected = false
        disLikeButton.isSelected = false
        likeCountLabel.text = ""
        playPauseImageView.isHidden = true
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
    
    func playVideo() {
        playPauseImageView.isHidden = true

        let videoPath = Bundle.main.path(forResource: data.url, ofType: "")!
        let videoURL = URL(fileURLWithPath: videoPath)
        
        let item = AVPlayerItem(url: videoURL)
        player = AVQueuePlayer()
        let playerLayer = AVPlayerLayer(player: player)
        looper = AVPlayerLooper(player: player, templateItem: item)
        
        playerLayer.frame = bounds
        playerLayer.name = "Video"
        videoView.layer.addSublayer(playerLayer)
        player.play()
    
    }
    
    func playorPause() {
        if player.timeControlStatus == .paused {
            playPauseImageView.image = UIImage(named: "play")
            playPauseImageView.isHidden = false
            player.play()
        }else {
            playPauseImageView.image = UIImage(named: "pause")
            playPauseImageView.isHidden = false
            player.pause()
        }
        
        if autoHideTimer != nil, autoHideTimer.isValid {
            autoHideTimer.invalidate()
            autoHideTimer = nil
        }
        
        autoHideTimer = Timer.scheduledTimer(timeInterval: 2, target: self, selector: #selector(hidePlayPauseImage), userInfo: nil, repeats: false)
    }
    
    @objc func hidePlayPauseImage() {
        self.playPauseImageView.isHidden = true
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

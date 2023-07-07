//
//  ViewModel.swift
//  tvbs_hw
//
//  Created by Jimmy on 2023/7/7.
//

import Foundation

protocol LoadingDelegate {
    func loadingDone()
    func loadingFail(code: Int, message: String)
}

class ViewModel {
    var loadingDelegate: LoadingDelegate?
    private var videoDatas: [VideoModel] = []
    
    func loadData() {
        if let datas = DataManager.shared.loadVideoDatas() {
            for data in datas {
                videoDatas.append(data)
            }
            loadingDelegate?.loadingDone()
        } else {
            loadingDelegate?.loadingFail(code: 404, message: "loading fail")
        }
    }
    
    func getData(index: Int) -> VideoModel? {
        
        if index <= videoDatas.count {
            return videoDatas[index]
        } else {
            return nil
        }
    }
    
    func changeLike (index: Int) {
        if index <= videoDatas.count {
            var data = videoDatas[index]
            if (data.isLike) {
                data.isLike = false
                data.likeCount -= 1
            } else {
                data.isLike = true
                data.likeCount += 1
            }
            // TODO: send api
        }
    }
    
    func changeDislike (index: Int) {
        if index <= videoDatas.count {
            var data = videoDatas[index]
            if (data.isDislike) {
                data.isLike = false
            } else {
                data.isDislike = true
            }
            // TODO: send api
        }
    }

    func isLastData(index: Int) -> Bool {
        return index + 1 == videoDatas.count
    }
    
    func numberOfItemsInSection(section: Int) -> Int {
        return videoDatas.count
    }
}

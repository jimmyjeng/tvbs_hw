//
//  VideoModel.swift
//  tvbs_hw
//
//  Created by Jimmy on 2023/7/6.
//

import Foundation

class ResponseData: Decodable {
    var datas: [VideoModel]
}

class VideoModel: Codable {
    var url: String
    var likeCount: Int
    var isLike: Bool
    var isDislike: Bool
}

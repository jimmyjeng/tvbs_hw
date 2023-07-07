//
//  DataManager.swift
//  tvbs_hw
//
//  Created by Jimmy on 2023/7/7.
//

import Foundation

class DataManager {
    static let shared = DataManager()

    func loadVideoDatas() -> [VideoModel]? {
        if let url = Bundle.main.url(forResource: "Data", withExtension: "json") {
            do {
                let data = try Data(contentsOf: url)
                let decoder = JSONDecoder()
                let jsonData = try decoder.decode(ResponseData.self, from: data)
                return jsonData.datas
            } catch {
                print("error:\(error)")
            }
        }
        return nil
    }

}

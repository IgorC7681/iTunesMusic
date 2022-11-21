//
//  Data.swift
//  iTunesMusic
//
//  Created by TaiYi Chien on 2022/11/18.
//

import Foundation



struct Data: Codable {
    let resultCount: Int
    let results: [Item]
}

struct Item: Codable {
    //藝術家姓名
    let artistName: String
    //集合名稱
    let collectionName: String?
    //音軌名稱
    let trackName: String
    //軌跡視圖 網址
    let trackViewUrl: URL
    //預覽網址
    let previewUrl: URL
    //專輯圖片(30.60.100分別為大小)
    let artworkUrl100: URL
    
    enum CodingKeys: String, CodingKey {
        case artistName
        case collectionName
        case trackName
        case trackViewUrl
        case previewUrl
        case artworkUrl100
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.artistName = try container.decode(String.self, forKey: .artistName)
        self.collectionName = try container.decode(String.self, forKey: .collectionName)
        self.trackName = try container.decode(String.self, forKey: .trackName)
        self.trackViewUrl = try container.decode(URL.self, forKey: .trackViewUrl)
        self.previewUrl = try container.decode(URL.self, forKey: .previewUrl)
        self.artworkUrl100 = try container.decode(URL.self, forKey: .artworkUrl100)
    }
}

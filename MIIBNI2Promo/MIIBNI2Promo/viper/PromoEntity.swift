//
//  PromoEntity.swift
//  MIIBNI2Promo
//
//  Created by Vincentius Ian Widi Nugroho on 22/11/23.
//

import Foundation

struct PromoEntity {
    var title = ""
    var nama = ""
    var publishedAt = ""
    var desc = ""
    
    init(json: [String : Any]) {
        if let title = json["Title"] as? String, let nama = json["nama"] as? String, let publishedAt = json["published_at"] as? String, let desc = json["desc"] as? String{
            self.title = (title == "<null>") ? "no title" : title
            self.nama = nama
            self.publishedAt = publishedAt
            self.desc = desc
        }
    }
}

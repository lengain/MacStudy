//
//  SCListItem.swift
//  MacStudy
//
//  Created by 童玉龙 on 2023/2/28.
//

import Foundation

struct SCListItemData : Decodable, Encodable {
    
    var title : String
    var description : String?
    var filePath : String
    var className : String
    var index : Int = 0
    
    func markdownCode() -> String? {
        guard let fileURL = Bundle.main.url(forResource: "\(title)", withExtension: "md") else { return nil }
        do {
            return try String(contentsOf: fileURL)
        } catch {
            fatalError("Coundn't open \(fileURL)")
        }
    }
    
}

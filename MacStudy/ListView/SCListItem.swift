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
    
    func markdownCode() -> String? {
        guard let fileURL = Bundle.main.url(forResource: "\(title)", withExtension: "md") else { return nil }
        do {
//            let markdownData = try Data(contentsOf: fileURL)
            return try String(contentsOf: fileURL)
        } catch {
            fatalError("Coundn't open \(fileURL)")
        }
    }
    
}

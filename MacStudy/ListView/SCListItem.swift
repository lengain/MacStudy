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
    var fileType : String
    
    func markdownCode() -> String? {
        guard let fileURL = Bundle.main.url(forResource: "\(title)", withExtension: "md") else { return nil }
        do {
            var md = try String(contentsOf: fileURL)
            if #available(macOS 13.0, *) {
                md = md.replacing(/(<!--[\s\S]*-->)/, with: "")
            } else {
                // Fallback on earlier versions
            }
            return md
        } catch {
            fatalError("Coundn't open \(fileURL)")
        }
    }
    
}

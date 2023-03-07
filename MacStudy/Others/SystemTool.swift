//
//  SystemTool.swift
//  MacStudy
//
//  Created by 童玉龙 on 2023/3/1.
//

import Foundation

func loadBundleJsonFile<T:Decodable>(_ url:URL) -> T {
    let data : Data
    do {
        data = try Data(contentsOf: url)
    } catch {
        fatalError(error.localizedDescription)
    }
    do {
        let decoder = JSONDecoder()
        return try decoder.decode(T.self, from: data)
    } catch {
        fatalError("Coundn't decode \(url) as \(T.self) :\(error)")
    }
}


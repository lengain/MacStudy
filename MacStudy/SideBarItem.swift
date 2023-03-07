//
//  SLKitEnum.swift
//  MacStudy
//
//  Created by 童玉龙 on 2023/2/21.
//

import Foundation
import Cocoa
struct SideBarSection {
    let title : String
    let items : [SideBarItem.SideBarItemType]
}

enum SideBarItem {
    case header(section:SideBarSection)
    case item(SideBarItemType)
    
    enum SideBarItemType: String {
        
        case appKit
        case foundation
        case mapKit
        
        
        case siteMap
    }
    
}

extension SideBarItem {
    var description : String {
        switch self {
        case .header(let section) : return section.title
        case .item(let type):
            switch type {
            case .appKit : return "AppKit"
            case .foundation : return "Foundation"
            case .mapKit : return "MapKit"
            case .siteMap : return "Site Map"
            }
            
        }
    }
    
    var icon : NSImage? {
        switch self {
        case .header : return nil
        case .item(let type):
            switch type {
            case .appKit : return NSImage(systemSymbolName: "hand.tap", accessibilityDescription: nil)
            case .foundation : return NSImage(systemSymbolName: "book.closed", accessibilityDescription: nil)
            case .mapKit : return NSImage(systemSymbolName: "map", accessibilityDescription: nil)
            case .siteMap : return NSImage(systemSymbolName: "network", accessibilityDescription: nil)
            }
            
        }
    }
}



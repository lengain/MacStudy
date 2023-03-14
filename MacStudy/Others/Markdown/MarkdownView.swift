//
//  MarkdownView.swift
//  MacStudy
//
//  Created by 童玉龙 on 2023/3/3.
//

import SwiftUI
import MarkdownUI
import Splash

struct MarkdownView: View {
    @Environment(\.colorScheme) private var colorScheme
    let text : String
    var body: some View {
        MarkdownBaseView {
            Markdown(text)
                .markdownCodeSyntaxHighlighter(.splash(theme:self.theme))
                .markdownImageProvider(DefaultImageProvider(urlSession: URLSessionManager.shared.session))
        }
    }
    
    private var theme: Splash.Theme {
        // NOTE: We are ignoring the Splash theme font
        switch self.colorScheme {
        case .dark:
            return .wwdc17(withFont: .init(size: 16))
        default:
            return .sunset(withFont: .init(size: 16))
        }
    }
}

struct MarkdownView_Previews: PreviewProvider {
    static var previews: some View {
        MarkdownView(text: "你好")
    }
}

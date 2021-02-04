//
//  SamplePrintSetup.swift
//  SwiftUIPrint
//
//  Created by Wolf McNally on 2/3/21.
//

import SwiftUI

public func presentPrintInteractionController<Page>(page: Page) where Page: View {
    let printController = UIPrintInteractionController()
    printController.printPageRenderer = PageRenderer(page: page)
    printController.present(animated: true, completionHandler: nil)
}

public struct SamplePrintSetup<Page>: View where Page: View {
    public let page: Page
    
    public var body: some View {
        VStack {
            Button {
                presentPrintInteractionController(page: page)
            } label: {
                Label("Print", systemImage: "printer")
                    .padding()
                    .overlay(
                        RoundedRectangle(cornerRadius: 10.0)
                            .stroke(lineWidth: 2.0)
                    )
            }
            PagePreview(page: page, pageSize: .constant(CGSize(width: 8.5 * 72, height: 11 * 72)))
        }
        .padding()
    }
}

#if DEBUG

struct PrintSetup_Previews: PreviewProvider {
    static var previews: some View {
        SamplePrintSetup(page: SamplePageView())
            .preferredColorScheme(.dark)
    }
}

#endif

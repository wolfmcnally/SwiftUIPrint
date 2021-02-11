//
//  SamplePrintSetup.swift
//  SwiftUIPrint
//
//  Created by Wolf McNally on 2/3/21.
//

import SwiftUI

public struct SamplePrintSetup<Page>: View where Page: View {
    public let page: Page
    @State private var isFitToPrintable: Bool = false

    public init(page: Page) {
        self.page = page
    }

    public var body: some View {
        let margins = Binding<CGFloat>(
            get: { isFitToPrintable ? 0.25 * 72 : 0 },
            set: { _ in }
        )
        return VStack(spacing: 20) {
            Toggle("Fit to Printable", isOn: $isFitToPrintable)
            Button {
                presentPrintInteractionController(page: page, fitting: isFitToPrintable ? .fitToPrintableRect : .fitToPaper)
            } label: {
                Label("Print", systemImage: "printer")
                    .padding()
                    .overlay(
                        RoundedRectangle(cornerRadius: 10.0)
                            .stroke(lineWidth: 2.0)
                    )
            }
            PagePreview(page: page, pageSize: .constant(CGSize(width: 8.5 * 72 - margins.wrappedValue * 2, height: 11 * 72 - margins.wrappedValue * 2)), marginsWidth: margins)
            
            Spacer()
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

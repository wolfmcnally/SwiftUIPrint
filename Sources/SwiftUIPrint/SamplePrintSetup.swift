//
//  SamplePrintSetup.swift
//  SwiftUIPrint
//
//  Created by Wolf McNally on 2/3/21.
//

import SwiftUI

public struct SamplePrintSetup<Page>: View where Page: View {
    public let jobName: String?
    public let pages: [Page]
    @State private var pageIndex = 0
    @State private var isFitToPrintable = false

    public init(jobName: String? = nil, pages: [Page]) {
        self.jobName = jobName
        self.pages = pages
    }
    
    public init(jobName: String? = nil, page: Page) {
        self.init(jobName: jobName, pages: [page])
    }

    public var body: some View {
        let margins = Binding<CGFloat>(
            get: { isFitToPrintable ? 0.25 * 72 : 0 },
            set: { _ in }
        )
        return VStack(spacing: 20) {
            Toggle("Fit to Printable", isOn: $isFitToPrintable)
            Button {
                presentPrintInteractionController(pages: pages, fitting: isFitToPrintable ? .fitToPrintableRect : .fitToPaper)
            } label: {
                Label("Print", systemImage: "printer")
                    .padding()
                    .overlay(
                        RoundedRectangle(cornerRadius: 10.0)
                            .stroke(lineWidth: 2.0)
                    )
            }
            PagePreview(page: pages[pageIndex], pageSize: CGSize(width: 8.5 * 72, height: 11 * 72), marginsWidth: margins)
            
            HStack {
                Button {
                    pageIndex -= 1
                } label: {
                    Image(systemName: "arrowtriangle.left.fill")
                }
                .disabled(pageIndex == 0)
                Text("\(pageIndex + 1) of \(pages.count)")
                Button {
                    pageIndex += 1
                } label: {
                    Image(systemName: "arrowtriangle.right.fill")
                }
                .disabled(pageIndex == pages.count - 1)
            }
            .font(.title)
            
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

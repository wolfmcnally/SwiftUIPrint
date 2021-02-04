import SwiftUI
import UIKit
import Dispatch

public class PageRenderer<Page>: UIPrintPageRenderer where Page: View {
    public let page: Page
    
    public init(page: Page) {
        self.page = page
        super.init()
    }
    
    override open var numberOfPages: Int { 1 }
    
    override open func drawPage(at pageIndex: Int, in printableRect: CGRect) {
        let pdfData = DispatchQueue.main.sync {
            page
                .environment(\.colorScheme, .light)
                .frame(width: printableRect.width, height: printableRect.height)
                .pdfData(size: printableRect.size)
        }
        let context = UIGraphicsGetCurrentContext()!
        context.translateBy(x: 0, y: printableRect.height)
        context.scaleBy(x: 1, y: -1)

        let dataProvider = CGDataProvider(data: pdfData as CFData)!
        let pdfDoc = CGPDFDocument(dataProvider)!
        let pdfPage = pdfDoc.page(at: 1)!

        context.translateBy(x: printableRect.minX, y: printableRect.minY)
        context.drawPDFPage(pdfPage)
    }
}

import SwiftUI
import UIKit
import Dispatch

public class PageRenderer<Page>: UIPrintPageRenderer where Page: View {
    public let page: Page
    public let fitting: PageFitting
    
    public init(page: Page, fitting: PageFitting) {
        self.page = page
        self.fitting = fitting
        super.init()
    }
    
    override open var numberOfPages: Int { 1 }
    
    override open func drawPage(at pageIndex: Int, in printableRect: CGRect) {
        let context = UIGraphicsGetCurrentContext()!
        DispatchQueue.main.sync {
            let frame: CGRect
            switch fitting {
            case .fitToPrintableRect:
                frame = printableRect
            case .fitToPaper:
                frame = paperRect
            }
            
            let pdfData = page
                .environment(\.colorScheme, .light)
                .frame(width: frame.width, height: frame.height)
                .pdfData(size: frame.size)

            context.translateBy(x: 0, y: printableRect.height)
            context.scaleBy(x: 1, y: -1)

            let dataProvider = CGDataProvider(data: pdfData as CFData)!
            let pdfDoc = CGPDFDocument(dataProvider)!
            let pdfPage = pdfDoc.page(at: 1)!

            context.translateBy(x: frame.minX, y: frame.minY)
            context.drawPDFPage(pdfPage)
        }
    }
}

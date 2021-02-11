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
            let yOffset: CGFloat
            switch fitting {
            case .fitToPrintableRect:
                frame = printableRect
                yOffset = 0
            case .fitToPaper:
                frame = paperRect
                yOffset = printableRect.minY
            }

            context.saveGState()
            defer { context.restoreGState() }

            let pdfData = page
                .environment(\.colorScheme, .light)
                .frame(width: frame.width, height: frame.height)
                .pdfData(size: frame.size)

            context.translateBy(x: 0, y: frame.height)
            context.scaleBy(x: 1, y: -1)

            let dataProvider = CGDataProvider(data: pdfData as CFData)!
            let pdfDoc = CGPDFDocument(dataProvider)!
            let pdfPage = pdfDoc.page(at: 1)!

            context.translateBy(x: frame.minX, y: yOffset)
            context.drawPDFPage(pdfPage)
        }

        //drawCrossedBox(in: context, frame: paperRect, color: .blue)
        //drawCrossedBox(in: context, frame: printableRect, color: .red)
    }
}

#if DEBUG

func drawCrossedBox(in context: CGContext, frame r: CGRect, color: UIColor) {
    context.saveGState()
    defer { context.restoreGState() }
    
    context.move(to: CGPoint(x: r.minX, y: r.minY))
    context.addLine(to: CGPoint(x: r.maxX, y: r.minY))
    context.addLine(to: CGPoint(x: r.maxX, y: r.maxY))
    context.addLine(to: CGPoint(x: r.minX, y: r.maxY))
    context.closePath()
    
    context.move(to: CGPoint(x: r.minX, y: r.minY))
    context.addLine(to: CGPoint(x: r.maxX, y: r.maxY))
    context.closePath()
    
    context.move(to: CGPoint(x: r.maxX, y: r.minY))
    context.addLine(to: CGPoint(x: r.minX, y: r.maxY))
    context.closePath()
    
    context.setStrokeColor(color.cgColor)
    context.strokePath()
}

#endif

import SwiftUI
import UIKit
import Dispatch
import PDFKit

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
        context.translateBy(x: 0, y: paperRect.height)
        context.scaleBy(x: 1, y: -1)

        // print("paperRect: \(paperRect), printableRect: \(printableRect)")
        
        let frame: CGRect
        switch fitting {
        case .fitToPrintableRect:
            frame = printableRect
        case .fitToPaper:
            frame = paperRect
        }
        
//        let image = DispatchQueue.main.sync {
//            page
//                .environment(\.colorScheme, .light)
//                .frame(width: frame.width, height: frame.height)
//                .image(in: CGRect(origin: CGPoint(x: 0, y: 20), size: frame.size))
//        }
//        context.draw(image.cgImage!, in: frame)
        
        let pdfPage = DispatchQueue.main.sync {
            page
                .environment(\.colorScheme, .light)
                .frame(width: frame.width, height: frame.height)
                .pdfPage(in: CGRect(origin: CGPoint(x: 0, y: 20), size: frame.size))
        }
        context.translateBy(x: frame.minX, y: frame.minY)
        context.drawPDFPage(pdfPage)

//         drawCrossedBox(in: context, frame: paperRect, color: .blue)
//         drawCrossedBox(in: context, frame: printableRect, color: .red)
    }
}

#if DEBUG

func drawCrossedBox(in context: CGContext, frame r: CGRect, color: UIColor, lineWidth: CGFloat = 1) {
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
    context.setLineWidth(lineWidth)
    context.strokePath()
}

#endif

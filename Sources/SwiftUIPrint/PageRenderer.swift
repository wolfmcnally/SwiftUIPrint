import SwiftUI
import UIKit
import Dispatch
import PDFKit

public class PageRenderer<Page>: UIPrintPageRenderer where Page: View {
    public let pages: [Page]
    public let fitting: PageFitting
    
    public init(pages: [Page], fitting: PageFitting) {
        self.pages = pages
        self.fitting = fitting
        super.init()
    }
    
    public convenience init(page: Page, fitting: PageFitting) {
        self.init(pages: [page], fitting: fitting)
    }
    
    override open var numberOfPages: Int { pages.count }
    
    override open func drawPage(at pageIndex: Int, in printableRect: CGRect) {
        let context = UIGraphicsGetCurrentContext()!
        
        context.setFillColor(UIColor.white.cgColor)
        context.fill(paperRect)
        
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
        
        let image = pages[pageIndex]
            .background(.white)
            .environment(\.colorScheme, .light)
            .frame(width: frame.width, height: frame.height)
            .image(size: frame.size)
        context.draw(image.cgImage!, in: frame)
        
//        drawCrossedBox(in: context, frame: paperRect, color: .red)
//        drawCrossedBox(in: context, frame: printableRect, color: .green)
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

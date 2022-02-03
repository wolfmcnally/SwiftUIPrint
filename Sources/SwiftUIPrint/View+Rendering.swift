import SwiftUI

public extension View {
    // Must be called on the main thread.
    func uiView(size: CGSize) -> UIView {
        let frame = CGRect(origin: CGPoint(x: 50, y: 50), size: size)
        let window = UIWindow(frame: frame)
        let hosting = UIHostingController(rootView: self)
        hosting.view.frame = window.frame
        hosting.view.backgroundColor = .white
        window.addSubview(hosting.view)
        window.makeKeyAndVisible()
        return hosting.view
    }
    
    func image(size: CGSize) -> UIImage {
        self
            .uiView(size: size)
            .image
    }
    
//    func pdfPage(size: CGSize) -> CGPDFPage {
//        self
//            .uiView(size: size)
//            .pdfPage
//    }
}

public extension UIView {
    var image: UIImage {
        UIGraphicsBeginImageContextWithOptions(bounds.size, true, 2)
        defer { UIGraphicsEndImageContext() }
        let context = UIGraphicsGetCurrentContext()!
        layer.render(in: context)
        return UIGraphicsGetImageFromCurrentImageContext()!
    }
    
//    var pdfPage: CGPDFPage {
//        let pdfRenderer = UIGraphicsPDFRenderer(bounds: bounds)
//
//        let pdfData = pdfRenderer.pdfData { rendererContext in
//            rendererContext.beginPage()
//            let cgContext = rendererContext.cgContext
//            layer.render(in: cgContext)
//        }
//        let dataProvider = CGDataProvider(data: pdfData as CFData)!
//        let pdfDoc = CGPDFDocument(dataProvider)!
//        return pdfDoc.page(at: 1)!
//    }
}

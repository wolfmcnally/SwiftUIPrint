import SwiftUI

public extension View {
    // Must be called on the main thread.
    func pdfData(size: CGSize) -> Data {
        let bounds = CGRect(origin: .zero, size: size)
        let hostingController = UIHostingController(rootView: self)
        let hostedView = hostingController.view!
        hostedView.backgroundColor = .clear
        hostedView.frame = bounds
        let rootVC = UIApplication.shared.windows.first!.rootViewController!
        rootVC.addChild(hostingController)
        rootVC.view.insertSubview(hostedView, at: 0)
        defer {
            hostingController.removeFromParent()
            hostedView.removeFromSuperview()
        }
        let pdfRenderer = UIGraphicsPDFRenderer(bounds: bounds)

        return pdfRenderer.pdfData { rendererContext in
            rendererContext.beginPage()
            let cgContext = rendererContext.cgContext
            hostedView.layer.render(in: cgContext)
        }
    }
}

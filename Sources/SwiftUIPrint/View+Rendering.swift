import SwiftUI

public extension View {
    func image(size: CGSize) -> UIImage {
        DispatchQueue.main.sync {
            self
                .uiView(size: size)
                .image
        }
    }

    // Must be called on the main thread.
    private func uiView(size: CGSize) -> UIView {
        let frame = CGRect(origin: CGPoint(x: 50, y: 50), size: size)
        let window = UIWindow(frame: frame)
        let hosting = UIHostingController(rootView: self)
        hosting.view.frame = window.frame
        hosting.view.backgroundColor = .white
        window.addSubview(hosting.view)
        window.makeKeyAndVisible()
        return hosting.view
    }
}

public extension UIView {
    fileprivate var image: UIImage {
        return UIGraphicsImageRenderer(bounds: bounds).image {
            layer.render(in: $0.cgContext)
        }
    }
}

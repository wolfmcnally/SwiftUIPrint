import SwiftUI

struct ViewSize: PreferenceKey {
    static var defaultValue: CGSize?
    
    static func reduce(value: inout CGSize?, nextValue: () -> CGSize?) {
        value = nextValue()
        print("value: \(String(describing: value))")
        //            let n = nextValue()
        //            guard let next = n else { return }
        //            value = next
    }
}

public struct PagePreview<Page>: View where Page: View {
    let page: Page
    let pageSize: CGSize
    @Binding var marginsWidth: CGFloat
    
    @State private var viewSize: CGSize?
    @State private var pageScale: Double?
    @State private var scaledPageSize: CGSize?
    @State private var contentSize: CGSize?
    
    public init(page: Page, pageSize: CGSize, marginsWidth: Binding<CGFloat> = .constant(0)) {
        self._marginsWidth = marginsWidth
        self.page = page
        self.pageSize = pageSize
        self.scaledPageSize = nil
    }
    
    func updateSize() {
        self.scaledPageSize = nil
        self.pageScale = nil
        guard
            let viewSize = viewSize,
            viewSize.width > 0,
            viewSize.height > 0
        else {
            return
        }
        let pageDimensionsScale = CGVector(
            dx: viewSize.width / pageSize.width,
            dy: viewSize.height / pageSize.height
        )
        let pageScale = min(pageDimensionsScale.dx, pageDimensionsScale.dy)
        self.pageScale = pageScale
        self.scaledPageSize = CGSize(
            width: pageScale * pageSize.width,
            height: pageScale * pageSize.height
        )
        self.contentSize = CGSize(
            width: pageSize.width - marginsWidth * 2,
            height: pageSize.height - marginsWidth * 2
        )
    }
    
    public var content: some View {
        page
            .environment(\.colorScheme, .light)
            .scaleEffect(pageScale ?? 1)
            .frame(width: contentSize?.width, height: contentSize?.height)
    }
    
    public var body: some View {
        ZStack {
            Rectangle()
                .fill(Color.clear)
                .background(GeometryReader { p in
                    Color.clear
                        .preference(key: ViewSize.self, value: p.size)
                })
                .onPreferenceChange(ViewSize.self) {
                    viewSize = $0
                    updateSize()
                }
                .background(
                    Rectangle()
                        .fill(Color.white)
                        .frame(width: scaledPageSize?.width, height: scaledPageSize?.height)
                        .border(Color.gray, width: 1)
                )
                .overlay(content)
        }
        .onChange(of: marginsWidth) { _ in
            updateSize()
        }
    }
}

#if DEBUG

struct PagePreview_Previews: PreviewProvider {
    static var content: some View {
        SamplePageView()
    }
    
    static var previews: some View {
        PagePreview(page: content, pageSize: CGSize(width: 8.5 * 72, height: 11 * 72))
            .preferredColorScheme(.dark)
    }
}

#endif

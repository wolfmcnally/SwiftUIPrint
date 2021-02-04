import SwiftUI

public typealias PagePreview = PagePreviewNamespace.Preview

public enum PagePreviewNamespace {
    
    struct ViewSize: PreferenceKey {
        static var defaultValue: CGSize?
        
        static func reduce(value: inout CGSize?, nextValue: () -> CGSize?) {
            guard let n = nextValue() else { return }
            value = n
        }
    }
    
    struct PageSize: PreferenceKey {
        static var defaultValue: CGSize?
        
        static func reduce(value: inout CGSize?, nextValue: () -> CGSize?) {
            guard let n = nextValue() else { return }
            value = n
        }
    }
    
    public struct Preview<Page>: View where Page: View {
        let page: Page
        
        @Binding var pageSize: CGSize
        
        @State private var pageDimension: CGSize?
        @State private var myDimension: CGSize?

        public init(page: Page, pageSize: Binding<CGSize>) {
            self.page = page
            self._pageSize = pageSize
        }

        var content: some View {
            page
                .environment(\.colorScheme, .light)
        }

        var pageScale: CGFloat {
            guard let pageDimension = pageDimension, let myDimension = myDimension else { return 1 }
            let hScale = myDimension.width / pageDimension.width
            let vScale = myDimension.height / pageDimension.height
            return min(hScale, vScale)
        }
        
        var scaledPageSize: CGSize? {
            guard let pageDimension = pageDimension else { return nil }
            return CGSize(width: pageDimension.width * pageScale, height: pageDimension.height * pageScale)
        }
        
        public var body: some View {
            GeometryReader { viewProxy in
                ZStack(alignment: .topLeading) {
                    Rectangle()
                        .background(GeometryReader { p in
                            Color.clear
                                .preference(key: ViewSize.self, value: viewProxy.size)
                        })
                        .frame(width: scaledPageSize?.width, height: scaledPageSize?.height)
                    content
                        .frame(width: pageSize.width, height: pageSize.height)
                        .background(GeometryReader { pageProxy in
                            Color.white
                                .preference(key: PageSize.self, value: pageProxy.size)
                        })
                        .scaleEffect(pageScale, anchor: .zero)
                }
            }
            .frame(width: scaledPageSize?.width, height: scaledPageSize?.height)
            .border(Color.black, width: 1)
            .clipped()
            .onPreferenceChange(PageSize.self) {
                pageDimension = $0
            }
            .onPreferenceChange(ViewSize.self) {
                myDimension = $0
            }
        }
    }
    
}

#if DEBUG

struct PagePreview_Previews: PreviewProvider {
    static var content: some View {
        SamplePageView()
    }
    
    static var previews: some View {
        PagePreview(page: content, pageSize: .constant(CGSize(width: 8.5 * 72, height: 11 * 72)))
            .preferredColorScheme(.dark)
    }
}

#endif

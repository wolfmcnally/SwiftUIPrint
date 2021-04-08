import SwiftUI

public struct SamplePageView: View {
    let pageNumber: Int
    
    public init(pageNumber: Int = 1) {
        self.pageNumber = pageNumber
    }
    
    public var body: some View {
        ZStack {
            Circle()
                .inset(by: 2.5)
                .stroke(Color.blue, lineWidth: 5)
            VStack {
                Text("Hello, world!")
                Text("Page \(pageNumber)")
            }
            .padding()
            .background(Color.orange)
        }
        .background(
            Color.clear
                .border(Color.red, width: 5)
        )
    }
}

#if DEBUG

struct SamplePageView_Previews: PreviewProvider {
    static var previews: some View {
        SamplePageView()
            .previewLayout(.fixed(width: 8.5 * 72, height: 11 * 72))
            .preferredColorScheme(.dark)
    }
}

#endif

import SwiftUI

public struct SamplePageView: View {
    public init() { }
    
    public var body: some View {
        ZStack {
            Circle()
                .inset(by: 2.5)
                .stroke(Color.blue, lineWidth: 5)
            Text("Hello, world!")
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

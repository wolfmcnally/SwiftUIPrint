//
//  ContentView.swift
//  SwiftUIPrintDemo
//
//  Created by Wolf McNally on 2/3/21.
//

import SwiftUI
import SwiftUIPrint

struct ContentView: View {
    var body: some View {
        SamplePrintSetup(jobName: "Sample Job", pages: [
            SamplePageView(pageNumber: 1),
            SamplePageView(pageNumber: 2),
            SamplePageView(pageNumber: 3),
        ])
            .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

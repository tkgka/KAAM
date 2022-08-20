//
//  ContentView.swift
//  KAAM
//
//  Created by 김수환 on 2022/08/14.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack{
            Text("Hello, world!")
            Button("Quit", action: {
                NSApplication.shared.terminate(self)
            })
        }.frame(width: 200, height: 200, alignment: .center)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

//
//  ContentView.swift
//  KAAM
//
//  Created by 김수환 on 2022/08/14.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var KeyInput = KeyInputs
    var body: some View {
        VStack( alignment: .leading, spacing: 0){
            Text("KAAM")
                .font(Font.system(size: 15.0))
                .fontWeight(.semibold)
                .multilineTextAlignment(.leading)
                .padding(.horizontal, 15.0)
                .padding(.top, 15.0)
                .padding(.bottom, 15.0)
            
            Divider()
                .padding(.horizontal, 10.0)
                .frame(width: 300)
            
            HStack{
                KeyInput.MouseMode ?
                Text("Mouse Mode")
                    .font(Font.system(size: 12.0))
                    .fontWeight(.semibold)
                : Text("Keyboard Mode")
                    .font(Font.system(size: 12.0))
                    .fontWeight(.semibold)
                Spacer()
                Toggle("", isOn: $KeyInput.MouseMode).toggleStyle(SwitchToggleStyle(tint: Color.blue))
                    .onChange(of: KeyInput.MouseMode){ _ in
                        KAAM.statusBar?.updateStatusItemWith(Data: KeyInputs.MouseMode == true ? "| Mouse Mode | " : "| Keyboard Mode |")
                    }
            }
            .padding()
            
            Divider()
                .padding(.horizontal, 10.0)
                .frame(width: 300)
            
            Text("Speed")
                .font(Font.system(size: 12.0))
                .fontWeight(.semibold)
                .multilineTextAlignment(.leading)
                .padding(.horizontal, 15.0)
                .padding(.top, 15.0)
            
            HStack{
                Slider(value: $KeyInput.curserSpeed, in: 1...20, step: 1)
                Text("Curser Speed: \(Int(KeyInput.curserSpeed))")
            }.onChange(of: KeyInput.curserSpeed){ val in
                UserDefaults.standard.set(val, forKey:"curserSpeed")
            }
            .padding()
            
            HStack{
                Slider(value: $KeyInput.RepeatedcurserSpeed, in: 1...200)
                Text("Moving Speed: \(Int(KeyInput.RepeatedcurserSpeed))")
            }.onChange(of: KeyInput.RepeatedcurserSpeed){ val in
                UserDefaults.standard.set(val, forKey:"RepeatedcurserSpeed")
            }
            .padding()
            
            
            Divider()
                .padding(.horizontal, 10.0)
                .frame(width: 300)
            
            HStack{
                Spacer()
                Button("Quit", action: {
                    NSApplication.shared.terminate(self)
                }).padding()
            }
        }.frame(width: 300)
    }
}


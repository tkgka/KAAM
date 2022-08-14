import Cocoa
import SwiftUI
import ArrayFlags

class Wrapper {
    var state: State?
    
    class State {
        init(mouseDownEvent: CGEvent) {
            self.mouseDownEvent = mouseDownEvent
        }
        
        var mouseDownEvent: CGEvent
        var task: DispatchWorkItem!
        var isRight = false
        var mouseMoves: [CGPoint] = []
        
    }
}

func handle(event: NSEvent, cgEvent: CGEvent, wrapper: Wrapper, proxy: CGEventTapProxy) -> CGEvent? {
    if(event.type == .keyDown){
        print(GetArrayFlags(Val: event.modifierFlags.rawValue))
    }
    return cgEvent
}


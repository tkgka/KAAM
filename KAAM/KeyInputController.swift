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
    let ScreenWidth = NSScreen.main!.frame.width
    let ScreenHeight = NSScreen.main!.frame.height
    if(event.type == .keyDown){
        print(GetArrayFlags(Val: event.modifierFlags.rawValue))
        CGEvent(mouseEventSource: nil, mouseType: CGEventType.mouseMoved, mouseCursorPosition: CGPoint(x: ScreenWidth/2, y: ScreenHeight/2), mouseButton: CGMouseButton.left)?.post(tap: CGEventTapLocation.cghidEventTap)
        return nil
    }
    return cgEvent
}


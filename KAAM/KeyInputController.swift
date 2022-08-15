import Cocoa
import SwiftUI

import AlertPopup
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

var MouseMode:Bool = false
weak var AlertWindow:NSWindow? = nil

func handle(event: NSEvent, cgEvent: CGEvent, wrapper: Wrapper, proxy: CGEventTapProxy) -> CGEvent? {
    
    let ScreenWidth = NSScreen.main!.frame.width
    let ScreenHeight = NSScreen.main!.frame.height
    
    if(event.type == .keyDown){
        if (GetDictFlags(Val: event.modifierFlags.rawValue)["􀆔"]! != 0 && event.keyCode == 0x05){ // g
            MouseMode.toggle()
            if AlertWindow != nil{ closeWindow(window: AlertWindow!) } // remove Alert before Timer elapse
            AlertWindow = ShowSystemAlert(ImageName: "exclamationmark.circle", AlertText: "MouseMode: \(MouseMode)", Timer: 1.5) // show Alert
        }
        else if MouseMode == true && event.keyCode == 0x05{ //g
            CGEvent(mouseEventSource: nil, mouseType: CGEventType.leftMouseDown, mouseCursorPosition: CGPoint(x: cgEvent.location.x, y: cgEvent.location.y), mouseButton: CGMouseButton.left)?.post(tap: CGEventTapLocation.cghidEventTap)
        }
        else if MouseMode == true && event.keyCode == 0x04{ //h
            CGEvent(mouseEventSource: nil, mouseType: CGEventType.rightMouseDown, mouseCursorPosition: CGPoint(x: cgEvent.location.x, y: cgEvent.location.y), mouseButton: CGMouseButton.right)?.post(tap: CGEventTapLocation.cghidEventTap)
        }
        else if MouseMode == true && event.keyCode == 0x7B{ //􀄦
            CGEvent(mouseEventSource: nil, mouseType: CGEventType.mouseMoved, mouseCursorPosition: CGPoint(x: cgEvent.location.x - 10, y: cgEvent.location.y), mouseButton: CGMouseButton.left)?.post(tap: CGEventTapLocation.cghidEventTap)
            return nil
        }
        else if MouseMode == true && event.keyCode == 0x7C{ //􀄧
            CGEvent(mouseEventSource: nil, mouseType: CGEventType.mouseMoved, mouseCursorPosition: CGPoint(x: cgEvent.location.x + 10, y: cgEvent.location.y), mouseButton: CGMouseButton.left)?.post(tap: CGEventTapLocation.cghidEventTap)
            return nil
        }
        else if MouseMode == true && event.keyCode == 0x7D{ //􀄥
            CGEvent(mouseEventSource: nil, mouseType: CGEventType.mouseMoved, mouseCursorPosition: CGPoint(x: cgEvent.location.x, y: cgEvent.location.y + 10), mouseButton: CGMouseButton.left)?.post(tap: CGEventTapLocation.cghidEventTap)
            return nil
        }
        else if MouseMode == true && event.keyCode == 0x7E{ //􀄤
            CGEvent(mouseEventSource: nil, mouseType: CGEventType.mouseMoved, mouseCursorPosition: CGPoint(x: cgEvent.location.x, y: cgEvent.location.y - 10), mouseButton: CGMouseButton.left)?.post(tap: CGEventTapLocation.cghidEventTap)
            return nil
        }
    }
    else if (event.type == .keyUp){
        if MouseMode == true && event.keyCode == 0x05{ //g
                CGEvent(mouseEventSource: nil, mouseType: CGEventType.leftMouseUp, mouseCursorPosition: CGPoint(x: cgEvent.location.x, y: cgEvent.location.y), mouseButton: CGMouseButton.left)?.post(tap: CGEventTapLocation.cghidEventTap)
        }
        else if MouseMode == true && event.keyCode == 0x04{ //h
            CGEvent(mouseEventSource: nil, mouseType: CGEventType.rightMouseUp, mouseCursorPosition: CGPoint(x: cgEvent.location.x, y: cgEvent.location.y), mouseButton: CGMouseButton.right)?.post(tap: CGEventTapLocation.cghidEventTap)
        }
    }
    return cgEvent
}


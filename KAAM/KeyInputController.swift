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
    var curserSpeed:CGFloat = 10
    if(event.type == .keyDown){
        if (GetDictFlags(Val: event.modifierFlags.rawValue)["􀆔"]! != 0 && event.keyCode == 0x05){ // g
            MouseMode.toggle()
            if AlertWindow != nil{ closeWindow(window: AlertWindow!) } // remove Alert before Timer elapse
            AlertWindow = ShowSystemAlert(ImageName: "exclamationmark.circle", AlertText: "MouseMode: \(MouseMode)", Timer: 1.5) // show Alert
            
            KAAM.statusBar?.updateStatusItemWith(Data: MouseMode == true ? "Mouse Mode " : "Keyboard Mode")
            
            return nil
        }
        else if MouseMode == true{
            if event.isARepeat == true{
                curserSpeed = 70
            }
            if event.keyCode == 0x03{ //f
                CGEvent(mouseEventSource: nil, mouseType: CGEventType.leftMouseDown, mouseCursorPosition: CGPoint(x: cgEvent.location.x, y: cgEvent.location.y), mouseButton: CGMouseButton.left)?.post(tap: CGEventTapLocation.cghidEventTap)
            }
            else if event.keyCode == 0x05{ //g
                CGEvent(mouseEventSource: nil, mouseType: CGEventType.rightMouseDown, mouseCursorPosition: CGPoint(x: cgEvent.location.x, y: cgEvent.location.y), mouseButton: CGMouseButton.right)?.post(tap: CGEventTapLocation.cghidEventTap)
            }
            else if event.keyCode == 0x26{ //􀄦, j
                CGEvent(mouseEventSource: nil, mouseType: CGEventType.mouseMoved, mouseCursorPosition: CGPoint(x: cgEvent.location.x - curserSpeed, y: cgEvent.location.y), mouseButton: CGMouseButton.left)?.post(tap: CGEventTapLocation.cghidEventTap)
            }
            else if event.keyCode == 0x25{ //􀄧, l
                CGEvent(mouseEventSource: nil, mouseType: CGEventType.mouseMoved, mouseCursorPosition: CGPoint(x: cgEvent.location.x + curserSpeed, y: cgEvent.location.y), mouseButton: CGMouseButton.left)?.post(tap: CGEventTapLocation.cghidEventTap)
            }
            else if event.keyCode == 0x28{ //􀄥, k
                CGEvent(mouseEventSource: nil, mouseType: CGEventType.mouseMoved, mouseCursorPosition: CGPoint(x: cgEvent.location.x, y: cgEvent.location.y + curserSpeed), mouseButton: CGMouseButton.left)?.post(tap: CGEventTapLocation.cghidEventTap)
            }
            else if event.keyCode == 0x22{ //􀄤, i
                CGEvent(mouseEventSource: nil, mouseType: CGEventType.mouseMoved, mouseCursorPosition: CGPoint(x: cgEvent.location.x, y: cgEvent.location.y - curserSpeed), mouseButton: CGMouseButton.left)?.post(tap: CGEventTapLocation.cghidEventTap)
            }
            else if event.keyCode == 0x29 || event.keyCode == 0x20{ // ;, i
                CGEvent(scrollWheelEvent2Source: nil, units: CGScrollEventUnit.line, wheelCount: 2, wheel1: Int32(30), wheel2: Int32(0), wheel3: Int32(0))?.post(tap: CGEventTapLocation.cghidEventTap)
            }
            else if event.keyCode == 0x27 || event.keyCode == 0x1F{ // ', o
                CGEvent(scrollWheelEvent2Source: nil, units: CGScrollEventUnit.line, wheelCount: 2, wheel1: Int32(-30), wheel2: Int32(0), wheel3: Int32(0))?.post(tap: CGEventTapLocation.cghidEventTap)
            }
            else{
                return cgEvent
            }
            return nil
        }
    }
    else if (event.type == .keyUp){
        if MouseMode == true && event.keyCode == 0x03{ //f
            CGEvent(mouseEventSource: nil, mouseType: CGEventType.leftMouseUp, mouseCursorPosition: CGPoint(x: cgEvent.location.x, y: cgEvent.location.y), mouseButton: CGMouseButton.left)?.post(tap: CGEventTapLocation.cghidEventTap)
        }
        else if MouseMode == true && event.keyCode == 0x05{ //g
            CGEvent(mouseEventSource: nil, mouseType: CGEventType.rightMouseUp, mouseCursorPosition: CGPoint(x: cgEvent.location.x, y: cgEvent.location.y), mouseButton: CGMouseButton.right)?.post(tap: CGEventTapLocation.cghidEventTap)
        }
    }
    return cgEvent
}


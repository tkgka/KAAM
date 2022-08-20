//
//  StatusBarController.swift
//  WeatherToday
//
//  Created by 김수환 on 2022/04/10.
//

import AppKit



var TitleText = "| Keyboard Mode |"


class StatusBarController {
    private var statusBar: NSStatusBar
    private var statusItem: NSStatusItem
    private var popover: NSPopover
    
    init(_ popover: NSPopover) {
        self.popover = popover
        statusBar = NSStatusBar.init()
        statusItem = statusBar.statusItem(withLength: CGFloat(TitleText.count * 7))
        
        if let statusBarButton = statusItem.button {
            statusBarButton.title = TitleText
//            statusBarButton.image?.isTemplate = true
            statusBarButton.action = #selector(togglePopover(sender:))
            statusBarButton.target = self
        }
        
    }
    
    func updateStatusItemWith(Data:String, IMG:String? = nil) {
        DispatchQueue.main.async { [weak self] in
            guard let `self` = self else { return }
            
            let Length:CGFloat?
            
            IMG != nil ? (Length = CGFloat(Data.count * 7 + 20)) : (Length = CGFloat(Data.count * 7))
            
            self.statusItem = self.statusBar.statusItem(withLength: Length!)
            if(IMG != nil){
                self.statusItem.button?.image = NSImage(systemSymbolName: IMG!, accessibilityDescription: nil)
                self.statusItem.button?.imagePosition = .imageLeading
            }else {
                self.statusItem.button?.image = nil
            }
            self.statusItem.button?.title = Data
            self.statusItem.button?.action = #selector(self.togglePopover(sender:))
            self.statusItem.button?.target = self
            if(self.popover.isShown){
                self.popover.performClose(nil)
                if let statusBarButton = self.statusItem.button {
                self.popover.show(relativeTo: statusBarButton.bounds, of: statusBarButton, preferredEdge: NSRectEdge.maxY)
                }
            }
        }
    }
    
    @objc func togglePopover(sender: AnyObject) {
        if(popover.isShown) {
            hidePopover(sender)
        }
        else {
            showPopover(sender)
        }
    }
    
    func showPopover(_ sender: AnyObject) {
        if let statusBarButton = statusItem.button {
            popover.show(relativeTo: statusBarButton.bounds, of: statusBarButton, preferredEdge: NSRectEdge.maxY)
        }
    }
    
    func hidePopover(_ sender: AnyObject) {
        popover.performClose(sender)
    }
}





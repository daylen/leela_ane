//
//  AppDelegate.swift
//  test
//
//  Created by Daylen Yang on 11/27/20.
//

import Cocoa
import SwiftUI
import CoreML

@main
class AppDelegate: NSObject, NSApplicationDelegate {

    var window: NSWindow!


    func applicationDidFinishLaunching(_ aNotification: Notification) {
        // Create the SwiftUI view that provides the window contents.
        let contentView = ContentView()

        // Create the window and set the content view.
        window = NSWindow(
            contentRect: NSRect(x: 0, y: 0, width: 480, height: 300),
            styleMask: [.titled, .closable, .miniaturizable, .resizable, .fullSizeContentView],
            backing: .buffered, defer: false)
        window.isReleasedWhenClosed = false
        window.center()
        window.setFrameAutosaveName("Main Window")
        window.contentView = NSHostingView(rootView: contentView)
        window.makeKeyAndOrderFront(nil)

        // ANE?
        let config = MLModelConfiguration()
        config.computeUnits = .all
        
        do {
            let tokenIDMultiArray = try! MLMultiArray(shape: [32, 112, 64], dataType: MLMultiArrayDataType.float32)
            for i in 0..<32 {
                for j in 0..<112 {
                    for k in 0..<64 {
                        let index = [i, j, k] as [NSNumber]
                        tokenIDMultiArray[index] = (Float.random(in: -1..<1) as NSNumber)
                    }
                }
            }
            
            let model = try _42850_T40.init(configuration: config)
            let start = DispatchTime.now()
            for _ in 1...100 {
                try model.prediction(input_1: tokenIDMultiArray)
            }
            let end = DispatchTime.now()
            let nanoTime = end.uptimeNanoseconds - start.uptimeNanoseconds // <<<<< Difference in nano seconds (UInt64)
            let timeInterval = Double(nanoTime) / 1_000_000_000 // Technically could overflow for long running tests
            print("Time to evaluate: \(timeInterval) seconds")

//            print(out.Identity)
//            print(out.Identity_1)
        } catch {
            print("Error running model!")
        }
    }

    func applicationWillTerminate(_ aNotification: Notification) {
        // Insert code here to tear down your application
    }


}


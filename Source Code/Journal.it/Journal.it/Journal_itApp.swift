//
//  Journal_itApp.swift
//  Journal.it
//
//  Created by Mark Howard on 01/02/2022.
//

import SwiftUI

@main
struct Journal_itApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView(audioRecorder: AudioRecorder())
        }
    }
}

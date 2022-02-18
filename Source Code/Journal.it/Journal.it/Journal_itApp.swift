//
//  Journal_itApp.swift
//  Journal.it
//
//  Created by Mark Howard on 01/02/2022.
//

import SwiftUI
import SwiftSpeech

@main
struct Journal_itApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView(audioRecorder: AudioRecorder())
            #if !targetEnvironment(macCatalyst)
                .onAppear {
                    SwiftSpeech.requestSpeechRecognitionAuthorization()
                }
            #endif
        }
    }
}

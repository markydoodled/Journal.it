//
//  AudioToText.swift
//  Journal.it
//
//  Created by Mark Howard on 13/02/2022.
//

import SwiftUI
import SwiftSpeech
import Speech

struct AudioToText: View {
    @Environment(\.horizontalSizeClass) var horizontalSizeClass
    @State var recognisedText = "Tap To Start"
    @State var showingShare = false
    var sessionConfiguration: SwiftSpeech.Session.Configuration
    init(sessionConfiguration: SwiftSpeech.Session.Configuration) {
        self.sessionConfiguration = sessionConfiguration
    }
    init(locale: Locale = .current) {
        self.init(sessionConfiguration: SwiftSpeech.Session.Configuration(locale: locale))
    }
    init(localeIdentifier: String) {
        self.init(locale: Locale(identifier: localeIdentifier))
    }
    var body: some View {
        if horizontalSizeClass == .compact {
            NavigationView {
                VStack(spacing: 35.0) {
                    Text(recognisedText)
                        .font(.system(size: 25, weight: .bold, design: .default))
                    SwiftSpeech.RecordButton()
                        .swiftSpeechToggleRecordingOnTap(sessionConfiguration: sessionConfiguration, animation: .spring(response: 0.3, dampingFraction: 0.5, blendDuration: 0))
                        .onRecognizeLatest(update: $recognisedText)
                        .printRecognizedText(includePartialResults: true)
                }
                    .onAppear {
                        SwiftSpeech.requestSpeechRecognitionAuthorization()
                    }
                    .navigationTitle("Audio To Text")
                    .navigationBarTitleDisplayMode(.inline)
                    .toolbar {
                        ToolbarItem(placement: .navigationBarTrailing) {
                            Button(action: {self.showingShare = true}) {
                                Image(systemName: "square.and.arrow.up")
                            }
                            .sheet(isPresented: $showingShare) {
                                ActivityView(activityItems: [recognisedText] as [Any], applicationActivities: nil)
                            }
                        }
                    }
            }
        } else {
            VStack(spacing: 35.0) {
                Text(recognisedText)
                    .font(.system(size: 25, weight: .bold, design: .default))
                SwiftSpeech.RecordButton()
                    .swiftSpeechToggleRecordingOnTap(sessionConfiguration: sessionConfiguration, animation: .spring(response: 0.3, dampingFraction: 0.5, blendDuration: 0))
                    .onRecognizeLatest(update: $recognisedText)
                    .printRecognizedText(includePartialResults: true)
            }
                .onAppear {
                    SwiftSpeech.requestSpeechRecognitionAuthorization()
                }
                .navigationTitle("Audio To Text")
                .navigationBarTitleDisplayMode(.inline)
                .toolbar {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Button(action: {self.showingShare = true}) {
                            Image(systemName: "square.and.arrow.up")
                        }
                        .sheet(isPresented: $showingShare) {
                            ActivityView(activityItems: [recognisedText] as [Any], applicationActivities: nil)
                        }
                    }
                }
        }
    }
}

struct AudioToText_Previews: PreviewProvider {
    static var previews: some View {
        AudioToText()
    }
}

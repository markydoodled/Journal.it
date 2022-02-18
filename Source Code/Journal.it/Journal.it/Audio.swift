//
//  Audio.swift
//  Journal.it
//
//  Created by Mark Howard on 02/02/2022.
//

import SwiftUI
import AVFoundation

struct Audio: View {
    @Environment(\.horizontalSizeClass) var horizontalSizeClass
    @Environment(\.colorScheme) var colorScheme
    @ObservedObject var audioRecorder: AudioRecorder
    @State var showingEditing = false
    @State var showingFileImport = false
    @State var fileName = ""
    @State var editingURL = URL(string: "")
    @State var startHours = "00"
    @State var startMinutes = "00"
    @State var startSeconds = "00"
    @State var endHours = "00"
    @State var endMinutes = "00"
    @State var endSeconds = "00"
    @State var asset: AVURLAsset!
    let outputFileName = "Edited-File"
    @State var showingFinderPath = false
    @State var finderPathString = "~/Library/Containers/com.MSJ.Journal-it/Data/Documents/"
    var body: some View {
        if horizontalSizeClass == .compact {
            NavigationView {
                VStack {
                    RecordingsList(audioRecorder: audioRecorder)
                    if audioRecorder.recording == false {
                        Button(action: {self.audioRecorder.startRecording()}) {
                            ZStack {
                                if colorScheme == .dark {
                                Image(systemName: "circle.fill")
                                    .resizable()
                                    .aspectRatio(contentMode: .fill)
                                    .frame(width: 80, height: 80)
                                    .clipped()
                                    .foregroundColor(.white)
                                    .padding(.bottom, 40)
                                } else {
                                    Image(systemName: "circle.fill")
                                        .resizable()
                                        .aspectRatio(contentMode: .fill)
                                        .frame(width: 80, height: 80)
                                        .clipped()
                                        .foregroundColor(.black)
                                        .padding(.bottom, 40)
                                }
                                Image(systemName: "circle.fill")
                                    .resizable()
                                    .aspectRatio(contentMode: .fill)
                                    .frame(width: 70, height: 70)
                                    .clipped()
                                    .foregroundColor(.red)
                                    .padding(.bottom, 40)
                            }
                        }
                    } else {
                        Button(action: {self.audioRecorder.stopRecording()}) {
                            ZStack {
                                if colorScheme == .dark {
                                Image(systemName: "stop.fill")
                                    .resizable()
                                    .aspectRatio(contentMode: .fill)
                                    .frame(width: 80, height: 80)
                                    .clipped()
                                    .foregroundColor(.white)
                                    .padding(.bottom, 40)
                                } else {
                                    Image(systemName: "stop.fill")
                                        .resizable()
                                        .aspectRatio(contentMode: .fill)
                                        .frame(width: 80, height: 80)
                                        .clipped()
                                        .foregroundColor(.black)
                                        .padding(.bottom, 40)
                                }
                                Image(systemName: "stop.fill")
                                    .resizable()
                                    .aspectRatio(contentMode: .fill)
                                    .frame(width: 70, height: 70)
                                    .clipped()
                                    .foregroundColor(.red)
                                    .padding(.bottom, 40)
                            }
                        }
                    }
                }
                    .navigationTitle("Audio")
                    .navigationBarTitleDisplayMode(.inline)
                    .toolbar {
                        ToolbarItem(placement: .navigationBarTrailing) {
                            EditButton()
                        }
                        ToolbarItem(placement: .navigationBarLeading) {
                            Button(action: {self.showingEditing = true}) {
                                Image(systemName: "scissors")
                            }
                            .sheet(isPresented: $showingEditing) {
                                editing
                            }
                        }
                        #if targetEnvironment(macCatalyst)
                        ToolbarItem(placement: .navigationBarLeading) {
                            Button(action: {self.showingFinderPath = true}) {
                                Image(systemName: "folder")
                            }
                            .sheet(isPresented: $showingFinderPath) {
                                finderPath
                            }
                        }
                        #endif
                    }
            }
        } else {
            VStack {
            RecordingsList(audioRecorder: audioRecorder)
                if audioRecorder.recording == false {
                    Button(action: {self.audioRecorder.startRecording()}) {
                        ZStack {
                            if colorScheme == .dark {
                        Image(systemName: "circle.fill")
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(width: 80, height: 80)
                                .clipped()
                                .foregroundColor(.white)
                                .padding(.bottom, 40)
                            } else {
                                Image(systemName: "circle.fill")
                                        .resizable()
                                        .aspectRatio(contentMode: .fill)
                                        .frame(width: 80, height: 80)
                                        .clipped()
                                        .foregroundColor(.black)
                                        .padding(.bottom, 40)
                            }
                        Image(systemName: "circle.fill")
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: 70, height: 70)
                            .clipped()
                            .foregroundColor(.red)
                            .padding(.bottom, 40)
                    }
                    }
                } else {
                    Button(action: {self.audioRecorder.stopRecording()}) {
                        ZStack {
                            if colorScheme == .dark {
                            Image(systemName: "stop.fill")
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(width: 80, height: 80)
                                .clipped()
                                .foregroundColor(.white)
                                .padding(.bottom, 40)
                            } else {
                                Image(systemName: "stop.fill")
                                    .resizable()
                                    .aspectRatio(contentMode: .fill)
                                    .frame(width: 80, height: 80)
                                    .clipped()
                                    .foregroundColor(.black)
                                    .padding(.bottom, 40)
                            }
                        Image(systemName: "stop.fill")
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: 70, height: 70)
                            .clipped()
                            .foregroundColor(.red)
                            .padding(.bottom, 40)
                    }
                }
                }
            }
                .navigationTitle("Audio")
                .navigationBarTitleDisplayMode(.inline)
                .toolbar {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        EditButton()
                    }
                    ToolbarItem(placement: .navigationBarLeading) {
                        Button(action: {self.showingEditing = true}) {
                            Image(systemName: "scissors")
                        }
                        .sheet(isPresented: $showingEditing) {
                            editing
                        }
                    }
                    #if targetEnvironment(macCatalyst)
                    ToolbarItem(placement: .navigationBarLeading) {
                        Button(action: {self.showingFinderPath = true}) {
                            Image(systemName: "folder")
                        }
                        .sheet(isPresented: $showingFinderPath) {
                            finderPath
                        }
                    }
                    #endif
                }
        }
    }
    var finderPath: some View {
        NavigationView {
            VStack {
                Text("\(finderPathString)")
                    .textSelection(.enabled)
                Button(action: {UIPasteboard.general.string = self.finderPathString}) {
                    Label("Copy", systemImage: "doc.on.doc")
                }
                .buttonStyle(.bordered)
                .tint(.accentColor)
                .padding()
            }
            .navigationTitle("Path To App Folder")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {self.showingFinderPath = false}) {
                        Text("Done")
                    }
                }
            }
        }
    }
    var editing: some View {
        NavigationView {
            VStack {
                Button(action: {self.showingFileImport = true}) {
                    Label("Open Audio File", systemImage: "folder")
                }
                .buttonStyle(.bordered)
                .tint(.accentColor)
                HStack {
                    Spacer()
                    Text("File Name: ")
                    Spacer()
                    Text("\(fileName)")
                    Spacer()
                }
                .padding()
                .fileImporter(isPresented: $showingFileImport, allowedContentTypes: [.mpeg4Audio], allowsMultipleSelection: false) { result in
                    do {
                        guard let selectedFile: URL = try result.get().first else { return }
                        let message = selectedFile.lastPathComponent
                        editingURL = selectedFile
                        fileName = message
                        let url = URL(fileURLWithPath: editingURL!.path)
                        self.asset = AVURLAsset(url: url, options: [AVURLAssetPreferPreciseDurationAndTimingKey : true])
                    } catch {
                        print("Failed To Get URL")
                    }
                }
                Divider()
                HStack {
                    Text("Start: ")
                    Spacer()
                    TextField("Hours...", text: $startHours)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                    Spacer()
                    TextField("Minutes...", text: $startMinutes)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                    Spacer()
                    TextField("Seconds...", text: $startSeconds)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                    Spacer()
                }
                .padding()
                HStack {
                    Text("End: ")
                    Spacer()
                    TextField("Hours...", text: $endHours)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                    Spacer()
                    TextField("Minutes...", text: $endMinutes)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                    Spacer()
                    TextField("Seconds...", text: $endSeconds)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                    Spacer()
                }
                .padding()
            }
                .navigationTitle("Editing")
                .navigationBarTitleDisplayMode(.inline)
                .toolbar {
                    ToolbarItem(placement: .navigationBarLeading) {
                        Button(action: {self.showingEditing = false}) {
                            Text("Cancel")
                        }
                    }
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Button(action: {trimAudioAction()
                            self.showingEditing = false
                        }) {
                            Text("Save")
                        }
                    }
                }
        }
    }
    //~/Library/Containers/com.MSJ.Journal-it/Data/Documents/
    func trimAudioAction() {

            var startTime: Float?
            var finalTime: Float?

            let startTimeHoursText = startHours
            let startTimeMinutesText = startMinutes
            let startTimeSecondsText = startSeconds
            let finalTimeHoursText = endHours
            let finalTimeMinutesText = endMinutes
            let finalTimeSecondsText = endSeconds
            
            let startTimeHours = Float(startTimeHoursText)
            let startTimeMinutes = Float(startTimeMinutesText)
            let startTimeSeconds = Float(startTimeSecondsText)
            
            let finalTimeHours = Float(finalTimeHoursText)
            let finalTimeMinutes = Float(finalTimeMinutesText)
            let finalTimeSeconds = Float(finalTimeSecondsText)

            if let startTimeHours = startTimeHours {
                startTime = startTimeHours  * 60.0
            }

            if let startTimeMinutes = startTimeMinutes {
                startTime =  (startTime ?? 0)  *  60.0 + startTimeMinutes *  60.0
            }

            if let startTimeSeconds = startTimeSeconds {
                startTime = (startTime ?? 0) + startTimeSeconds
            }

            if let finalTimeHours = finalTimeHours {
                finalTime = (finalTimeHours  *  60.0)
            }

            if let finalTimeMinutes = finalTimeMinutes {
                finalTime = (finalTime ?? 0)  *  60.0 + finalTimeMinutes  *  60.0
            }

            if let finalTimeSeconds = finalTimeSeconds {
                finalTime = (finalTime ?? 0) + finalTimeSeconds
            }
            
            let length = Float(asset.duration.value) / Float(asset.duration.timescale)
            print("Audio Length: \(length) Seconds")
            
            
            let fileManager = FileManager.default
        
        guard let documentDirectory = try? fileManager.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: true) else { return }
            
            
            var outputURL = documentDirectory.appendingPathComponent("Output")
            do {
                try fileManager.createDirectory(at: outputURL, withIntermediateDirectories: true, attributes: nil)
                
                outputURL = outputURL.appendingPathComponent("\(outputFileName).m4a")
            } catch let error {
                print(error)
            }
            
            _ = try? fileManager.removeItem(at: outputURL)

            guard let exportSession = AVAssetExportSession(asset: asset, presetName: AVAssetExportPresetAppleM4A) else {return}

            exportSession.outputURL = outputURL
            exportSession.outputFileType = AVFileType.m4a
            
            let start = startTime
            let end = finalTime
            
            let startTimeRange = CMTime(seconds: Double(start ?? 0), preferredTimescale: 1000)
            let endTimeRange = CMTime(seconds: Double(end ?? length), preferredTimescale: 1000)
            let timeRange = CMTimeRange(start: startTimeRange, end: endTimeRange)
            
            exportSession.timeRange = timeRange
            exportSession.exportAsynchronously {
                switch exportSession.status {
                case .completed:
                    print("Exported At \(outputURL)")
                case .failed:
                    print("Failed \(String(describing: exportSession.error))")
                case .cancelled:
                    print("Cancelled \(String(describing: exportSession.error))")
                default:
                    break
                }
            }
        }
}

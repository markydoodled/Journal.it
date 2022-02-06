//
//  ContentView.swift
//  Journal.it
//
//  Created by Mark Howard on 01/02/2022.
//

import SwiftUI

struct ContentView: View {
    @Environment(\.horizontalSizeClass) var horizontalSizeClass
    @State var tabSelection = 1
    @ObservedObject var audioRecorder: AudioRecorder
    @State var showingSettings = false
    var body: some View {
        if horizontalSizeClass == .compact {
            TabView(selection: $tabSelection) {
                Notes()
                    .tag(1)
                    .tabItem {
                        VStack {
                            Image(systemName: "note.text")
                            Text("Notes")
                        }
                    }
                Audio(audioRecorder: audioRecorder)
                    .tag(2)
                    .tabItem {
                        VStack {
                            Image(systemName: "mic")
                            Text("Audio")
                        }
                    }
                Camera()
                    .tag(3)
                    .tabItem {
                        VStack {
                            Image(systemName: "camera")
                            Text("Camera")
                        }
                    }
                NavigationView {
                    SettingsView()
                        .navigationTitle("Settings")
                }
                .tag(4)
                .tabItem {
                    VStack {
                        Image(systemName: "gearshape")
                        Text("Settings")
                    }
                }
            }
        } else {
            NavigationView {
                List {
                    NavigationLink(destination: Notes()) {
                        Label("Notes", systemImage: "note.text")
                    }
                    NavigationLink(destination: Audio(audioRecorder: audioRecorder)) {
                        Label("Audio", systemImage: "mic")
                    }
                    NavigationLink(destination: Camera()) {
                        Label("Camera", systemImage: "camera")
                    }
                }
                .toolbar {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Button(action: {self.showingSettings = true}) {
                            Image(systemName: "gearshape")
                        }
                        .sheet(isPresented: $showingSettings) {
                            NavigationView {
                                SettingsView()
                                    .navigationTitle("Settings")
                                    .toolbar {
                                        ToolbarItem(placement: .navigationBarTrailing) {
                                            Button(action: {self.showingSettings = false}) {
                                                Text("Done")
                                            }
                                        }
                                    }
                            }
                        }
                    }
                }
                .listStyle(SidebarListStyle())
                .navigationTitle("Journal.it")
                VStack {
                    Image("AppsIcon")
                        .resizable()
                        .cornerRadius(25)
                        .frame(width: 150, height: 150)
                    Text("Journal.it")
                        .font(.title2)
                        .bold()
                        .padding()
                }
            }
        }
    }
}


struct ActivityView: UIViewControllerRepresentable {
    let activityItems: [Any]
    let applicationActivities: [UIActivity]?
    
    func makeUIViewController(context: UIViewControllerRepresentableContext<ActivityView>) -> UIActivityViewController {
            return UIActivityViewController(activityItems: activityItems, applicationActivities: applicationActivities)
        }
    func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
        
    }
}

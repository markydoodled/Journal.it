//
//  Notes.swift
//  Journal.it
//
//  Created by Mark Howard on 02/02/2022.
//

import SwiftUI
import HighlightedTextEditor

struct Notes: View {
    @Environment(\.horizontalSizeClass) var horizontalSizeClass
    @State var showingShareSheet = false
    @AppStorage("notes") var notes: String = "Type Some Notes Here..."
    var body: some View {
        if horizontalSizeClass == .compact {
            NavigationView {
                VStack {
                    HighlightedTextEditor(text: $notes, highlightRules: .url)
                        .onCommit {
                            print("Commited")
                        }
                        .onEditingChanged {
                            print("Editing Changed")
                        }
                        .onTextChange {
                            print("Lastest Text Value", $0)
                        }
                        .onSelectionChange {
                            (range: NSRange) in
                            print(range)
                        }
                        .introspect { editor in
                            editor.textView.backgroundColor = .clear
                        }
                }
                .navigationTitle("Notes")
                .navigationBarTitleDisplayMode(.inline)
                .toolbar {
                    ToolbarItem(placement: .navigationBarLeading) {
                        Button(action: {UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)}) {
                            Image(systemName: "keyboard.chevron.compact.down")
                        }
                    }
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Button(action: {self.showingShareSheet = true}) {
                            Image(systemName: "square.and.arrow.up")
                        }
                        .sheet(isPresented: $showingShareSheet) {
                            ActivityView(activityItems: [notes] as [Any], applicationActivities: nil)
                        }
                    }
                }
            }
        } else {
            VStack {
                HighlightedTextEditor(text: $notes, highlightRules: .url)
                    .onCommit {
                        print("Commited")
                    }
                    .onEditingChanged {
                        print("Editing Changed")
                    }
                    .onTextChange {
                        print("Lastest Text Value", $0)
                    }
                    .onSelectionChange {
                        (range: NSRange) in
                        print(range)
                    }
                    .introspect { editor in
                        editor.textView.backgroundColor = .clear
                    }
            }
            .navigationTitle("Notes")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button(action: {UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)}) {
                        Image(systemName: "keyboard.chevron.compact.down")
                    }
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {self.showingShareSheet = true}) {
                        Image(systemName: "square.and.arrow.up")
                    }
                    .sheet(isPresented: $showingShareSheet) {
                        ActivityView(activityItems: [notes] as [Any], applicationActivities: nil)
                    }
                }
            }
        }
    }
}

struct Notes_Previews: PreviewProvider {
    static var previews: some View {
        Notes()
    }
}

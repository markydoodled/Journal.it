//
//  SettingsView.swift
//  Journal.it
//
//  Created by Mark Howard on 02/02/2022.
//

import SwiftUI

struct SettingsView: View {
    var body: some View {
        Form {
            HStack {
                Text("Version")
                Spacer()
                Text("1.1")
            }
            HStack {
                Text("Build")
                Spacer()
                Text("5")
            }
        }
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}

//
//  ValueCreateView.swift
//  EchoOfLife
//
//  Created by Kateryna Pavlova on 02/10/2026.
//

import SwiftUI
import SwiftData

struct ValueCreateView: View {
    @Environment(\.dismiss) private var dismiss
    
    @State private var name: String = ""
    @State private var details: String = ""
    
    let onSave: (Value) -> Void
    
    var body: some View {
        NavigationStack {
            Form {
                Section("Value") {
                    TextField("Name", text: $name)
                    TextField("Details", text: $details)
                }
            }
            .navigationTitle("New Value")
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") {
                        dismiss()
                    }
                }
                ToolbarItem(placement: .confirmationAction) {
                    Button("Save") {
                        let value = Value(name: name, details: details)
                        onSave(value)
                        dismiss()
                    }
                }
            }
        }
    }
}

//#Preview {
//    ValueCreateView()
//}

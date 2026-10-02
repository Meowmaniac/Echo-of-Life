//
//  ValueEditView.swift
//  EchoOfLife
//
//  Created by Kateryna Pavlova on 02/10/2026.
//

import SwiftUI
import SwiftData

struct ValueEditView: View {
    @Environment(\.modelContext) private var modelContext
    @Environment(\.dismiss) private var dismiss
    @Bindable var value: Value
    
    var body: some View {
        NavigationStack {
            Form {
                Section("Value") {
                    TextField("Name", text: $value.name)
                    TextField(
                        "Details",
                        text: Binding(
                            get: { value.details ?? ""},
                            set: { value.details = $0.isEmpty ? nil : $0 }
                        )
                    )
                    
                }
                HStack {
                    Text("Archive")
                    Spacer()
                    Button {
                        if value.archivedAt == nil {
                            value.archivedAt = Date()
                        } else {
                            value.archivedAt = nil
                        }
                    } label: {
                        Image(systemName: value.archivedAt != nil ? "archivebox.fill" : "archivebox")
                    }
                }
            }
            .toolbar {
                ToolbarItem(placement: .confirmationAction) {
                    Button("Done") {
                        do {
                            try modelContext.save()
                            dismiss()
                        } catch {
                            print("Can't save the context: \(error.localizedDescription)")
                        }
                    }
                }
            }
        }
    }
}

//#Preview {
//    ValueEditView()
//}

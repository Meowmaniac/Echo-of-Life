//
//  ReflectionCreateView.swift
//  EchoOfLife
//
//  Created by Kateryna Pavlova on 14/10/2026.
//

import SwiftUI

struct ReflectionCreateView: View {
    @Environment(\.dismiss) private var dismiss
    @State private var text: String = ""
    @State private var periodStart: Date = Date()
    @State private var period: ReflectionPeriod = .day
    @State private var isPeriod: Bool = false
    
    let onSave: (Reflection) -> Void
    
    var body: some View {
        NavigationStack {
            Form {
                Section("Reflection") {
                    TextField("What is on your mind?", text: $text)
                }
                Toggle("Select period", isOn: $isPeriod)
                if isPeriod {
                    Section("Date") {
                        DatePicker("Period start", selection: $periodStart, displayedComponents: .date)
                        Picker("Period", selection: $period) {
                            ForEach(
                                [ReflectionPeriod.day,
                                 .month,
                                 .year],
                                id: \.self
                            ) { period in
                                Text(period.rawValue.capitalized)
                                    .tag(period)
                            }
                        }
                    }
                }
            }
            .navigationTitle("New Reflection")
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") {
                        dismiss()
                    }
                }
                ToolbarItem(placement: .confirmationAction) {
                    Button("Save") {
                        let reflection = Reflection(
                            text: text,
                            period: isPeriod ? period : nil,
                            periodStart: isPeriod ? periodStart : nil
                        )
                        onSave(reflection)
                        dismiss()
                    }
                }
            }
        }
    }
}

//#Preview {
//    ReflectionCreateView()
//}

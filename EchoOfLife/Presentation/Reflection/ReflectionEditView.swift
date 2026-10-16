//
//  ReflectionEditView.swift
//  EchoOfLife
//
//  Created by Kateryna Pavlova on 15/10/2026.
//

import SwiftUI
import SwiftData

struct ReflectionEditView: View {
    @Environment(\.dismiss) private var dismiss
    @Environment(\.modelContext) private var modelContext
    
    @Bindable var reflection: Reflection
    @State private var isPeriod: Bool = false
    @State private var periodStart: Date = Date()
    @State private var period: ReflectionPeriod = .day
    
    init(reflection: Reflection) {
        self.reflection = reflection
        _isPeriod = State(initialValue: reflection.periodStart != nil)
    }
    
    var body: some View {
        NavigationStack {
            Form {
                Section("Reflection") {
                    TextField("", text: $reflection.text)
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
            .navigationTitle("Edit Reflection")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .confirmationAction) {
                    Button("Done") {
                        do {
                            try modelContext.save()
                            dismiss()
                        } catch {
                            print("Failed to save LifeItem: \(error)") // change later
                        }
                    }
                }
            }
        }
    }
}

//#Preview {
//    ReflectionEditView()
//}

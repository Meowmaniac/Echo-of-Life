//
//  ValueSelectView.swift
//  EchoOfLife
//
//  Created by Kateryna Pavlova on 08/10/2026.
//

import SwiftUI

struct ValueSelectView: View {
    let values: [Value]
    @Binding var selectedValues: [Value]

    var body: some View {
        List(values, id: \.id) { value in
            Button {
                toggle(value)
            } label: {
                HStack {
                    Text(value.name)

                    Spacer()

                    if selectedValues.contains(where: { $0.id == value.id }) {
                        Image(systemName: "checkmark")
                            .foregroundStyle(.tint)
                    }
                }
            }
            .foregroundStyle(.primary)
        }
        .navigationTitle("Values")
    }

    private func toggle(_ value: Value) {
        if let index = selectedValues.firstIndex(where: { $0.id == value.id }) {
            selectedValues.remove(at: index)
        } else {
            selectedValues.append(value)
        }
    }
}

//#Preview {
//    ValueSelectView()
//}

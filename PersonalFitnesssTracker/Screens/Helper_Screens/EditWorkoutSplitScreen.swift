//
//  EditWorkoutSplitScreen.swift
//  PersonalFitnesssTracker
//
//  Created by Uddeshya Singh on 17/11/25.
//

import SwiftUI

struct EditWorkoutSplitScreen: View {
    var body: some View {
        CustomSheetView<VStack, HStack>(
            heading: "Edit Split",
            content: {
                VStack {
                    
                }
            }, secondaryContent: {
                HStack {
                    Button(action: {
                    }) {
                        Image(systemName: "checkmark")
                            .frame(width: 30, height: 30)
                    }
                    .tint(.appPrimary)
                    .buttonStyle(.glassProminent)
                }
            }
        )
        .presentationDetents([.large])
    }
}

#Preview {
    EditWorkoutSplitScreen()
}

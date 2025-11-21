import SwiftUI

struct ExerciseRepsSetsEditScreen: View {
    
    
    var body: some View {
        ScrollView(showsIndicators: false) {
            VStack(spacing: -20) {
                Image(systemName: "figure.cooldown")
                    .resizable()
                    .frame(width: 50, height: 60)
                ContentUnavailableView("No Sets Added Yet!", image: "", description: Text("Add Sets and Reps for the exercise to be noted."))
            }
            .padding(.top, 40)
            .opacity(0.75)
        }
        .padding(.horizontal, ApplicationMarginPadding.current.scrollViewHorizontalMargin)
        .toolbar {
            
            ToolbarItem(placement: .topBarLeading) {
                Button(action: {}) {
                    Image(systemName: "xmark")
                        .scaleEffect(0.9)
                }
            }
            ToolbarItem(placement: .principal) {
                Text("Journal".uppercased())
                    .antonFont(with: 25)
            }
            
            ToolbarItem(placement: .topBarTrailing) {
                Button(action: {}) {
                    Image(systemName: "plus")
                        .scaleEffect(0.9)
                }
            }
            
            ToolbarItem(placement: .topBarTrailing){
                Button(action: {}) {
                    Image(systemName: "checkmark")
                        .scaleEffect(0.9)
                }
                .tint(.appPrimary)
                .buttonStyle(.glassProminent)
            }
            
            
            
            ToolbarItem(placement: .bottomBar) {
                HStack {
                    Button(action: {}) {
                        Text("Complete Exercise")
                            .foregroundStyle(.white)
                    }
                }
                .frame(maxWidth: .infinity)
            }
        }
    }
}

#Preview {
    ExerciseRepsSetsEditScreen()
}

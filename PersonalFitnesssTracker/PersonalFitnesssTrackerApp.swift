//
//  PersonalFitnesssTrackerApp.swift
//  PersonalFitnesssTracker
//
//  Created by Uddeshya Singh on 07/10/25.
//

import SwiftUI
import SwiftData


struct ApplicationOption {
    var id: String = UUID().uuidString
    var name: String
    var backgroundColor: Color
    var icon: String
    var view: AnyView
    
    static var allCases: Array<ApplicationOption> {
        return [
            .init(name: "Fitness And Diet", backgroundColor: .appPrimary, icon: "workout", view: AnyView(ContentView())),
            .init(name: "Productivity", backgroundColor: .appDark, icon: "workout", view: AnyView(EmptyView())),
            .init(name: "Consistancy", backgroundColor: .appBlue, icon: "workout", view: AnyView(EmptyView())),
        ]
    }
}

@main
struct PersonalFitnesssTrackerApp: App {
    @State var applicationWorkoutStates: ApplicationWorkoutStates = .init()
    @State var applicationHealthManager: ApplicationHealthKitManager = .init()
    @State var applicationKeyboardObserver: KeyboardOvserver = .init()
    @State var applicationToast: ApplicationToast = .init()
    @State var applicationBottomModal: ApplicationBottomModal = .init()
    
    
    @State var showSelectedApplicationOption: Bool = false
    
    var body: some Scene {
        WindowGroup {
            
            ZStack {
                GeometryReader { geometryProxy in
                    
                    let scrollViewSize: CGSize = geometryProxy.size
                    
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing: 0) {
                            ForEach(ApplicationOption.allCases, id: \.id) { option in
                                ApplicationOptionScrollItem(configuration: option, scrollViewSize: scrollViewSize, showSelectedApplicationOption: self.$showSelectedApplicationOption)
                            }
                        }
                        .fullScreenHeightWidth()
                    }
                    .scrollTargetBehavior(.paging)
                    .fullScreenHeightWidth()
                    .background(LinearGradient(colors: [.appDark, .black], startPoint: .top, endPoint: .init(x: 0.5, y: 1.5)))
                }
                
               
                VStack {
                    ApplicationOption.allCases.first?.view
                        .transition(.opacity)
                        .animation(.default.delay(1), value: self.showSelectedApplicationOption)
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .background(.appPrimary)
                .offset(y: self.showSelectedApplicationOption ? 0 : UIScreen.main.bounds.height)
                .zIndex(10)

            }
            .fullScreenHeightWidth()
            
            
            
//            ContentView()
//            // MARK: Custom Toast Overlay
//                .overlay(alignment: .leading) {
//                    CustomToastOverlay()
//                }
//            // MARK: Custom Bottom Modal
//                .overlay {
//                    CustomBottomModal()
//                }
        }
        .environment(self.applicationWorkoutStates)
        .environment(self.applicationHealthManager)
        .environment(self.applicationKeyboardObserver)
        .environment(self.applicationToast)
        .environment(self.applicationBottomModal)
    }
}


struct ApplicationOptionScrollItem: View {
    
    var configuration: ApplicationOption
    var scrollViewSize: CGSize
    @Binding var showSelectedApplicationOption: Bool
    
    
    @State var cardTranslation: CGSize = .zero
    @State var vibrationState: Int = .zero
   
    
    func dragGestureOnChange(_ dragValue: DragGesture.Value) -> Void {
        if dragValue.translation.height > 0 {
            self.cardTranslation.height = dragValue.translation.height
        }
    }
    
    func dragGestureOnEnd(_ dragValue: DragGesture.Value) -> Void {
        if dragValue.translation.height > 100 {
            withAnimation {
                self.cardTranslation.height = 1000
            }
            
            withAnimation(.default.delay(0.25)) {
                self.showSelectedApplicationOption = true
            }
        } else {
            withAnimation {
                self.cardTranslation.height = .zero
            }
        }
    }
    
    var body: some View {
        VStack {
            Text(self.configuration.name.uppercased())
                .antonFont(with: 25)
                .offset(y: -self.cardTranslation.height / 2)
            
            
            RoundedRectangle(cornerRadius: 20.0)
                .fill(self.configuration.backgroundColor)
                .offset(y: self.cardTranslation.height)
                .gesture(
                    DragGesture()
                        .onChanged { dragValue in
                            self.dragGestureOnChange(dragValue)
                        }
                        .onEnded { dragValue in
                            self.dragGestureOnEnd(dragValue)
                        }
                )
                .frame(width: scrollViewSize.width * 0.7, height: scrollViewSize.height * 0.7)
        }
        .frame(maxHeight: .infinity)
        .frame(width: scrollViewSize.width)
        .sensoryFeedback(.impact, trigger: self.vibrationState)
        
    }
}

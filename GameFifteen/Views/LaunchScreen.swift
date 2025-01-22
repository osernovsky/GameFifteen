//
//  LaunchScreen.swift
//  GameFifteen
//
//  Created by Sergey Dubrovin on 21.01.2025.
//

import SwiftUI

struct LaunchScreenView: View {

    @State var isFirstLaunch: Bool = true
    @State private var size = 0.8
    @State private var opacity = 0.0

    var body: some View {
        if !isFirstLaunch {
            ContentView()
        } else {
            ZStack {
                Color(.white)
                    .ignoresSafeArea()
                VStack {
                    Image("osCodeLogo")
                        .resizable()
                        .frame(width: 150, height: 150)
                        .scaleEffect(size)
                }
                .opacity(opacity)
                .onAppear {
                    withAnimation(.easeInOut(duration: 1.5)) {
                        self.size = 1.2
                        self.opacity = 1.0
                    }
                    DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                        withAnimation {
//                            Records.shared.deleteRecord()
                            Records.shared.loadRecord()
                            self.isFirstLaunch = false
                        }
                    }
                }
            }
        }
    }
}

#Preview {
    LaunchScreenView()
}

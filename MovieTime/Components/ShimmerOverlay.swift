//
//  ShimmerOverlay.swift
//  TheMovieDB
//
//  Created by Kelian Daste on 21/01/2024.
//

import SwiftUI


struct ShimmerOverlay: View {
    @ObservedObject var motionManager: MotionManager
    let width: CGFloat
    let height: CGFloat
    
    var body: some View {
        RoundedRectangle(cornerRadius: 16)
        
            .strokeBorder(
                
                AngularGradient(
                    gradient: Gradient(colors: [.clear, .clear, .white, .clear, .clear]),
                    center: .center,
                    angle: .degrees(135 + motionManager.shimmerProgressX + motionManager.shimmerProgressY)
                ), lineWidth: 2
            )
            .frame(width: width, height: height)
            .overlay{
                LinearGradient(
                    gradient: Gradient(colors: [ .clear,
                                                 .white.opacity(0.86),
                                                 .clear,
                                                 .white.opacity(0.86),
                                                 .white.opacity(0.46),
                                                 .clear
                    ]),
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                )
                .frame(width: width*4, height: height*4)
                .continuousCorner(16)
                .offset(x: min(((motionManager.shimmerProgressY/2 + 30) / 60) * (width + width) - width, width*2 ),
                        y: min(((motionManager.shimmerProgressX/2 + 30) / 60) * (height + height) - height, height*2 ))
            }
            .mask{
                Rectangle()
                    .frame(width: width, height: height)
                    .continuousCorner(16)
            }
            //.opacity(motionManager.shimmerProgress)
        
        
        //        .animation(.easeInOut(duration: 0.1), value: motionManager.shimmerProgress)
    }
}





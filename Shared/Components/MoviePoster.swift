//
//  ShimmerOverlay.swift
//  TheMovieDB
//
//  Created by Kelian Daste on 21/01/2024.
//

import SwiftUI
import NukeUI

struct MoviePoster: View {
    @StateObject var motionManager = MotionManager()
    
    let movie: Movie
    let shimmer = false
    
    var posterWidth: CGFloat = 250
    var posterHeight: CGFloat = 375
    
    var body: some View {
        LazyImage(url: movie.highResolutionPoster) { state in
            if let image = state.image {
                ZStack{
                    image
                        .resizable()
                        .scaledToFill()
                        .frame(width: posterWidth + 20, height: posterHeight + 20)
                        .continuousCorner(16)
                        .blur(radius: 40)
                    if shimmer{
                        image
                            .resizable()
                            .scaledToFill()
                            .frame(width: posterWidth, height: posterHeight)
                            .continuousCorner(16)
                        #if !os(visionOS)
                            .overlay(
                                ShimmerOverlay(motionManager: motionManager,
                                               width: posterWidth,
                                               height: posterHeight)
                            )
                            .rotation3DEffect(
                                .degrees(motionManager.xAxis),
                                axis: (x: 1.0, y: 0.0, z: 0.0)
                            )
                            .rotation3DEffect(
                                .degrees(-motionManager.yAxis),
                                axis: (x: 0.0, y: 1.0, z: 0.0)
                            )
                            .onAppear {
                                motionManager.startMonitoringMotionUpdates()
                            }
                            .onDisappear{
                                motionManager.stopMonitoringMotionUpdates()
                            }
                        #endif
                    } else {
                        image
                            .resizable()
                            .scaledToFill()
                            .frame(width: posterWidth, height: posterHeight)
                            .continuousCorner(16)
//                            .frame(depth: 30)
                    }
                }
            } else {
                RoundedRectangle(cornerRadius: 16)
                    .fill(.black)
                    .frame(width: posterWidth + 20, height: posterHeight + 20)
            }
        }
        .overlay(alignment: .topTrailing) {
            Text("\(movie.vote, specifier: "%.1f")")
                .font(.system(size: 16, weight: .semibold))
                .frame(width: 50, height: 50)
                .background{
                    Circle()
                        .fill(.ultraThinMaterial)
                }
        }
    }
}

#Preview {
    MoviePoster(movie: Movie.sample )
}

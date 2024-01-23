//
//  FullscreenYoutubeView.swift
//  TheMovieDB
//
//  Created by Kelian Daste on 22/01/2024.
//

import SwiftUI
import YouTubePlayerKit
import Combine

struct FullscreenYoutubeView: View {
    @EnvironmentObject private var ytM: YoutubeManager
    @State private var currentTime: Double = 0.0
    @State private var duration: Double = 0.0
    
    @StateObject private var player: YouTubePlayer = .init(
        source: .video(id: ""),
        configuration: YouTubePlayer.Configuration(
            fullscreenMode: .system,
            autoPlay: true)
    )
    @State private var cancellables: Set<AnyCancellable> = []
    
    var body: some View {
        GeometryReader{ proxy in
            YouTubePlayerView(player)
                .frame(width: proxy.size.width, height: proxy.size.height)
                .continuousCorner(32)
                .frame(depth: 10)
                .ornament(attachmentAnchor: .scene(.bottom)) {
                        HStack(spacing: 8){
                            HStack(spacing: 2){
                                Text("\(currentTime.formatTime)")
                                    .frame(width: 45)
                                Text("/")
                                Text("\(duration.formatTime)")
                                    .frame(width: 45)
                            }
                            .font(.caption2)
                            .frame(width: 100)
                            .frame(depth: 10)
                            
                            Button{
                                player.seek(to: currentTime - 10, allowSeekAhead: true)
                            } label: {
                                ZStack {
                                    Image(systemName: "arrow.circlepath")
                                        .rotationEffect(.degrees(90))
                                    Text("10")
                                        .font(.system(size: 10, weight: .medium))
                                        .offset(x: 0.5,y:1)
                                }
                                .frame(width: 44, height: 44)
                            }
                            .buttonStyle(.plain)
                            .frame(depth: 20)
                            
                            Button{
                                if player.isPaused {
                                    player.play()
                                } else {
                                    player.pause()
                                }
                            } label: {
                                Image(systemName: player.isPaused ? "play.fill":  "pause.fill")
                                    .frame(width: 44, height: 44)
                            }
                            .buttonStyle(.plain)
                            .frame(depth: 25)
                            
                            Button{
                                player.seek(to: currentTime + 10, allowSeekAhead: true)
                            } label: {
                                ZStack {
                                    Image(systemName: "arrow.circlepath")
                                        .rotationEffect(.degrees(90))
                                        .scaleEffect(x: -1, y: 1)
                                    Text("10")
                                        .font(.system(size: 10, weight: .medium))
                                        .offset(x: 0.5,y:1)
                                }
                                .frame(width: 44, height: 44)
                                
                            }
                            .buttonStyle(.plain)
                            .frame(depth: 20)
                            
                            Button{
                                player.seek(to: currentTime + 10, allowSeekAhead: true)
                            } label: {
                                ZStack {
                                    Image(systemName: "square.and.arrow.up")
                                }
                                .frame(width: 44, height: 44)
                                
                            }
                            .buttonStyle(.plain)
                            .frame(depth: 10)
                            
                    }
                    .padding(.vertical, 8)
                    .padding(.horizontal, 32)
                    .glassBackgroundEffect()
                    .background{
                        if duration > 0 {
                            ProgressView(value: currentTime, total: duration)
                                .tint(.red)
                        }
                    }
                }
        }
        .padding(16)
        .onAppear {
            if let video = ytM.selectedVideo {
                player.source = .video(id: video.key)
                getTimeAndDuration()
            }
        }
    }
    
    func getTimeAndDuration(){
        player.durationPublisher
            .sink { duration in
                self.duration = duration
                player.hideStatsForNerds()
            }
            .store(in: &cancellables)
        player.currentTimePublisher()
            .sink { currentTime in
                withAnimation {
                    self.currentTime = currentTime
                }
            }
            .store(in: &cancellables)
    }
}

#Preview {
    FullscreenYoutubeView()
        .environmentObject(YoutubeManager())
}

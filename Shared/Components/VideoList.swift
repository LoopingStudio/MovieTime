//
//  VideoList.swift
//  TheMovieDB
//
//  Created by Kelian Daste on 22/01/2024.
//

import SwiftUI
import YouTubePlayerKit

struct VideoList: View {
    @Environment(\.openWindow) private var openWindow
    @Environment(\.dismissWindow) private var dismissWindow
    @EnvironmentObject var youtubeManager: YoutubeManager
    let videos: [MovieVideo]
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(alignment: .top ,spacing: 16){
                ForEach(videos.reversed()) { video in
                    VStack{
                        Button {
                            dismissWindow(id: "YoutubePlayer")
                            youtubeManager.selectedVideo = video
                            openWindow(id: "YoutubePlayer")
                        } label: {
                            
                                AsyncImage(url: URL(string: "https://img.youtube.com/vi/\(video.key)/mqdefault.jpg")){ image in
                                    image
                                        .resizable()
                                        .scaledToFill()
                                        .frame(width: 320, height: 180)
                                        .continuousCorner(8)
                                } placeholder: {
                                    Rectangle()
                                        .frame(width: 320, height: 180)
                                        .continuousCorner(8)
                                }
                                .contentShape(.hoverEffect, RoundedRectangle(cornerRadius: 8))
                                .hoverEffect(.automatic)
                                .frame(depth: 30)
                        }
                            Text(video.name)
                                    .frame(depth: 20)
                        
                    }
                        .buttonStyle(.plain)
                    .frame(width: 320)
                }
            }
        }
    }
}

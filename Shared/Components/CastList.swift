//
//  CastList.swift
//  TheMovieDB
//
//  Created by Kelian Daste on 21/01/2024.
//

import SwiftUI

struct CastList: View {
    var cast: [CastMember]
    var padding: CGFloat = 16
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack{
                ForEach(cast.isEmpty ? CastMember.samples : cast){ member in
                    VStack{
                        if cast.isEmpty {
                            Circle()
                                .fill(.gray)
                                .frame(width: 80, height: 80)
                        } else {
                            NavigationLink{
                                PersonDetailView(person: member.toPerson)
                            } label: {
                                AsyncImage(url: member.fullPictureURL) { image in
                                    image
                                        .resizable()
                                        .scaledToFill()
                                        .frame(width: 80, height: 80)
                                        .clipShape(Circle())
                                } placeholder: {
                                    Circle()
                                        .fill(.gray)
                                        .frame(width: 80, height: 80)
                                }
                                .contentShape(.hoverEffect, Circle())
                                .hoverEffect(.automatic)
                            }
                            .frame(depth: 25)
                            .buttonStyle(.plain)

                        }
                        
                        Text(member.name)
                            .foregroundStyle(.primary)
                            .font(.system(size: 10, weight: .medium))
                            .lineLimit(2)
                            .frame(depth: 16)
                        if let character = member.character, !character.removeWord("Self").isEmpty{
                            Text(character)
                                .foregroundStyle(.white.opacity(0.9))
                                .font(.system(size: 10))
                                .lineLimit(2)
                                .frame(depth: 10)
                        }
                    }
                    .frame(width: 100)
                    .redacted(cast.isEmpty)
                }
            }
            .padding(.horizontal, 16)
        }
        .padding(.horizontal, -16)
    }
}

#Preview {
    CastList(cast: CastMember.samples)
}

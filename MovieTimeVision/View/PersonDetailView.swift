//
//  MovieDetailView.swift
//  TheMovieDB
//
//  Created by Kelian Daste on 15/01/2024.
//

import SwiftUI
import NukeUI

struct PersonDetailView: View {
    @EnvironmentObject var apiManager: ApiManager
    
    var person: Person
    @State private var details: PersonDetail?
    @State private var castCredits: [Movie] = []
    
    var sortedCredits: [Movie] {
        return castCredits.sorted(by: { $0.vote > $1.vote })
    }
    
    var body: some View {
        ScrollView(showsIndicators: false) {
            VStack {
                HStack(alignment: .top){
                    VStack {
                        AsyncImage(url: person.fullPictureURL) { image in
                            image
                                .resizable()
                                .scaledToFill()
                                .frame(width: 200, height: 300)
                                .continuousCorner(16)
                        } placeholder: {
                            RoundedRectangle(cornerRadius: 16)
                                .frame(width: 200, height: 300)
                        }
                            
                        HStack {
                            Text(details?.birthDay.dateToDate ?? .placeholder(length: 10))
                            
                            Text(details?.deathDay?.dateToDate ?? .placeholder(length: 10))
                                
                        }
                        .redacted(details == nil)
                        .foregroundColor(.secondary)
                    }
                    if details == nil || !details!.biography.isEmpty{
                        VStack(spacing: 32){
                            VStack(alignment: .leading){
                                Text("Synopsis")
                                    .bold()
                                Text(details?.biography ?? .placeholder(length: 250))
                                    .redacted(details == nil)
                            }
                            .frame(maxWidth: .infinity, alignment: .leading)
                            
                        }
                        .frame(maxWidth: 600)
                        .padding(.horizontal, 16)
                    }
                    Spacer()
                }
                VStack{
                    HStack {
                        Text("Rôles")
                            .font(.system(size: 20, weight: .bold))
                            .frame(depth: 10)
                        Spacer()
                    }
                    LazyVGrid(columns: [GridItem(.adaptive(minimum: 160))]){
                        ForEach(sortedCredits){ movie in
                            MovieLittlePoster(movie: movie)
                            .padding(.vertical, 60)
                        }
                        .padding(.vertical, -60)
                    }
                    
                }
            }
            .padding([.horizontal, .bottom], 32)
            .frame(maxWidth: .infinity)
            .navigationTitle(person.name)
            .ornament(attachmentAnchor: .scene(.topTrailing)) {
                HStack(spacing: 16){
                    
                    Button(action: {
                        //TODO:- favorite
                    }) {
                        Image(systemName: "star")
                            .foregroundColor(.primary)
                            .frame(width: 44, height: 44)
                        }
                    .buttonStyle(.plain)
                    Button(action: {
                        //TODO:- Share
                    }) {
                        Image(systemName: "square.and.arrow.up")
                        .foregroundColor(.primary)
                        .frame(width: 44, height: 44)
                    }
                    .buttonStyle(.plain)
                    
                }
                .padding(16)
                .glassBackgroundEffect()
                .frame(depth: 35)
                .padding(.trailing, 300)
            }
            
        }
        .task {
            do {
                async let details: PersonDetail = try apiManager.fetchDetails(of: person)
                async let castCredits: [Movie] = try apiManager.fetchCredits(of: person)

                    // Attendre l'achèvement de toutes les tâches
                    self.details = try await details
                    self.castCredits = try await castCredits
            } catch {
                print(error.localizedDescription)
            }
        }
    }
}

#Preview {
    NavigationStack{
        PersonDetailView(person: Person.sample)
    }
    .preferredColorScheme(.dark)
    .environmentObject(ApiManager())
    .environmentObject(WatchListManager())
}



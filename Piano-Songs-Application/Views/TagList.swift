//
//  TagList.swift
//  Piano Songs
//
//  Created by Arthur VELLA on 20/01/2021.
//

import SwiftUI

struct TagList: View {
    @ObservedObject var SongVM:SongViewModel
    @Environment(\.managedObjectContext) var context
    
    
    var body: some View {
        NavigationView {
            List {
                ForEach(0 ..< SongVM.allTags.count) { value in
                    NavigationLink(destination: SongsFromTag(tagName: SongVM.allTags[value], SongVM: SongVM)) {
                        Text(SongVM.allTags[value])
                    
                    }

                }
            }
            .listStyle(InsetGroupedListStyle())
            .navigationBarTitle("Categories")
        }.onAppear(perform: {
            self.SongVM.updateAllTags(context: context)
        })
    }
}

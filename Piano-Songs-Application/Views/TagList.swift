//
//  TagList.swift
//  Piano Songs
//
//  Created by Arthur VELLA on 20/01/2021.
//

import SwiftUI

struct TagList: View {
    @ObservedObject var SongVM:SongViewModel
    @ObservedObject var TagVM:TagViewModel
    @Environment(\.managedObjectContext) var context
    
    @FetchRequest(entity: Tag.entity(),
                  sortDescriptors: [])
    var tags: FetchedResults<Tag>
    var body: some View {
        NavigationView {
            VStack {
                List {
                    
                    ForEach(tags) { (tag: Tag) in
                        NavigationLink(destination: SongsFromTag(tagName: tag.name!, SongVM: SongVM)) {
                            Text(tag.name!)
                        }
                    }.onDelete(perform: { indexSet in
                        self.TagVM.deleteTag(tag: tags[indexSet.first!], context: context)
                    })
                    Button(action: {
                        TagVM.sheetOn.toggle()
                    }) {
                        HStack {
                            Image(systemName: "plus.circle")
                            Text("Add new tag")
                        }
                        
                    }
                }
                
               
            }
            
            
            .listStyle(InsetGroupedListStyle())
            .navigationBarTitle("Categories")
            .sheet(isPresented: self.$TagVM.sheetOn) {
                NewTagView(TagVM: TagVM, SongVM: SongVM)
            }
        }.onAppear(perform: {
            self.SongVM.updateAllTags(context: context)
        })
    }
}

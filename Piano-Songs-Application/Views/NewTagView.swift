//
//  NewTagView.swift
//  Piano-Songs-Application
//
//  Created by Arthur VELLA on 14/04/2021.
//

import SwiftUI

struct NewTagView: View {
    @ObservedObject var TagVM: TagViewModel
    @ObservedObject var SongVM: SongViewModel
    @Environment(\.managedObjectContext) var context
    
    func cantAdd() -> Bool {
        return TagVM.name == ""
    }
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Tag Name")) {
                    TextField(
                    "Tag Name",
                        text: $TagVM.name)
                    .disableAutocorrection(true)
                }
                
                
                Button(action: {
                    TagVM.addTag(context: context)
                    TagVM.name = ""
                    SongVM.updateAllTags(context: context)
                }) {
                    Text("Add new tag").frame(maxWidth: .infinity, alignment: .center)
                }.disabled(cantAdd())
                
            }.navigationBarTitle("New Tag")
        }
    }
}


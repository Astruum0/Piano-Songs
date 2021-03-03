//
//  TagList.swift
//  Piano Songs
//
//  Created by Arthur VELLA on 20/01/2021.
//

import SwiftUI

struct TagList: View {
    
    var body: some View {
        NavigationView {
            List {
//                ForEach(0 ..< userData.allTags.count) { value in
//                    NavigationLink(destination: SongsFromTag(tag: userData.allTags[value])) {
//                        Text(userData.allTags[value])
//                    
//                    }
//
//                }
            }
            .listStyle(InsetGroupedListStyle())
            .navigationBarTitle("Categories")
        }
    }
}

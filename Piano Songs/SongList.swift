//
//  SongList.swift
//  Piano Songs
//
//  Created by Arthur VELLA on 24/10/2020.
//

import SwiftUI

struct SongList: View {
    @EnvironmentObject var userData: UserData
    
    var body: some View {
        NavigationView {
            List {
                Toggle(isOn: $userData.showLearnedOnly) {
                    Text("Show learned songs only")
                }
                
                ForEach(userData.allSongs) { song in
                    if (!self.userData.showLearnedOnly || song.learned) {
                        NavigationLink(destination: SongDetail(song: song)) {
                            SongRow(song: song)
                        }
                    }
                    
                }
            }
            .navigationBarTitle(Text("Piano Songs 🎹"))
            
        }
        
    }
}

struct SongList_Previews: PreviewProvider {
    static var previews: some View {
        SongList().environmentObject(UserData())
    }
}

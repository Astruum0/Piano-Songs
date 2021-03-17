//
//  TagViewModel.swift
//  Piano-Songs-Application
//
//  Created by Arthur VELLA on 03/03/2021.
//

import Foundation
import CoreData

class TagViewModel: ObservableObject {
    @Published var name: String = ""
    
    func addDefaultTag(context: NSManagedObjectContext) -> Void {
//        let pop = Tag(context: context)
//        pop.name = "Pop"
//
//        let film = Tag(context: context)
//        film.name = "Film"
//
//        let sad = Tag(context: context)
//        sad.name = "Sad"
        
        let rap = Tag(context: context)
        rap.name = "Rap"
        
        do {
            try context.save()
        } catch {
            print(error.localizedDescription)
        }
    }
    
    
}


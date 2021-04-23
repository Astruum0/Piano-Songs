//
//  DoubleExtension.swift
//  Piano Songs
//
//  Created by Arthur VELLA on 23/10/2020.
//

extension Double {
    var clean: String {
       return self.truncatingRemainder(dividingBy: 1) == 0 ? String(format: "%.0f", self) : String(self)
    }
}


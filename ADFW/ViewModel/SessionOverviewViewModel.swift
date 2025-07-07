//
//  SessionOverviewViewModel.swift
//  ADFW
//
//  Created by MultiTV on 07/07/25.
//

import Foundation


class SessionOverviewViewModel: ObservableObject {
    @Published var isFavourite: Bool
    
    init(isFavourite: Bool) {
        self.isFavourite = isFavourite
    }
}

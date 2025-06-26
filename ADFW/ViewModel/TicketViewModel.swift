//
//  TicketViewModel.swift
//  ADFW
//
//  Created by MultiTV on 24/06/25.
//

import Foundation
import UIKit


class TicketViewModel: ObservableObject {
    @Published var ticketDays: [TicketBenefitData] = []

    func load(ticketNumber: String, in view: UIView) {
        TicketBenefitViewModel().fetchTicketBenefits(ticketNumber: ticketNumber, in: view) { result in
            switch result {
            case .success(let days):
                DispatchQueue.main.async {
                    self.ticketDays = days
                }
            case .failure(let error):
                print("❌", error.localizedDescription)
            }
        }
    }
}

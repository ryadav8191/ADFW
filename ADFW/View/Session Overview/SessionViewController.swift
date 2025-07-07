//
//  SessionViewController.swift
//  ADFW
//
//  Created by MultiTV on 21/05/25.
//

import UIKit
import SwiftUI

class SessionViewController: UIViewController {
    
    var session: Session?
    let viewModel = FavouriteViewModel()
    let favViewModel = EventAgandaViewModel()
    var aganaSession: FavSessionData?
    var sessionOverviewVM: SessionOverviewViewModel?
    var hostingController: UIHostingController<SessionOverviewView>?

    override func viewDidLoad() {
        super.viewDidLoad()
        fetchSessionDetails()
    }

    private func fetchSessionDetails() {
        guard let sessionId = session?.id else { return }
        let ticketId = LocalDataManager.getUserId()
        
        favViewModel.fetchAgendaSessionDetail(sessionId: sessionId, ticketId: ticketId, in: view) { [weak self] result in
            guard let self = self else { return }

            switch result {
            case .success(let fetchedSession):
                self.aganaSession = fetchedSession
                self.loadOrUpdateSwiftUIView()
            case .failure(let error):
                MessageHelper.showBanner(message: error.localizedDescription, status: .error)
            }
        }
    }

    private func loadOrUpdateSwiftUIView() {
        let isFav = aganaSession?.isFavourite ?? false

        if let viewModel = sessionOverviewVM {
            // ✅ Just update the value
            viewModel.isFavourite = isFav
        } else {
            // First time setup
            let viewModel = SessionOverviewViewModel(isFavourite: isFav)
            self.sessionOverviewVM = viewModel

            let swiftUIView = SessionOverviewView(
                viewModel: viewModel,
                session: session,
                onBack: { [weak self] in
                    self?.navigationController?.popViewController(animated: true)
                },
                addFavourite: { [weak self] in
                    guard let self = self else { return }
                    self.viewModel.addToFavourites(
                        ticketId: LocalDataManager.getUserId(),
                        sessionId: self.session?.id ?? 0,
                        agendaId: self.session?.agandaId ?? 0,
                        agendaDate: self.session?.date ?? "",
                        in: self.view
                    ) { result in
                        switch result {
                        case .success(let message):
                            MessageHelper.showBanner(message: message, status: .success)
                            self.fetchSessionDetails() // Will just update isFavourite
                        case .failure(let error):
                            MessageHelper.showBanner(message: error.localizedDescription, status: .error)
                        }
                    }
                },
                removeFavourite: { [weak self] in
                    guard let self = self else { return }
                    self.favViewModel.removeFromFavourites(
                        ticketId: LocalDataManager.getUserId(),
                        sessionId: self.session?.id ?? 0,
                        in: self.view
                    ) { result in
                        switch result {
                        case .success(let message):
                            MessageHelper.showBanner(message: message, status: .success)
                            self.fetchSessionDetails() // Will just update isFavourite
                        case .failure(let error):
                            MessageHelper.showBanner(message: error.localizedDescription, status: .error)
                        }
                    }
                }
            )

            let hostingController = UIHostingController(rootView: swiftUIView)
            self.hostingController = hostingController

            addChild(hostingController)
            view.addSubview(hostingController.view)
            hostingController.didMove(toParent: self)

            hostingController.view.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                hostingController.view.topAnchor.constraint(equalTo: view.topAnchor),
                hostingController.view.bottomAnchor.constraint(equalTo: view.bottomAnchor),
                hostingController.view.leadingAnchor.constraint(equalTo: view.leadingAnchor),
                hostingController.view.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            ])
        }
    }
}

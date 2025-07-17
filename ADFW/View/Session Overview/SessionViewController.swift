//
//  SessionViewController.swift
//  ADFW
//
//  Created by MultiTV on 21/05/25.
//

import UIKit
import SwiftUI
import EzPopup

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
            viewModel.isFavourite = isFav
        } else {
            // First time setup
            let viewModel = SessionOverviewViewModel(isFavourite: isFav)
            self.sessionOverviewVM = viewModel

            let swiftUIView = SessionOverviewView(
                viewModel: viewModel,
                session: Session(
                    id: aganaSession?.id ?? 0,
                    agandaId: aganaSession?.agenda?.id ?? 0,
                    date: Helper.formatISODateToDayFullMonth(aganaSession?.agenda?.date ?? "") ?? "",
                    year: Helper.extractYearFromISODate(aganaSession?.agenda?.date ?? "") ?? "",
                    title: aganaSession?.title ?? "",
                    description: aganaSession?.description ?? "",
                    time: (aganaSession?.fromTime ?? "") + "-" + (aganaSession?.toTime ?? ""),
                    location: aganaSession?.agenda?.location?.name ?? "",
                    bannerImage: aganaSession?.agenda?.agendaMobileBanner ?? "",
                    speakers: (aganaSession?.speakers ?? []).map { Speaker(from: $0) } ,
                    moderators: aganaSession?.moderator != nil ? Speaker(from: aganaSession?.moderator) : nil
                ),
                onBack: { [weak self] in
                    self?.navigationController?.popViewController(animated: true)
                },
                addFavourite: { [weak self] in
                    guard let self = self else { return }
                    self.viewModel.addToFavourites(
                        ticketId: LocalDataManager.getUserId(),
                        sessionId: self.aganaSession?.id ?? 0,
                        agendaId: self.aganaSession?.agenda?.id ?? 0,
                        agendaDate: self.aganaSession?.agenda?.date ?? "",
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
                        sessionId: self.aganaSession?.id ?? 0,
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
                }, onSpeakerTap: { selectedSpeaker in
                    let fullName = selectedSpeaker.name

                    // Try to match from speakers
                    if let matchedSpeaker = self.aganaSession?.speakers?.first(where: {
                        fullName.contains($0.firstName ?? "")
                    }) {
                        self.presentSpeakerDetail(matchedSpeaker)
                    }
                    // Else, try to match from moderator
                    else if let moderator = self.aganaSession?.moderator,
                            (moderator.firstName ?? "") + " " + (moderator.lastName ?? "") == fullName {
                        self.presentSpeakerDetail(moderator)
                    }
                    else {
                        print("Speaker not found in session or moderator list")
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
    
    func presentSpeakerDetail(_ speaker: EventAgandaSpeakers) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(identifier: "SpeackerDetailViewController") as! SpeackerDetailViewController
        vc.sessionProfile = speaker

        let popupVC = PopupViewController(
            contentController: vc,
            popupWidth: self.view.frame.width - 32,
            popupHeight: 350
        )
        self.present(popupVC, animated: true)
    }

}

//
//  NotificationViewModel.swift
//  ADFW
//
//  Created by MultiTV on 25/06/25.
//

import Foundation
import UIKit





class NotificationViewModel: ObservableObject {
    @Published var notifications: [NotificationData] = []
    @Published var errorMessage: String?
    @Published var isLoading = false

    private var currentPage = 1
    private let pageSize = 20
    private var hasMoreData = true

    func resetAndFetch(in view: UIView) {
        currentPage = 1
        hasMoreData = true
        notifications.removeAll()
        fetchNotification(in: view)
    }

    func fetchNotification(in view: UIView) {
        guard !isLoading, hasMoreData else { return }

        isLoading = true
        let urlString = "https://adfw.multitvsolution.com/api/notification/all?page=\(currentPage)&pageSize=\(pageSize)"

        NetworkManager.shared.fetchData(from: urlString, in: view) { (result: Result<NotificationModel, Error>) in
            DispatchQueue.main.async {
                self.isLoading = false

                switch result {
                case .success(let response):
                    if response.status ?? false, let newData = response.data?.data {
                        self.notifications.append(contentsOf: newData)
                        self.currentPage += 1
                        if newData.count < self.pageSize {
                            self.hasMoreData = false
                        }
                    } else {
                        self.errorMessage = response.message ?? "Something went wrong"
                    }
                case .failure(let error):
                    self.errorMessage = error.localizedDescription
                }
            }
        }
    }

    func loadMoreIfNeeded(currentItem item: NotificationData, in view: UIView) {
        guard let last = notifications.last else { return }
        if item.id == last.id {
            fetchNotification(in: view)
        }
    }
}

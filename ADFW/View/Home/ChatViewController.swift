//
//  ChatViewController.swift
//  ADFW
//
//  Created by MultiTV on 16/05/25.
//

import UIKit
import SendbirdChatSDK

struct ChatUser {
    let user: SendbirdChatSDK.User
    var unreadCount: Int
    var isPinned: Bool
    var lastMessage: String?
    var lastMessageTimestamp: Int64?
}


class ChatViewController: UIViewController {
    
    
    @IBOutlet weak var pageLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var navigationView: UIView!
    @IBOutlet weak var profileImageView: UIImageView!
    
    
    var userListQuery: ApplicationUserListQuery?
    var users: [ChatUser] = []
    var pinnedUserIds: Set<String> = []

    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.isHidden = true
        configureUI()
        ChatPinManager.load()
       
       
    }
    
    override func viewWillAppear(_ animated: Bool) {
        SendbirdChat.connect(userId: "\(LocalDataManager.getUserId())") { user, error in
                if let error = error {
                    print("Connection error:", error)
                    return
                }
                self.loadAllUsers()
            }
    }
    
    func configureUI() {
        
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.register(UINib(nibName: "ChatTableViewCell", bundle: nil), forCellReuseIdentifier: "ChatTableViewCell")
        
        profileImageView.layer.cornerRadius = profileImageView.frame.width / 2
        
        if let urlString = LocalDataManager.getLoginResponse()?.photo, let url = URL(string: urlString) {
            profileImageView.kf.setImage(
                with: url,
                placeholder: UIImage(named: "profile"), // Placeholder while loading
                options: [.transition(.fade(0.2))]      // Optional: smooth fade transition
            ) { result in
                switch result {
                case .success:
                    break // Image loaded successfully
                case .failure:
                    self.profileImageView.image = UIImage(named: "profile") // Fallback on error
                }
            }
        } else {
            profileImageView.image = UIImage(named: "profile")
        }


        pageLabel.font = FontManager.font(weight: .semiBold, size: 19)
        
        navigationView.layer.shadowColor = UIColor(hex: "#0000000D").cgColor
        navigationView.layer.shadowOpacity = 0.25
        navigationView.layer.shadowOffset = CGSize(width: 0, height: 3) // bottom only
        navigationView.layer.shadowRadius = 1
        navigationView.layer.masksToBounds = false
    }
    
  

    func loadAllUsers() {
        let params = ApplicationUserListQueryParams()
        params.limit = 50

        userListQuery = SendbirdChat.createApplicationUserListQuery(params: params)

        userListQuery?.loadNextPage { [weak self] users, error in
            guard let self = self else { return }

            if let error = error {
                print("Failed to fetch users:", error.localizedDescription)
                return
            }

            guard let allUsers = users else { return }

            let currentUserId = "\(LocalDataManager.getUserId())"
            let filteredUsers = allUsers.filter {
                $0.userId != currentUserId && !$0.userId.starts(with: "sendbird_desk_agent_id_")
            }

            var chatUsers: [ChatUser] = []
            let group = DispatchGroup()

            for user in filteredUsers {
                group.enter()
                let params = GroupChannelCreateParams()
                params.isDistinct = true
                params.addUserId(user.userId)

                GroupChannel.createChannel(params: params) { channel, error in
                    var lastMessageText: String?
                    var lastMessageTime: Int64?

                    if let channel = channel {
                        let unreadCount = channel.unreadMessageCount

                        if let lastMessage = channel.lastMessage as? UserMessage {
                            lastMessageText = lastMessage.message
                            lastMessageTime = lastMessage.createdAt
                        }

                        let isPinned = ChatPinManager.isPinned(userId: user.userId)

                        chatUsers.append(ChatUser(
                            user: user,
                            unreadCount: Int(unreadCount),
                            isPinned: isPinned,
                            lastMessage: lastMessageText,
                            lastMessageTimestamp: lastMessageTime
                        ))
                    } else {
                        print("Error creating channel for \(user.userId): \(error?.localizedDescription ?? "unknown")")
                        chatUsers.append(ChatUser(
                            user: user,
                            unreadCount: 0,
                            isPinned: ChatPinManager.isPinned(userId: user.userId),
                            lastMessage: nil,
                            lastMessageTimestamp: nil
                        ))
                    }

                    group.leave()
                }
            }

            group.notify(queue: .main) {
                self.users = chatUsers
                self.sortUsers()
                self.tableView.reloadData()
            }
        }
    }

    
    func sortUsers() {
        users.sort {
            if $0.isPinned != $1.isPinned {
                return $0.isPinned && !$1.isPinned
            }
            let time1 = $0.lastMessageTimestamp ?? 0
            let time2 = $1.lastMessageTimestamp ?? 0
            return time1 > time2
        }
    }


    
    
    @IBAction func profileAction(_ sender: Any) {
        let vc = storyboard?.instantiateViewController(identifier: "ProfileViewController") as! ProfileViewController
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    
    @IBAction func backAction(_ sender: Any) {
        self.tabBarController?.selectedIndex = 0
    }
    
    
    @IBAction func searchAction(_ sender: Any) {
   
    }
    
}


extension ChatViewController: UITableViewDelegate, UITableViewDataSource {
    // Number of sections
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    // Number of rows in section
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return users.count
    }

    // Cell for row
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ChatTableViewCell", for: indexPath) as! ChatTableViewCell
        let user = users[indexPath.row].user
        let data = users[indexPath.row]
        
        if let urlString = user.profileURL, let url = URL(string: urlString) {
            cell.profileImageView.kf.setImage(
                with: url,
                placeholder: UIImage(named: "profile"), // Placeholder while loading
                options: [.transition(.fade(0.2))]      // Optional: smooth fade transition
            ) { result in
                switch result {
                case .success:
                    break // Image loaded successfully
                case .failure:
                    cell.profileImageView.image = UIImage(named: "profile") // Fallback on error
                }
            }
        } else {
            cell.profileImageView.image = UIImage(named: "default_profile")
        }
        
        cell.unReadCount.text = data.unreadCount > 0 ? "\( data.unreadCount)" : ""
        cell.unreadView.isHidden = data.unreadCount == 0
        cell.userNameLabel.text = user.nickname
        cell.lastChatLabel.text = data.lastMessage ?? ""
        
        let pinImage = UIImage(systemName: data.isPinned ? "pin.fill" : "pin")
        cell.pinButton.setImage(pinImage, for: .normal)
        
        
        cell.onPinToggle = { [weak self] in
            guard let self = self else { return }
            var updatedUser = self.users[indexPath.row]

            if updatedUser.isPinned {
                updatedUser.isPinned = false
                ChatPinManager.unpin(userId: updatedUser.user.userId)
            } else {
                updatedUser.isPinned = true
                ChatPinManager.pin(userId: updatedUser.user.userId)
            }

            self.users[indexPath.row] = updatedUser

            // Sort users again to move pinned ones to top
            self.sortUsers()
            self.tableView.reloadData()
        }
        
        if let timestamp = data.lastMessageTimestamp {
            let date = Date(timeIntervalSince1970: Double(timestamp) / 1000)
            let formatter = DateFormatter()

            // Same-day: show time, otherwise show date
            if Calendar.current.isDateInToday(date) {
                formatter.dateFormat = "h:mm a"
            } else {
                formatter.dateFormat = "MMM d"
            }

            cell.timeLabel.text = formatter.string(from: date)
        } else {
            cell.timeLabel.text = ""
        }
        
        return cell
    }

    // Row selection
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let user = users[indexPath.row].user
        let vc = storyboard?.instantiateViewController(identifier: "ChatDetailViewController") as! ChatDetailViewController
        vc.currentUserId = "\(LocalDataManager.getUserId())"
        vc.targetUserId = user.userId
        vc.user = user
        navigationController?.pushViewController(vc, animated: true)
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    

}

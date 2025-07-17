//
//  ChatDetailViewController.swift
//  ADFW
//
//  Created by MultiTV on 01/07/25.
//

import UIKit
import SendbirdChatSDK
import SendbirdUIKit

struct MessageSection {
    let date: String // "MMM dd, yyyy"
    var messages: [BaseMessage]
}

class ChatDetailViewController: UIViewController {

    // MARK: - IBOutlets
    @IBOutlet weak var navView: UIView!
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var desigLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var textfeildView: UIView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var messageTextField: UITextField!


    // MARK: - Properties
    var channel: GroupChannel?
    var messageSections: [MessageSection] = []
    

    
    var currentUserId = ""
    var targetUserId = ""
    
    var user:SendbirdChatSDK.User?

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        setupTableView()
        connectAndStartChat()
      
        SendbirdChat.addChannelDelegate(self, identifier: "ChatDetailViewController")

    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.tabBar.isHidden = true
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.tabBarController?.tabBar.isHidden = false
        SendbirdChat.removeChannelDelegate(forIdentifier: "ChatDetailViewController")
       
    }

    // MARK: - Setup
    func configureUI() {
        navView.layer.shadowColor = UIColor(hex: "#0000000D").cgColor
        navView.layer.shadowOpacity = 0.25
        navView.layer.shadowOffset = CGSize(width: 0, height: 3) // bottom only
        navView.layer.shadowRadius = 1
        navView.layer.masksToBounds = false

        nameLabel.font = FontManager.font(weight: .medium, size: 18)
        desigLabel.font = FontManager.font(weight: .semiBold, size: 10)
        
        nameLabel.text = user?.nickname
       
        if let urlString = user?.profileURL, let url = URL(string: urlString) {
            profileImageView.kf.setImage(
                with: url,
                placeholder: UIImage(named: "profile"),
                options: [.transition(.fade(0.2))]     
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
        
        profileImageView.layer.cornerRadius = profileImageView.frame.width / 2
        textfeildView.layer.cornerRadius = 25
        textfeildView.clipsToBounds = true
    }

    func setupTableView() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.separatorStyle = .none

        let incomingNib = UINib(nibName: "SendMessageTableViewCell", bundle: nil)
        let outgoingNib = UINib(nibName: "ReceiveTableViewCell", bundle: nil)

        tableView.register(incomingNib, forCellReuseIdentifier: "SendMessageTableViewCell")
        tableView.register(outgoingNib, forCellReuseIdentifier: "ReceiveTableViewCell")
    }


    // MARK: - Chat Connection
    func connectAndStartChat() {
        SendbirdChat.connect(userId: currentUserId) { user, error in
            if let error = error {
                print("Connection failed: \(error.localizedDescription)")
                return
            }

            let params = UserUpdateParams()
            params.nickname = (LocalDataManager.getLoginResponse()?.firstName ?? "") + " " +  (LocalDataManager.getLoginResponse()?.lastName ?? "")
            params.profileImageURL = LocalDataManager.getLoginResponse()?.photo

            SendbirdChat.updateCurrentUserInfo(params: params, completionHandler:  { error in
                if let error = error {
                    print("User info update error: \(error.localizedDescription)")
                } else {
                    // After updating nickname/photo, update metadata
                    let metadata: [String: String] = [
                        "role": LocalDataManager.getLoginResponse()?.designation ?? "",
                        "company": LocalDataManager.getLoginResponse()?.company ?? "",
                        "country": LocalDataManager.getLoginResponse()?.nationality ?? ""
                    ]
                    
                    SendbirdChat.getCurrentUser()?.updateMetaData(metadata) { updatedMetadata, error in
                        if let error = error {
                            print("Metadata update error: \(error.localizedDescription)")
                        } else {
                            print("Metadata updated: \(updatedMetadata ?? [:])")
                        }
                    }
                }
            })

          
            self.loadOrCreateChannel(currentUserId: self.currentUserId, targetUserId: self.targetUserId)
        }
        
       
    }

    // MARK: - Channel Handling
    func loadOrCreateChannel(currentUserId: String, targetUserId: String) {
        let params = GroupChannelCreateParams()
        params.isDistinct = true
        params.userIds = [currentUserId, targetUserId]

        GroupChannel.createChannel(params: params) { channel, error in
            if let error = error {
                print("Channel creation failed: \(error.localizedDescription)")
                return
            }

            self.channel = channel
            self.loadMessages()

            if let member = channel?.members.first(where: { $0.userId == self.targetUserId }) {
                self.user = member
                self.nameLabel.text = member.nickname

                if let urlString = member.profileURL, let url = URL(string: urlString) {
                    self.profileImageView.kf.setImage(with: url, placeholder: UIImage(named: "profile"))
                }
                self.desigLabel.text = member.metaData["role"]
            }
        }
    }


    func loadMessages() {
        guard let channel = self.channel else { return }

        let params = MessageListParams()
        params.reverse = false
        let timestamp = Int64(Date().timeIntervalSince1970 * 1000)

        channel.getMessagesByTimestamp(timestamp, params: params) { messages, error in
            if let error = error {
                print("Failed to load messages: \(error.localizedDescription)")
                return
            }

            guard let messages = messages else { return }
            
            // Group messages by date
            let grouped = Dictionary(grouping: messages) { message -> String in
                let date = Date(timeIntervalSince1970: Double(message.createdAt) / 1000)
                let formatter = DateFormatter()
                formatter.dateStyle = .medium
                formatter.timeStyle = .none
                return formatter.string(from: date)
            }

            // Sort sections by date descending
            self.messageSections = grouped.map {
                let sortedMessages = $0.value.sorted { $0.createdAt < $1.createdAt }
                return MessageSection(date: $0.key, messages: sortedMessages)
            }.sorted { lhs, rhs in
                let formatter = DateFormatter()
                formatter.dateStyle = .medium
                formatter.timeStyle = .none
                guard let date1 = formatter.date(from: lhs.date),
                      let date2 = formatter.date(from: rhs.date) else { return false }
                return date1 < date2
            }


            self.tableView.reloadData()
            
            self.channel?.markAsRead { error in
                if let error = error {
                    print("Failed to mark as read: \(error.localizedDescription)")
                } else {
                    print("Messages marked as read")
                }
            }

        }
    }


    // MARK: - Actions
    @IBAction func backAction(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }

    @IBAction func moreOptionAction(_ sender: Any) {
        // Show action sheet or options menu
    }
    
    @IBAction func sendMessAction(_ sender: Any) {
        guard let channel = channel else { return }
        guard let text = messageTextField.text, !text.trimmingCharacters(in: .whitespaces).isEmpty else { return }

        let params = UserMessageCreateParams(message: text)
        
        channel.sendUserMessage(params: params) { message, error in
            if let error = error {
                print("Failed to send message: \(error.localizedDescription)")
                return
            }

            guard let sentMessage = message else { return }

            // Format the date string of the sent message
            let date = Date(timeIntervalSince1970: Double(sentMessage.createdAt) / 1000)
            let formatter = DateFormatter()
            formatter.dateStyle = .medium
            formatter.timeStyle = .none
            let dateString = formatter.string(from: date)

            if let sectionIndex = self.messageSections.firstIndex(where: { $0.date == dateString }) {
                // Append to the end (not insert at 0)
                self.messageSections[sectionIndex].messages.append(sentMessage)
            } else {
                // Add new section at the end
                let newSection = MessageSection(date: dateString, messages: [sentMessage])
                self.messageSections.append(newSection)
            }

            self.messageTextField.text = "" // Clear input
            self.tableView.reloadData()

            // Scroll to the latest message
            DispatchQueue.main.async {
                let lastSection = self.messageSections.count - 1
                let lastRow = self.messageSections[lastSection].messages.count - 1
                if lastSection >= 0 && lastRow >= 0 {
                    self.tableView.scrollToRow(at: IndexPath(row: lastRow, section: lastSection), at: .bottom, animated: true)
                }
            }
        }
    }

    
}

// MARK: - UITableViewDataSource
extension ChatDetailViewController: UITableViewDataSource,UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return messageSections.count
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messageSections[section].messages.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let message = messageSections[indexPath.section].messages[indexPath.row]
        guard let userMessage = message as? UserMessage else {
            return UITableViewCell()
        }

        let isIncoming = userMessage.sender?.userId != currentUserId

        if isIncoming {
            let cell = tableView.dequeueReusableCell(withIdentifier: "ReceiveTableViewCell", for: indexPath) as! ReceiveTableViewCell
            cell.messageLabel.text = userMessage.message
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "SendMessageTableViewCell", for: indexPath) as! SendMessageTableViewCell
            cell.messageLabel.text = userMessage.message
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = MessageHeaderView.loadFromNib()
        headerView.dateLabel.text = messageSections[section].date
        return headerView
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40
    }
    
    
    


}


extension ChatDetailViewController: GroupChannelDelegate {
    func channel(_ channel: BaseChannel, didReceive message: BaseMessage) {
        print("Real-time message received: \(message.messageId)")
        //guard channel.channelURL == self.channel?.channelURL else { return }
        
        let date = Date(timeIntervalSince1970: Double(message.createdAt) / 1000)
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .none
        let dateString = formatter.string(from: date)

        // Find the section or create new one
        if let sectionIndex = self.messageSections.firstIndex(where: { $0.date == dateString }) {
            self.messageSections[sectionIndex].messages.append(message)
        } else {
            let newSection = MessageSection(date: dateString, messages: [message])
            self.messageSections.append(newSection)
        }

        DispatchQueue.main.async {
            self.tableView.reloadData()
            let lastSection = self.messageSections.count - 1
            let lastRow = self.messageSections[lastSection].messages.count - 1
            if lastSection >= 0 && lastRow >= 0 {
                self.tableView.scrollToRow(at: IndexPath(row: lastRow, section: lastSection), at: .bottom, animated: true)
            }
        }
    }
}



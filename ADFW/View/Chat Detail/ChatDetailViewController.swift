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
    @IBOutlet weak var profileImageView: UIButton!
    @IBOutlet weak var textfeildView: UIView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var messageTextField: UITextField!


    // MARK: - Properties
    var channel: GroupChannel?
    var messageSections: [MessageSection] = []
    
    let currentUserId = "user123"
    let targetUserId = "user456"
    
//    let currentUserId = "user456"
//    let targetUserId = "user123"
    
    let nickname = "John"
    let profileImageURL = "https://example.com/avatar.jpg"

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
            print("Connected as \(user?.userId ?? "")")

            let params = UserUpdateParams()
            params.nickname = self.nickname
            params.profileImageURL = self.profileImageURL

            SendbirdChat.updateCurrentUserInfo(params: params) { error in
                if let error = error {
                    print("User info update error: \(error.localizedDescription)")
                }
            }
          
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

//
//  ChatViewController.swift
//

import UIKit

import TwilioChatClient

class ChatViewController: UIViewController {
    
    // Important - update this URL with your Twilio Function URL
    let tokenURL = (UserDefaults.standard.string(forKey: "baseURL") ?? "http://central.emcschooltherapy.com/") + "token.php"
//    let tokenURL = "http://central.emcschooltherapy.com/token.php"

    //    let fullURL = "http://stagingcentral.emcschooltherapy.com/token.php?i=949&r=session_1209&token=8c983aca797405641d92341f03e135aa"

    // Important - this identity would be assigned by your app, for
    // instance after a user logs in
    var identity = "950"
    var sid = ""
    var token = ""
    // MARK: Chat variables
    var client: TwilioChatClient? = nil
    var generalChannel: TCHChannel? = nil
    var messages: [TCHMessage] = []
    
    // MARK: UI controls
    @IBOutlet weak var bottomConstraint: NSLayoutConstraint!
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        // Listen for keyboard events and animate text field as necessary
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(keyboardWillShow),
                                               name: UIResponder.keyboardWillShowNotification,
                                               object: nil);
        
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(keyboardDidShow),
                                               name: UIResponder.keyboardDidShowNotification,
                                               object: nil);
        
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(keyboardWillHide),
                                               name: UIResponder.keyboardWillHideNotification,
                                               object: nil);
        
        // Set up UI controls
        self.tableView.rowHeight = UITableView.automaticDimension
        self.tableView.estimatedRowHeight = 66.0
        self.tableView.separatorStyle = .none
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        // Create the general channel (for public use) if it hasn't been created yet
        
        let options = [
            TCHChannelOptionFriendlyName: "dalbeer",
            TCHChannelOptionType: TCHChannelType.public.rawValue
            ] as [String : Any]
        if let client = client, let channelsList = client.channelsList() {
            channelsList.createChannel(options: options, completion: { channelResult, channel in
                if (channelResult.isSuccessful()) {
                    print("Channel created.")
                } else {
                    print("Channel NOT created.")
                }
            })
        }
        
        
        super.viewDidAppear(animated)
        login()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        logout()
    }
    
    
    // MARK: Login / Logout
    
    func login() {
        // Fetch Access Token from the server and initialize Chat Client - this assumes you are running
        // the PHP starter app on your local machine, as instructed in the quick start guide
                TwilioChatClient.chatClient(withToken: token, properties: nil, delegate: self) {
                    (result, chatClient) in
                        self.client = chatClient;
                        // Update UI on main thread
                        DispatchQueue.main.async() {
                            self.navigationItem.prompt = "Logged in as \"\(self.identity)\""
                        }
                    }
            }
    
    @IBAction func cancelAction(_ sender: Any) {
   
        self.dismiss(animated: true, completion: nil)
    }
    
    func logout() {
        if let client = client {
            client.delegate = nil
            client.shutdown()
            self.client = nil
        }
    }
    
    // MARK: Keyboard Dodging Logic
    
    @objc func keyboardWillShow(notification: NSNotification) {
        if let keyboardRect = (notification.userInfo?[UIResponder.keyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            UIView.animate(withDuration: 0.1, animations: { () -> Void in
                self.bottomConstraint.constant = keyboardRect.height + 10
                self.view.layoutIfNeeded()
            })
        }
    }
    
    @objc func keyboardDidShow(notification: NSNotification) {
        self.scrollToBottomMessage()
    }
    
    @objc func keyboardWillHide(notification: NSNotification) {
        UIView.animate(withDuration: 0.1, animations: { () -> Void in
            self.bottomConstraint.constant = 20
            self.view.layoutIfNeeded()
        })
    }
    
    // MARK: UI Logic
    
    // Dismiss keyboard if container view is tapped
    @IBAction func viewTapped(_ sender: Any) {
        self.textField.resignFirstResponder()
    }
    // Scroll to bottom of table view for messages
    func scrollToBottomMessage() {
        if self.messages.count == 0 {
            return
        }
        let bottomMessageIndex = IndexPath(row: messages.count - 1, section: 0)
        tableView.scrollToRow(at: bottomMessageIndex, at: .bottom, animated: true)
    }
    
}

// MARK: Twilio Chat Delegate
extension ChatViewController: TwilioChatClientDelegate {
        
    func chatClient(_ client: TwilioChatClient, synchronizationStatusUpdated status: TCHClientSynchronizationStatus) {
        if status == .completed {
            // Join (or create) the general channel
//            let defaultChannel = "CH10612a02f71c47899e95b081afbabc85"
//            let defaultChannel = "RMb90669307a7a0ac80cf3956a92a3a2fe"
            let defaultChannel = "session_1209"

            if let channelsList = client.channelsList() {
                channelsList.channel(withSidOrUniqueName: defaultChannel, completion: { (result, channel) in
                    if let channel = channel {
                        self.generalChannel = channel
                        channel.join(completion: { result in
                            print("Channel joined with result \(result)")
                            
                        })
                    } else {
                        // Create the general channel (for public use) if it hasn't been created yet
                        channelsList.createChannel(options: [TCHChannelOptionFriendlyName: "General Chat Channel", TCHChannelOptionType: TCHChannelType.public.rawValue], completion: { (result, channel) -> Void in
                                if result.isSuccessful() {
                                    self.generalChannel = channel
                                    self.generalChannel?.join(completion: { result in
                                        self.generalChannel?.setUniqueName(defaultChannel, completion: { result in
                                            print("channel unique name set")
                                        })
                                    })
                                }
                        })
                    }
                })
            }
        }
    }
    
    // Called whenever a channel we've joined receives a new message
    func chatClient(_ client: TwilioChatClient, channel: TCHChannel,
                    messageAdded message: TCHMessage) {
        self.messages.append(message)
        self.tableView.reloadData()
        DispatchQueue.main.async() {
            if self.messages.count > 0 {
                self.scrollToBottomMessage()
            }
        }
    }
}

// MARK: UITextField Delegate
extension ChatViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if let messages = self.generalChannel?.messages {
            let messageOptions = TCHMessageOptions().withBody(textField.text!)
            messages.sendMessage(with: messageOptions, completion: { (result, message) in
                textField.text = ""
                textField.resignFirstResponder()
            })
        }
        return true
    }
}


// MARK: UITableViewDataSource Delegate
extension ChatViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    
    // Return number of rows in the table
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.messages.count
    }
    
    // Create table view rows
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath)
        -> UITableViewCell {
            let cell = tableView.dequeueReusableCell(withIdentifier: "MessageCell", for: indexPath)
            let message = self.messages[indexPath.row]
            
            // Set table cell values
            cell.detailTextLabel?.text = message.author
            cell.textLabel?.text = message.body
            cell.selectionStyle = .none
            return cell
    }
}

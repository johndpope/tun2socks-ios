import UIKit
import NetworkExtension
import ProxyConfig

class TableViewController: UITableViewController {
    
    var manager = VPNManager.shared()

    @IBOutlet weak var statusLabel: UILabel!
    
    @IBOutlet weak var toggleSwitch: UISwitch!
    
    @IBOutlet weak var hostField: UITextField!
    @IBOutlet weak var portField: UITextField!
    
    @IBAction func toggle(_ sender: UISwitch) {
        updateConfig()
        manager.enableVPNManager() { error in
            guard error == nil else {
                fatalError("enable VPN failed: \(error.debugDescription)")
            }
            self.manager.toggleVPNConnection() { error in
                guard error == nil else {
                    fatalError("toggle VPN connection failed: \(error.debugDescription)")
                }
            }
        }
    }
    
    @objc func updateStatus() {
        toggleSwitch.isOn = (manager.manager.connection.status != .disconnected &&
                            manager.manager.connection.status != .disconnecting &&
                            manager.manager.connection.status != .invalid)
        statusLabel.text = manager.manager.connection.status.description
    }
    
    func updateConfig() {
        ProxyConfig.storeStringConfig(name: ProxyConfig.ConfigKey.Host.rawValue, value: hostField.text!)
        ProxyConfig.storeIntConfig(name: ProxyConfig.ConfigKey.Port.rawValue, value: Int(portField.text!)!)
    }
    
    func updateUI() {
        hostField.text = ProxyConfig.getStringConfig(name: ProxyConfig.ConfigKey.Host.rawValue)
        portField.text = String(ProxyConfig.getIntConfig(name: ProxyConfig.ConfigKey.Port.rawValue)!)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        manager.loadVPNPreference() { error in
            guard error == nil else {
                fatalError("load VPN preference failed: \(error.debugDescription)")
            }
            self.updateStatus()
            NotificationCenter.default.addObserver(self, selector: #selector(self.updateStatus), name: NSNotification.Name.NEVPNStatusDidChange, object: self.manager.manager.connection)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        updateUI()
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.NEVPNStatusDidChange, object: self.manager.manager.connection)
    }
}

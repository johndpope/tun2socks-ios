import Foundation

let appgroup = "group.test.tun2socks-ios"

public let preferHandler = handler.Socks5

public enum handler {
    case Socks5
}

public enum ConfigKey: String {
    case Host = "Host"
    case Port = "Port"
}

public func storeStringConfig(name: String, value: String) {
    UserDefaults.init(suiteName: appgroup)?.set(value, forKey: name)
}

public func storeIntConfig(name: String, value: Int) {
    UserDefaults.init(suiteName: appgroup)?.set(value, forKey: name)
}

public func getStringConfig(name: String) -> String? {
    if let value = UserDefaults.init(suiteName: appgroup)?.object(forKey: name) as? String {
        return value
    } else {
        return ""
    }
}

public func getIntConfig(name: String) -> Int? {
    if let value = UserDefaults.init(suiteName: appgroup)?.object(forKey: name) as? Int {
        return value
    } else {
        return 0
    }
}

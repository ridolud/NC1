//
//  NCNetworkManager.swift
//  NC1
//
//  Created by Faridho Luedfi on 19/09/19.
//  Copyright © 2019 ridolud. All rights reserved.
//

import UIKit
import SystemConfiguration.CaptiveNetwork

struct NCNetworkInfo {
    public let interface: String
    public let ssid: String
    public let bssid: String
    
    init(_ interface: String, _ ssid: String, _ bssid: String) {
        self.interface = interface
        self.ssid = ssid
        self.bssid = bssid
    }
}
    
    let macAddressWifi = [
        "c8:67:5e:2f:15:24",
        "c8:67:5e:68:f1:64",
        "c8:67:5e:2f:a:64"
    ]

    func getWifiInfo() -> Array<NCNetworkInfo> {
        
        
        
        guard let interfaceNames = CNCopySupportedInterfaces() as? [String] else {
            return []
        }
        
        
        
        let networkInfos:[NCNetworkInfo] = interfaceNames.compactMap{ name in
            
            guard let info = CNCopyCurrentNetworkInfo(name as CFString) as? [String:AnyObject] else {
                return nil
            }
            guard let ssid = info[kCNNetworkInfoKeySSID as String] as? String else {
                return nil
            }
            guard let bssid = info[kCNNetworkInfoKeyBSSID as String] as? String else {
                return nil
            }
            return NCNetworkInfo(name, ssid,bssid)
        }
        
        return networkInfos
    }
    
    func isIosdaTraningWifi() -> Bool {
        let networkInfo = getWifiInfo()
        
        print(networkInfo.first?.bssid)
        
        return macAddressWifi.contains(networkInfo.first!.bssid)
    }

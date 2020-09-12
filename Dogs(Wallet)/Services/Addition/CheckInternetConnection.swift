//
//  CheckInternetConnection.swift
//  Dogs(Wallet)
//
//  Created by Азизбек on 25.08.2020.
//  Copyright © 2020 Azizbek Ismailov. All rights reserved.
//

import SystemConfiguration

 class CheckInternetConnection {
    
    class func connection() -> Bool {
        var zeroAdress = sockaddr_in(sin_len: 0, sin_family: 0, sin_port: 0, sin_addr: in_addr(s_addr: 0), sin_zero: (0, 0, 0, 0, 0, 0, 0, 0))
        zeroAdress.sin_len = UInt8(MemoryLayout.size(ofValue: zeroAdress))
        zeroAdress.sin_family = sa_family_t(AF_INET)
        
        let dafaultRouteReachability = withUnsafePointer(to: &zeroAdress) {
            $0.withMemoryRebound(to: sockaddr.self, capacity: 1) { zeroSockAdress in
                SCNetworkReachabilityCreateWithAddress(nil, zeroSockAdress)
            }
        }
        var flags: SCNetworkReachabilityFlags = SCNetworkReachabilityFlags(rawValue: 0)
        if SCNetworkReachabilityGetFlags(dafaultRouteReachability!, &flags) == false {
            return false
        }
        
        //Working for Callular and WiFi
        let isReachable = (flags.rawValue &  UInt32(kSCNetworkFlagsReachable)) != 0
        let needConnection = (flags.rawValue & UInt32(kSCNetworkFlagsConnectionRequired)) != 0
        let returnValue = (isReachable && !needConnection)
        
        return returnValue
    }
}

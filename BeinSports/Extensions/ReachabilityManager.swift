//
//  ReachabilityManager.swift
//  BeinSports
//
//  Created by mo_fathy on 06/05/2023.
//

import Foundation
import UIKit
import ReachabilitySwift 

public protocol NetworkStatusListener : AnyObject {
    func networkStatusDidChange(status: Reachability.NetworkStatus)
}
class ReachabilityManager: NSObject {
   static  let shared = ReachabilityManager()  // 2. Shared instance
    // 3. Boolean to track network reachability
    var isNetworkAvailable : Bool {
      return reachabilityStatus != .notReachable
    }
    var listeners = [NetworkStatusListener]()
    // 4. Tracks current NetworkStatus (notReachable, reachableViaWiFi, reachableViaWWAN)
    var reachabilityStatus: Reachability.NetworkStatus = .notReachable
    // 5. Reachability instance for Network status monitoring
    let reachability = Reachability()!
    /// Called whenever there is a change in NetworkReachibility Status
    ///
    /// — parameter notification: Notification with the Reachability instance
    @objc func reachabilityChanged(notification: Notification) {
        
        let reachability = notification.object as! Reachability

        switch reachability.currentReachabilityStatus {
        case .notReachable:
            debugPrint("Network became unreachable")
        case .reachableViaWiFi:
            debugPrint("Network reachable through WiFi")
        case .reachableViaWWAN:
            debugPrint("Network reachable through Cellular Data")
        }
        self.reachabilityStatus = reachability.currentReachabilityStatus
        // Sending message to each of the delegates
        for listener in listeners {
            listener.networkStatusDidChange(status: reachability.currentReachabilityStatus)
        }
    }
    /// Starts monitoring the network availability status
    func startMonitoring() {
       NotificationCenter.default.addObserver(self,
                 selector:#selector(self.reachabilityChanged),
                     name: ReachabilityChangedNotification,
                   object: reachability)
      do{
        try reachability.startNotifier()
      } catch {
        debugPrint("Could not start reachability notifier")
      }
    }
    /// Stops monitoring the network availability status
    func stopMonitoring(){
       reachability.stopNotifier()
       NotificationCenter.default.removeObserver(self,
                     name: ReachabilityChangedNotification,
                   object: reachability)
    }
    func addListener(listener: NetworkStatusListener){
        listeners.append(listener)
    }

    /// Removes a listener from listeners array
    ///
    /// - parameter delegate: the listener which is to be removed
    func removeListener(listener: NetworkStatusListener){
        listeners = listeners.filter{ $0 !== listener}
    }
}

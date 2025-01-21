import UIKit
import Flutter

@main
@objc class AppDelegate: FlutterAppDelegate {
    var methodChannel: FlutterMethodChannel?
    
    override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    ) -> Bool {
        GeneratedPluginRegistrant.register(with: self)
        UNUserNotificationCenter.current().delegate = self
            
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge]) { granted, error in
            if let error = error {
                print("Notification permission error: \(error)")
            }
            if granted {
                print("Notification permissions granted.")
            } else {
                print("Notification permissions denied.")
            }
        }
          
        let flutterViewController = window?.rootViewController as? FlutterViewController
        
        if let flutterViewController = flutterViewController {
            methodChannel = FlutterMethodChannel(
                name: "com.example.notificator",
                binaryMessenger: flutterViewController.binaryMessenger
            )
        }

        methodChannel?.setMethodCallHandler { (call, result) in
        print("Call from Flutter side: \(call.method), args: \(String(describing: call.arguments))")
        if call.method == "schedule" {
            if let arguments = call.arguments as? [String: Any] {
                guard let id = arguments["id"],
                      let time = arguments["time"],
                      let message = arguments["message"],
                      let title = arguments["title"] else {
                    result(FlutterError(code: "INVALID_ARGUMENTS", message: "Invalid data structure", details: nil))
                    return
                }
                
                // Create NotificationData or handle the extracted values
                let notificationData = NotificationData(id: id as! Int, time: time as! Int, message: message as! String, title: title as! String)
                
                print("ID: \(id), Time: \(time), Message: \(message), Title: \(title)")
                
                self.scheduleAlarm(notification: notificationData)
                result("Notification scheduled successfully.")
            } else {
                result(FlutterError(code: "INVALID_ARGUMENTS", message: "Arguments are not a dictionary. Method: \(call.method), Arguments: \(String(describing: call.arguments))", details: nil))
            }
        } else {
            result(FlutterMethodNotImplemented)
        }
    }

    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
    }
    
    override func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
            // Show the notification as a banner even in the foreground
            completionHandler([.alert, .sound])
        }
    
    override func userNotificationCenter(_ center: UNUserNotificationCenter,
                                didReceive response: UNNotificationResponse,
                                withCompletionHandler completionHandler: @escaping () -> Void) {
        let userInfo = response.notification.request.content.userInfo
        let alarmId = userInfo["alarm_id"]
    
        print("UserInfo[alarm_id]: \(String(describing: alarmId))")
    
        methodChannel?.invokeMethod("onNotificationClick", arguments: ["alarm_item_id": alarmId])

        // Always call the completion handler
        completionHandler()
    }
    
    func scheduleAlarm(notification: NotificationData) {
        // Create the notification content
        let content = UNMutableNotificationContent()
        content.title = notification.title
        content.body = notification.message
        content.sound = .default
        content.userInfo = [
            "alarm_id": notification.id,
        ]
        
        let timeInterval = TimeInterval(notification.time) / 1000 // Convert to seconds
        let notificationDate = Date(timeIntervalSince1970: timeInterval)
        
        let calendar = Calendar.current
        let dateComponents = calendar.dateComponents([.year, .month, .day, .hour, .minute, .second], from: notificationDate)

        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: false)

        // Create the notification request
        let request = UNNotificationRequest(identifier: "notification_\(notification.id)", content: content, trigger: trigger)

        // Schedule the notification
        UNUserNotificationCenter.current().add(request) { error in
            if let error = error {
                print("Error scheduling notification: \(error)")
            } else {
                print("Notification scheduled for \(notificationDate)")
            }
        }
    }
}

struct NotificationData {
    let id: Int
    let time: Int
    let message: String
    let title: String

    init?(from dictionary: [String: Any]) {
        guard let id = dictionary["id"] as? Int,
              let time = dictionary["time"] as? Int,
              let message = dictionary["message"] as? String,
              let title = dictionary["title"] as? String else {
            return nil
        }
        self.id = id
        self.time = time
        self.message = message
        self.title = title
    }
    
    init(id: Int, time: Int, message: String, title: String) {
        self.id = id
        self.time = time
        self.message = message
        self.title = title
    }
}

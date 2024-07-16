//
//  ViewController.swift
//  userNotificationLocal

import UIKit
import UserNotifications

extension UIColor {
    convenience init?(hex: String) {
        var rgb: UInt64 = 0
        let scanner = Scanner(string: hex.trimmingCharacters(in: .whitespacesAndNewlines))
        scanner.scanLocation = 1 // 跳過 '#'
        scanner.scanHexInt64(&rgb)
        self.init(
            red: CGFloat((rgb >> 16) & 0xFF) / 255.0,
            green: CGFloat((rgb >> 8) & 0xFF) / 255.0,
            blue: CGFloat(rgb & 0xFF) / 255.0,
            alpha: 1.0
        )
    }
}

class ViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // createNotification()

        // 建立按鈕
        let button = UIButton(type: UIButton.ButtonType.system)
        button.setTitle("發送通知", for: UIControl.State.normal)
        // #selector(methodName) methodName方法名稱，必須是 @objc 標記的方法
        button.addTarget(self, action: #selector(sendNotification), for: UIControl.Event.touchUpInside)
        button.frame = CGRect(x: 100, y: 200, width: 200, height: 50)

        // 設定按鈕樣式
        button.backgroundColor = UIColor.white
        button.layer.cornerRadius = 25
        button.layer.borderColor = UIColor(hex: "#2e95d3")?.cgColor // UIColor.gray.cgColor
        button.layer.borderWidth = 3
        
        // 設定文字大小
        button.titleLabel?.font = UIFont.systemFont(ofSize: 20) // 你可以調整這裡的數字來改變字體大小
        
        view.addSubview(button)
        
    }
    
    @objc func sendNotification() {
        createNotification()
    }
    
    func createNotification() {
        
        let content = UNMutableNotificationContent()
        
        content.title = "憤怒鳥" // 通知的主標題
        content.subtitle = "即將上市" // 通知的副標題
        content.body = "憤怒鳥是芬蘭遊戲公司Rovio娛樂出品的電子遊戲...." // 通知的內文
        content.badge = 888 // 收到通知後，AppIcon右上角會出現數字
        content.sound = UNNotificationSound.default // 通知的聲音，這裡使用系統預設的聲音
        content.categoryIdentifier = "alarmMessage"

        let imageURL = Bundle.main.url(forResource: "bird", withExtension: "png")
        let attachment = try! UNNotificationAttachment(identifier: "", url: imageURL!, options: nil)
        
        content.attachments = [attachment]
        
        //Add specific time trigger
//        var date = DateComponents()
//        date.year = 2019
//        date.month = 9
//        date.day = 17
//        date.hour = 12
//        date.minute = 12
//        let trigger = UNCalendarNotificationTrigger(dateMatching: date, repeats: false)
        
        // trigger：觸發通知的方式。這裡先以間隔多久來示範：5秒後發送、不重複
        // repeats 可以改成是否要重複，但重複必須最少60s
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 1, repeats: false)
        
        // request：安排一個通知。identifier：識別碼，自行輸入用以管理通知
        let request = UNNotificationRequest(identifier: "notification", content: content, trigger: trigger)
        
        // 將先前安排好的通知加入
        UNUserNotificationCenter.current().add(request, withCompletionHandler: nil)
    }

}


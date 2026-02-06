import Foundation

extension Date {
    
    
    var currentDay: String {
        let formatter: DateFormatter = {
            let f = DateFormatter()
            f.locale = Locale(identifier: "ja_JP")
            f.setLocalizedDateFormatFromTemplate("dd")
            return f
        }()
        
        return formatter.string(from: self)
    }
    
    var currentHourMinute: String {
        let formatter: DateFormatter = {
            let f = DateFormatter()
            f.locale = Locale(identifier: "ja_JP")
            f.setLocalizedDateFormatFromTemplate("HH:MM")
            return f
        }()
        return formatter.string(from: self)
    }
    
    var currentMonth: String {
        let formatter: DateFormatter = {
            let f = DateFormatter()
            f.locale = Locale(identifier: "ja_JP")
            f.setLocalizedDateFormatFromTemplate("MMMM")
            return f
        }()
        
        return formatter.string(from: self)
    }
    
    var currentYear: String {
        let formatter: DateFormatter = {
            let f = DateFormatter()
            f.locale = Locale(identifier: "ja_JP")
            f.setLocalizedDateFormatFromTemplate("YYYY")
            return f
        }()
        
        return formatter.string(from: self)
    }
    
    var dayNumber: Int {
        let calendar = Calendar.current
        let day = calendar.component(.day, from: self)
        return day
    }
}

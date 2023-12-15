import Foundation

// * * * * * Every Minute
// 0 * * * * Every Hour
// 5 * * * * At minute 5
// 1,5 * * * * At minute 1 and 5
// 1-5 * * * * At every minute from 1 through 5.
// */5 * * * * At every 5th minute.
// 1/5 * * * * Every 5 minutes, starting at 1 minutes past the hour
// 7-9,15-25,*/30 * * * * At every minute from 7 through 9, every minute from 15 through 25, and every 30th minute.

// MARK: - Allowed Symbols
let listSeparator = ","
let rangeSeparator = "-"
let stepSeparator = "/"
let starSymbol = "*"
let questionSymbol = "?"
let LSymbol = "L"
let WSymbol = "W"
let hashtagSymbol = "#"

let separationCharacterss = [listSeparator, rangeSeparator, stepSeparator]
let singleSpecialCharacterss: [String] = [starSymbol]

// MARK: - Allowed Short Symbols
let monthsSymbolRange = DateFormatter().shortMonthSymbols.compactMap { String($0).uppercased() }
let monthsFullSymbolRange = DateFormatter().monthSymbols.compactMap { String($0).uppercased() }
let dayOfWeekSymbolRange = DateFormatter().shortWeekdaySymbols.compactMap { String($0).uppercased() }
let dayOfWeekFullSymbolRange = DateFormatter().weekdaySymbols.compactMap { String($0).uppercased() }

// MARK: - Allowed Integers
let minutesRange = 0...59
let hoursRange = 0...23
let dayOfMonthIntRange = 1...31
let monthsIntRange = 1...12
let dayOfWeekIntRange = 0...6

extension Int {
    var ordinal: String? {
        let ordinalFormatter = NumberFormatter()
        ordinalFormatter.numberStyle = .ordinal
        return ordinalFormatter.string(from: NSNumber(value: self))
    }
}

enum Field: Int, CaseIterable {
    case minutes
    case hours
    case dayOfWeek
    case dayOfMonth
    case months
    
    var position: Int {
        switch self {
        case .minutes:
            return 0
        case .hours:
            return 1
        case .dayOfMonth:
            return 2
        case .months:
            return 3
        case .dayOfWeek:
            return 4
        }
    }
    
    var displayName: String {
        switch self {
        case .minutes:
            return "Minute"
        case .hours:
            return "Hour"
        case .dayOfMonth:
            return "Day Of the Month"
        case .months:
            return "Month"
        case .dayOfWeek:
            return "Day Of the Week"
        }
    }
    
    var displayNamePluaral: String {
        switch self {
        case .dayOfMonth:
            return "Days Of the Month"
        case .dayOfWeek:
            return "Days of the Week"
        default:
            return [displayName, "s"].joined()
        }
        
    }
    
    var translatePrefix: String {
        switch self {
        case .minutes, .hours:
            return "At"
        case .dayOfMonth, .dayOfWeek:
            return "On"
        case .months:
            return "In"
        }
    }
}

// MARK: - Field Helpers
extension Field {
    func value(from cronPattern: String) -> String? {
        let fieldIndex = position
        let components = cronPattern.components(separatedBy: " ").filter({ !$0.isEmpty })
        guard components.indices.contains(fieldIndex) else { return nil }
        return components[fieldIndex]
    }
    
    var integerRange:ClosedRange<Int> {
        switch self {
        case .minutes:
            return minutesRange
        case .hours:
            return hoursRange
        case .dayOfMonth:
            return dayOfMonthIntRange
        case .months:
            return monthsIntRange
        case .dayOfWeek:
            return dayOfWeekIntRange
        }
    }
    
    var singleSpecialCharacters: [String] {
        switch self {
        case .minutes:
            return singleSpecialCharacterss
        case .hours:
            return singleSpecialCharacterss
        case .dayOfMonth:
            return singleSpecialCharacterss + [questionSymbol, LSymbol, WSymbol]
        case .months:
            return singleSpecialCharacterss
        case .dayOfWeek:
            return singleSpecialCharacterss + [questionSymbol, LSymbol, hashtagSymbol]
        }
    }
    
    var separationCharacters: [String] {
        switch self {
        case .dayOfWeek:
            return separationCharacterss + CollectionOfOne(hashtagSymbol)
        default:
            return separationCharacterss
        }
    }
    
    var symbolRange: [String]? {
        switch self {
        case .months:
            return monthsSymbolRange
        case .dayOfWeek:
            return dayOfWeekSymbolRange
        default:
            return nil
        }
    }
    
    var fullSymbolRange: [String]? {
        switch self {
        case .months:
            return monthsFullSymbolRange
        case .dayOfWeek:
            return dayOfWeekFullSymbolRange
        default:
            return nil
        }
    }
}

extension Field {
    func description(of cronPattern: String) -> String {
        let value = value(from: cronPattern) ?? cronPattern
        
        if let integer = Int(value) {
            if self == .dayOfMonth {
                return [self.translatePrefix, "The", integer.ordinal ?? String(integer), displayName].joined(separator: " ")
            } else if self == .months || self == .dayOfWeek {
                return [self.translatePrefix, (fullSymbolRange?[integer] ?? String(integer)).capitalized].joined(separator: " ")
            } else {
                return [translatePrefix, displayName, String(value)].joined(separator: " ")
            }
        }
        if value.count == 1 {
            if value == starSymbol {
                return ["Every", displayName].joined(separator: " ")
            } else {
                return [translatePrefix, displayName, String(value)].joined(separator: " ")
            }
        }
        
        if value.isRange {
            var description = [translatePrefix]
            var values = value.components(separatedBy: rangeSeparator)
            if self == .months || self == .dayOfWeek {
                values = values.compactMap { Int($0) != nil ? fullSymbolRange?[Int($0) ?? 0] : $0 }
            } else if self == .hours {
                values = values.compactMap { $0.formatHour }
                description.append(contentsOf: ["past", "every", displayName, "from"])
            } else {
                description.append(contentsOf: ["every", displayName, "from"])
            }
            description.append(contentsOf: [values[0], "through", values[1]])
            return description.joined(separator: " ")
        }
        
        // NOTE: - It's important to call check list seprator first!!!
        if value.isList {
            let components = value.components(separatedBy: listSeparator)
            print("here")
            if value.isComplexList(self) {
                print("here1")
                return components.compactMap { description(of: $0) }.commaRuleDisplay
            } else {
                var description = [translatePrefix, displayName]
                var values = components
                if self == .months || self == .dayOfWeek {
                    values = values.compactMap { Int($0) != nil ? fullSymbolRange?[Int($0) ?? 0] : $0 }
                    description.removeLast()
                } else if self == .hours {
                    values = values.compactMap { $0.formatHour }
                    description.removeLast()
                }
                let valuesDescription = values.commaRuleDisplay
                description.append(valuesDescription)
                return description.joined(separator: " ")
            }
        }
        
        if value.isStep {
            let values = value.components(separatedBy: stepSeparator)
            let range = symbolRange
            let indexOfSymbol = range?.firstIndex(where: { $0.lowercased() == values.last })
            var desccription = ["Every", (Int(values[1]) ?? indexOfSymbol)?.ordinal]
            if values.first != starSymbol {
                if self == .dayOfWeek || self == .months {
                    desccription.append(contentsOf: ["\(displayName),"])
                    let startDay = Int(values[0]) != nil ? fullSymbolRange?[Int(values[0]) ?? 0] : values[0]
                    desccription.append(contentsOf:[startDay?.capitalized, "through", fullSymbolRange?.last])
                } else if self == .hours {
                    desccription.append(contentsOf: ["\(displayName),", "starting", "at", values[0].formatHour])
                } else {
                    desccription.append(contentsOf: ["\(displayName),", "starting", "at", displayName, String(values[0])])
                }
            } else {
                desccription.append(self.displayName)
            }
            
            return desccription.compactMap { $0 }.joined(separator: " ")
        }
        
        if value.isShortSymbol {
            var description = [translatePrefix]
            if
                let indexOfSymbol = symbolRange?.firstIndex(where: { $0.lowercased() == value.lowercased() }),
                let correspondingDay = fullSymbolRange?[indexOfSymbol] {
                description.append(correspondingDay.capitalized)
            } else {
                description.append(value.capitalized)
            }
            return description.joined(separator: " ")
        }
        
        if self == .dayOfWeek && value.isHashtag {
            var description = [translatePrefix, "the"]
            let values = value.components(separatedBy: hashtagSymbol)
            let first = values[0]
            let second = values[1]
            description.append((Int(second)?.ordinal) ?? second)
            
            if
                let indexOfSymbol = Int(first) ?? symbolRange?.firstIndex(where: { $0.lowercased() == first.lowercased() }),
                let correspondingDay = fullSymbolRange?[indexOfSymbol] {
                description.append(correspondingDay.capitalized)
            }
            description.append("Of the Month")
            return description.joined(separator: " ")
        }

        return ["unknown", value, translatePrefix, displayName].joined(separator: " ")
    }
}

extension [String] {
    var commaRuleDisplay: String {
        [dropLast().joined(separator: ", "), last]
            .compactMap { $0 }
            .joined(separator: ", and ")
    }
    
    var formattedTime: String? {
        let hoursFromGmt = String(TimeZone.current.secondsFromGMT() / 3600)
        var value = self.joined(separator: ":") + hoursFromGmt
        let firstDateFormatter = DateFormatter()
        firstDateFormatter.dateFormat = "H:m" + Array(repeating: "X", count: hoursFromGmt.count).joined()
        
        guard let date = firstDateFormatter.date(from: value) else { return nil }
        let secondDateFormatter = DateFormatter()
        secondDateFormatter.dateStyle = .none
        secondDateFormatter.timeStyle = .short
        return secondDateFormatter.string(from: date)
    }
}
extension String {
    var formatHour: String {
        [self,"00"].formattedTime ?? self
    }
    var isInteger: Bool {
        Int(self) != nil
    }
    var isShortSymbol: Bool {
        monthsSymbolRange.contains(self) || dayOfWeekSymbolRange.contains(self)
    }
    
    var isRange: Bool {
        self.components(separatedBy: rangeSeparator)
            .filter { !$0.isEmpty }
            .count == 2
    }
    
    var isStep: Bool {
        self.components(separatedBy: stepSeparator)
            .filter { !$0.isEmpty }
            .count == 2
    }
    
    var isList: Bool {
        self.components(separatedBy: listSeparator)
            .filter { !$0.isEmpty }
            .count > 1
    }
    
    func isComplexList(_ field: Field) -> Bool {
        let components = self.components(separatedBy: listSeparator)
        print(components)
        print(field.separationCharacters)
        return components
            .first(where: { $0.isStep || $0.isRange || $0.isHashtag }) != nil
    }
    
    var isHashtag: Bool {
        self.components(separatedBy: hashtagSymbol)
            .filter { !$0.isEmpty }
            .count == 2
    }
}

enum CronExpression {
    case integer(_ value: Int, _ field: Field)
    case character(_ value: Character, _ field: Field)
    case shortSymbol(_ symbol: String, _ field: Field)
    case range(_ values: [String], _ field: Field)
    case list(_ values: [String], _ field: Field)
    case complexList(_ values: [String], _ field: Field)
    case step(_ values: [String], _ field: Field)
    
    case unknown(_ value: String, _ field: Field)
    
    init(from cronPattern: String, _ field: Field) {
        guard let value = field.value(from: cronPattern) else {
            self = .unknown(cronPattern, field)
            return
        }
        
        if let integer = Int(value) {
            self = .integer(integer, field)
            return
        }
        if value.count == 1 {
            self = .character(Character(value), field)
            return
        }
        
        if value.isRange {
            let components = value.components(separatedBy: rangeSeparator)
            self = .range(components, field)
            return
        }
        
        // NOTE: - It's important to call check list seprator first!!!
        if value.contains(listSeparator) {
            let components = value.components(separatedBy: listSeparator)
            if value.isComplexList(field) {
                self = .complexList(components, field)
                return
            } else {
                self = .list(components, field)
                return
            }
        }
        
        if value.isStep {
            let components = value.components(separatedBy: stepSeparator)
            self = .step(components, field)
            return
        }
        
        if value.isShortSymbol {
            self = .shortSymbol(value, field)
            return
        }
        self = .unknown(cronPattern, field)
    }
    
}

func translateCronExpression(_ expression: String) -> String {
    var result = [String]()
    
    result.append(contentsOf: translateMinutesAndHours(expression))
    
    Field.allCases
        .filter { $0 != .minutes && $0 != .hours }
        .forEach { field in
            if field.value(from: expression) != starSymbol {
                let express = field.description(of: expression)
                result.append(
                    express.description
                )
            }
        }
    
    return result.joined(separator: ", ")
}

func translateMinutesAndHours(_ expression: String) -> [String] {
    
    /*
    //// Possibilities
    //  * * -> Every Minute ✅
    //  0 0 -> At 12 AM ✅
    //  * 0 -> At Every Minute Past 12:00 AM ✅
    //  0 * -> Every Hour ✅
    // 1,2,3 * -> At Minute 1 and 2 and 3 Every Hour ✅
    // * 1,2,3 -> At Every Minute At 1:00 AM, 2:00 AM and 3:00 AM On MONDAY, TUESDAY and WEDNESDAY ✅
    // 1,2,3 5 -> 5:01, 5:02 and 5:03 and 5:04 ✅
    // 5 1,2,3 -> At 1:05 AM, 2:05 AM and 3:05 AM ✅
    // 2#5 -> on the fifth Tuesday of the month ✅
    // Tue#5-> on the fifth Tuesday of the month ✅
    // 7-9,15-25 * * * * -> Seconds 7 through 9 past the minute, minutes 15 through 25 past the hour
    */
    
    var result = [String]()
    guard let minutes = Field.minutes.value(from: expression) else { result.append("minutes is nil"); return result }
    guard let hours = Field.hours.value(from: expression) else { result.append("hours is nil"); return result }
    
    if minutes != starSymbol && minutes != "0" && hours == starSymbol {
        result.append(Field.minutes.description(of: expression))
        result.append(Field.hours.description(of: expression))
    }
    
    if minutes == starSymbol && hours != starSymbol {
        if let integerHours = Int(hours) {
            result.append(contentsOf: [Field.minutes.translatePrefix, "Every Minute"])
            result.append(["Past", hours.formatHour].joined(separator: " "))
        } else {
            result.append(contentsOf: [Field.minutes.translatePrefix, "Every Minute"])
            result.append(Field.hours.description(of: expression))
        }
    }
    
    if minutes == starSymbol && hours == starSymbol {
        result.append("Every Minute")
    }
    
    if hours == starSymbol {
        if let integerMinutes = Int(minutes) {
            if integerMinutes == 0 {
                result.append("Every Hour")
            } else {
                result.append(Field.minutes.description(of: expression))
                result.append("Past the Hour")
            }
        }
    }
    
    if
        Int(minutes) != nil,
        Int(hours) != nil,
        let time = [hours,minutes].formattedTime {
        result.append(
            ["At",time].joined(separator: " ")
        )
    } else {
        let minutesList = minutes.components(separatedBy: listSeparator)
        let hoursList = hours.components(separatedBy: listSeparator)
        if
            minutesList.filter(\.isInteger).count == minutesList.count,
            hoursList.filter(\.isInteger).count == hoursList.count {
            result.append(
                ["At", getTimes(hours: hoursList, minutes: minutesList)].joined(separator: " ")
            )
        }
        
    }
    return result
}

func getTimes(hours: [String], minutes: [String]) -> String {
    var result = [String]()
    for h in hours {
        for m in minutes {
            if let time = [h,m].formattedTime {
                result.append(time)
            }
        }
    }
    
    return result.commaRuleDisplay
}

print(translateCronExpression("* * * * 0,2#1,1/2"))

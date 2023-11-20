# EYCalendar
![CocoaPods](https://img.shields.io/cocoapods/v/EYCalendar) [![codebeat badge](https://codebeat.co/badges/c4f11bd8-445b-4673-af56-ea9614053489)](https://codebeat.co/projects/github-com-ehabyasser-eycalendar-main) ![contributions](https://img.shields.io/badge/contributions-welcome-informational.svg)

EYCalendar is a versatile and customizable calendar component designed for developers seeking a feature-rich solution for their applications.

# Preview
Dark Mode                  |  White Mode
:-------------------------:|:-------------------------:
![](https://github.com/ehabyasser/EYCalendar/blob/main/images/Simulator%20Screenshot%20-%20iPhone%2015%20Pro%20-%202023-11-19%20at%2020.47.04.png) |  ![](https://github.com/ehabyasser/EYCalendar/blob/main/images/Simulator%20Screenshot%20-%20iPhone%2015%20Pro%20-%202023-11-19%20at%2020.46.56.png) 
![](https://github.com/ehabyasser/EYCalendar/blob/main/images/Simulator%20Screenshot%20-%20iPhone%2015%20Pro%20-%202023-11-19%20at%2020.46.51.png) |  ![](https://github.com/ehabyasser/EYCalendar/blob/main/images/Simulator%20Screenshot%20-%20iPhone%2015%20Pro%20-%202023-11-19%20at%2020.45.24.png)


# Key Features:

## Dual Calendar Types:
The calendar supports both the Gregorian and Islamic calendars.
Developers can easily switch between the two calendar types with a toggle switch.

##Customizable Themes:
    Developers have the flexibility to change the theme color of the calendar to seamlessly integrate with their application's design.
    A variety of predefined themes are included, and developers can also define custom color schemes.
## Start Date and Month Configuration:
    Set the starting date for the calendar to align with your application's requirements.
    Choose the number of months to display, providing flexibility in the calendar's duration.
## Font Customization:
    Users can customize the font used in the calendar, ensuring consistency with the overall application design.
    A selection of fonts is available, and developers can also integrate custom fonts.
## Flag for Islamic Calendar:
    When using the Islamic calendar, a flag is displayed to indicate the calendar type, making it clear for users.
    The flag is easily toggleable, allowing users to switch between a standard calendar view and an Islamic calendar view.
## Single Calendar Mode:
    For simplicity, users can choose to use the calendar in a single mode, either as a standard Gregorian calendar or an Islamic calendar.
## RTL Support:
    Add a configuration option for RTL support in your calendar component.
    Adjust styles and layouts based on the RTL setting.
    
    
# Installation

## CocoaPods
Add this to your podfile for the latest version
```
pod 'EYCalendar'
```
Or specify desired version
```
pod 'EYCalendar', '~> 1.0.0'
```


## Manual Installation
Download and include the `EYCalendar` folder and files in your codebase.

## Requirements
 - iOS 13+
 - Swift 5
 

## How to use
```swift
// This is in your application
   class ViewController: UIViewController {
    
    private let calendar:EYCalendar = {
        let configurations = EYCalendarConfigration(startDate: Date() , NoMonths: 24 , themeColor: .blue, font: UIFont.systemFont(ofSize: 14, weight: .bold) , isLamicCalendarOnly: true)
        let calendar = EYCalendar(configuration: configurations)
        return calendar
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.addSubview(calendar)
        calendar.delegate = self
        calendar.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.top.equalTo(self.view.safeAreaLayoutGuide.snp.top)
            make.height.equalTo(440)
        }
    }
    
    
}
extension ViewController: CalendarDelegate{
    func daySelected(indexPath: IndexPath, day: Day?) {
        guard let day = day else {return}
        if day.isWithinDisplayedMonth {
            print("day number \(day.number)")
        }
    }
    
    func monthDidDisplayed(monthIndex: Int, month: Month) {
        print(month.monthTitle)
    }
}
```

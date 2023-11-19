//
//  File.swift
//
//
//  Created by Ihab yasser on 19/11/2023.
//

import Foundation
import UIKit
import SnapKit


open class EYCalendarConfigration{
    var isRTL:Bool
    var startDate:Date
    var NoMonths:Int
    var themeColor:UIColor
    var font:UIFont
    var hideCalendarActionType:Bool
    var isLamicCalendarOnly:Bool
    
    public init(isRTL: Bool = false, startDate: Date = Date(), NoMonths: Int = 12 , themeColor: UIColor = UIColor(red: 58/255, green: 171/255, blue: 214/255, alpha: 1) , font:UIFont = UIFont.systemFont(ofSize: 16, weight: .regular) , hideCalendarActionType:Bool = false , isLamicCalendarOnly:Bool = false) {
        self.isRTL = isRTL
        self.startDate = startDate
        self.NoMonths = NoMonths
        self.themeColor = themeColor
        self.font = font
        self.hideCalendarActionType = hideCalendarActionType
        self.isLamicCalendarOnly = isLamicCalendarOnly
    }
}

@available(iOS 13.0, *)
open class EYCalendar:UIView{
    public var delegate:CalendarDelegate?{
        didSet{
            calendarView.calendarDelegate = delegate
        }
    }
   private var isRTL:Bool = false
    
    private var months:[Month]
    private var isLamicMonths:[Month]
    
    private var calendarView:CalendarView
    
    private lazy var isLamicBtn:CalendarTypeButton = {
        let btn = CalendarTypeButton()
        btn.backgroundColor = ThemeHelper.lightGray
        btn.title = isRTL ? "هـ" : "H"
        btn.setTitleColor(.label, for: .normal)
        return btn
    }()
    
    
    private lazy var normalBtn:CalendarTypeButton = {
        let btn = CalendarTypeButton()
        btn.title = isRTL ? "م" : "M"
        btn.setTitleColor(.white, for: .normal)
        btn.backgroundColor = ThemeHelper.APP_COLOR
        return btn
    }()
    
    
    private lazy var stackCalendarType:UIStackView = {
        let stack = UIStackView(arrangedSubviews: [normalBtn , isLamicBtn])
        stack.axis = .horizontal
        stack.spacing = 8
        stack.distribution = .fillEqually
        normalBtn.snp.makeConstraints { make in
            make.width.height.equalTo(34)
        }
        return stack
    }()
    
    
    private lazy var monthHeaderCard:CardView = {
        let card = CardView()
        card.backgroundColor = ThemeHelper.APP_COLOR
        card.cornerRadius = 8
        card.addSubview(calendarHeader)
        calendarHeader.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(8)
            make.trailing.equalToSuperview().offset(-8)
            make.top.bottom.equalToSuperview()
        }
        return card
    }()
    
   private lazy var calendarHeader:UIStackView = {
        let stack = UIStackView(arrangedSubviews: [getDayLabel(title: isRTL ? "أحد" : "SUN") , getDayLabel(title: isRTL ? "إثنين" : "MON") , getDayLabel(title: isRTL ? "ثلاثاء" : "TUS") , getDayLabel(title: isRTL ? "اربع" : "WED") , getDayLabel(title: isRTL ? "خميس" : "THU") , getDayLabel(title: isRTL ? "جمعة" : "FRI") , getDayLabel(title: isRTL ? "سبت" : "SAT") ])
        stack.axis = .horizontal
        stack.backgroundColor = .clear
        stack.distribution = .fillEqually
        return stack
    }()
    
    
    private lazy var currentMonth:UILabel = {
        let lbl = UILabel()
        lbl.textColor = .label
        
        return lbl
    }()
    
    
   private func getDayLabel(title:String) -> UILabel{
        let lbl = UILabel()
        lbl.text = title
        lbl.textColor = .white
        lbl.textAlignment = .center
        lbl.font = ThemeHelper.font
        return lbl
    }
    
    
    public init(configuration: EYCalendarConfigration?) {
        ThemeHelper.APP_COLOR = configuration?.themeColor ?? UIColor(red: 58/255, green: 171/255, blue: 214/255, alpha: 1)
        self.isRTL = configuration?.isRTL ?? false
        self.months = CalendarManager.shared.getMonths(start: Date(), count: configuration?.NoMonths ?? 12 , isRTL: isRTL)
        self.isLamicMonths = CalendarManager.shared.getMonths(start: Date(), count: configuration?.NoMonths ?? 12, isIslamic: true , isRTL: isRTL)
        let layout = isRTL ? RTLFlowLayout() : UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        calendarView = CalendarView(frame: .zero, collectionViewLayout: layout)
        calendarView.semanticContentAttribute = isRTL ? .forceRightToLeft : .forceLeftToRight
        calendarView.months = (configuration?.isLamicCalendarOnly ?? false) ? isLamicMonths : months
        super.init(frame: .zero)
        calendarHeader.semanticContentAttribute = isRTL ? .forceRightToLeft : .forceLeftToRight
        self.configureViews()
        currentMonth.font = ThemeHelper.font
        self.stackCalendarType.isHidden = configuration?.hideCalendarActionType ?? false || configuration?.isLamicCalendarOnly ?? false
    }
    
    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func configureViews(){
        self.addSubview(monthHeaderCard)
        self.addSubview(currentMonth)
        self.addSubview(stackCalendarType)
        self.addSubview(calendarView)
        
        stackCalendarType.snp.makeConstraints { make in
            make.trailing.equalToSuperview().offset(-8)
            make.top.equalToSuperview().offset(8)
        }
        
        currentMonth.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().offset(8)
        }
        
        monthHeaderCard.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(6)
            make.trailing.equalToSuperview().offset(-6)
            make.top.equalTo(self.stackCalendarType.snp.bottom).offset(8)
            make.height.equalTo(40)
        }
        
        calendarView.snp.makeConstraints { make in
            make.bottom.equalToSuperview().offset(-8)
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
            make.top.equalTo(monthHeaderCard.snp.bottom)
        }
        
        self.setCurrentMonth()
        isLamicBtn.tap {
            DispatchQueue.main.asyncAfter(deadline: .now()) {
                self.isLamicBtn.backgroundColor = ThemeHelper.APP_COLOR
                self.normalBtn.backgroundColor = ThemeHelper.lightGray
                self.isLamicBtn.setTitleColor(.white, for: .normal)
                self.normalBtn.setTitleColor(.label, for: .normal)
                self.calendarView.months.removeAll()
                self.calendarView.reloadData()
                self.calendarView.months = self.isLamicMonths
                self.setCurrentMonth()
                self.calendarView.reloadData()
                self.calendarView.scrollToItem(at: IndexPath(row: 0, section: 0), at: .centeredHorizontally, animated: false)
            }
            
        }
        
        
        normalBtn.tap {
            DispatchQueue.main.asyncAfter(deadline: .now()) {
                self.isLamicBtn.backgroundColor = ThemeHelper.lightGray
                self.normalBtn.backgroundColor = ThemeHelper.APP_COLOR
                self.isLamicBtn.setTitleColor(.label, for: .normal)
                self.normalBtn.setTitleColor(.white, for: .normal)
                self.calendarView.months.removeAll()
                self.calendarView.reloadData()
                self.calendarView.months = self.months
                self.setCurrentMonth()
                self.calendarView.reloadData()
                self.calendarView.scrollToItem(at: IndexPath(row: 0, section: 0), at: .centeredHorizontally, animated: false)
            }
        }
        
        calendarView.didEndScroll = { index in
            self.currentMonth.text = self.calendarView.months[index].monthTitle
            self.delegate?.monthDidDisplayed(monthIndex: index, month: self.calendarView.months[index])
        }
        
    }
    
    private func setCurrentMonth(){
        self.currentMonth.text = self.calendarView.months.first?.monthTitle
    }
}

private class RTLFlowLayout: UICollectionViewFlowLayout {
    
    override var flipsHorizontallyInOppositeLayoutDirection: Bool {
        return true
    }
}

//
//  CalendarModalViewController.swift
//  pophory-iOS
//
//  Created by 김다예 on 2023/07/05.
//

import UIKit

class CalendarModalViewController: BaseViewController {
    
    // MARK: - Properties
    
    weak var delegate: DateDataBind?
    
    // MARK: - UI Properties
    
    private lazy var calendar: UIDatePicker = {
        let picker = UIDatePicker()
        picker.datePickerMode = .date
        if #available(iOS 14.0, *) {
            picker.preferredDatePickerStyle = .inline
        } else { }
        picker.addTarget(self, action: #selector(onclickCalendar), for: .valueChanged)
        picker.locale = Locale(identifier: "en-us")
        picker.tintColor = .pophoryPurple
        return picker
    }()
    
    override func setupLayout() {
        super.setupLayout()
        
        view.addSubview(calendar)
        
        calendar.snp.makeConstraints {
            $0.top.equalToSuperview().inset(34)
            $0.leading.trailing.equalToSuperview().inset(16)
            $0.bottom.equalToSuperview().inset(50)
        }
    }
}

extension CalendarModalViewController {
    
    // MARK: - @objc
    
    @objc func onclickCalendar() {
        delegate?.dateDataBind(text:DateManager.dateToString(date: calendar.date))
        dismiss(animated: true)
    }
}

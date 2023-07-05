//
//  CalendarModalViewController.swift
//  pophory-iOS
//
//  Created by 김다예 on 2023/07/05.
//

import UIKit

class CalendarModalViewController: BaseViewController {
    
    // MARK: - Properties
    
    weak var delegate: DataBind?
    
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
            $0.edges.equalToSuperview().inset(16)
        }
    }
}

extension CalendarModalViewController {
    
    // MARK: - @objc
    @objc func onclickCalendar() {
        delegate?.stringDataBind(text:DateManager.dateToString(date: calendar.date))
        dismiss(animated: true)
    }
    
    // MARK: - Private Methods
}

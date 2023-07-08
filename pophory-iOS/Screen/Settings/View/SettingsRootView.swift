//
//  SettingsRootView.swift
//  pophory-iOS
//
//  Created by Danna Lee on 2023/07/08.
//

import UIKit

class SettingsRootView: UIView {
    
    // MARK: - UI Properties
    
    private lazy var settingTableView: UITableView = { createSettingTableView() }()
    
    // MARK: - Life Cycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension SettingsRootView {
    
    // MARK: - Layout
    
    private func setupLayout() {
        addSubview(settingTableView)
        
        settingTableView.snp.makeConstraints { (make) in
            make.top.equalTo(safeAreaLayoutGuide).offset(15)
            make.leading.trailing.bottom.equalTo(safeAreaLayoutGuide)
        }
    }
    
    private func createSettingTableView() -> UITableView {
        let tableView = UITableView(frame: .zero)
        
        tableView.register(SettingTableViewCell.self, forCellReuseIdentifier: SettingTableViewCell.identifier)
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.separatorInset = .init(top: 0, left: 20, bottom: 0, right: 20)
        
        return tableView
    }
}

extension SettingsRootView: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return SettingsData.list.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: SettingTableViewCell.identifier, for: indexPath) as? SettingTableViewCell else {
            return UITableViewCell()
        }
        
        cell.configCell(title: SettingsData.list[indexPath.row])
        
        return cell
    }
}

extension SettingsRootView: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 64
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.row {
        case 0:
            break
        case 1:
            break
        case 2:
            break
        case 3:
            break
        case 4:
            break
        default:
            break
        }
    }
}

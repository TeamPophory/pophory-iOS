//
//  StudioModalViewController.swift
//  pophory-iOS
//
//  Created by 김다예 on 2023/07/06.
//

import UIKit

class StudioModalViewController: BaseViewController {
    
    // MARK: - Properties
    
    private var numberOfStudio: Int = 12
    weak var delegate: StudioDataBind?
        
    // MARK: - UI Properties
    
    private let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 20
        return stackView
    }()
    
    private let studioLabel: UILabel = {
        let label = UILabel()
        label.text = "사진관 선택하기"
        label.font = .h2
        return label
    }()
    
    private let studioCollectionView: UICollectionView = {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.itemSize = CGSize(width: 104, height: 37)
        flowLayout.minimumLineSpacing = 12
        flowLayout.minimumInteritemSpacing = 12
        flowLayout.scrollDirection = .vertical
        
        let view = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        view.register(StudioCollectionViewCell.self, forCellWithReuseIdentifier: StudioCollectionViewCell.identifier)
        return view
    }()
    
    override func setupLayout() {
        super.setupLayout()
        
        view.addSubview(stackView)
        stackView.addArrangedSubviews([studioLabel, studioCollectionView])
        
        stackView.snp.makeConstraints {
            $0.top.equalToSuperview().inset(37)
            $0.leading.trailing.equalToSuperview().inset(19.5)
            $0.bottom.equalToSuperview()
        }
        
        studioCollectionView.dataSource = self
        studioCollectionView.delegate = self
    }
}

extension StudioModalViewController {
    
    // MARK: - @objc
    
//    @objc func onclickCalendar() {
//        delegate?.stringDataBind(text:DateManager.dateToString(date: studioCollectionView.date))
//        dismiss(animated: true)
//    }
    
    // MARK: - Private Methods
}

extension StudioModalViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return numberOfStudio
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: StudioCollectionViewCell.identifier, for: indexPath) as? StudioCollectionViewCell else { return UICollectionViewCell() }
//        cell.configCell(text: )
        return cell
    }
}

extension StudioModalViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        delegate?.studioDataBind(text: "인생네컷")
        dismiss(animated: true)
    }
}

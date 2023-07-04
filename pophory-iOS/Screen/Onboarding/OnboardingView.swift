//
//  OnboardingView.swift
//  pophory-iOS
//
//  Created by Joon Baek on 2023/07/04.
//

import UIKit

import SnapKit

final class OnboardingView: UIView {
    
    private lazy var pageControl: UIPageControl = {
        let pageControl = UIPageControl()
        pageControl.numberOfPages = 3
        pageControl.currentPageIndicatorTintColor = .pophoryGray500
        pageControl.pageIndicatorTintColor = .pophoryGray400
        return pageControl
    }()
    
    private lazy var contentCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        
        let collectionView = UICollectionView(frame: frame, collectionViewLayout: layout)
        collectionView.backgroundColor = .clear
        collectionView.contentInsetAdjustmentBehavior = .never
        collectionView.isPagingEnabled = true
        collectionView.isScrollEnabled = true
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.delegate = self
        collectionView.dataSource = self
        return collectionView
    }()
    
    private lazy var signupButton: UIButton = {
        let button = UIButton()
        button.setTitle("SNS로 간편 가입하기!", for: .normal)
        button.setTitleColor(UIColor.pophoryGray500, for: .normal)
        button.titleLabel?.font = .t1
        return button
    }()
    
    private lazy var appleSignInButton: PophoryButton = {
        let buttonBuilder = PophoryButtonBuilder()
            .setStyle(.primaryBlack)
            .setTitle(.startWithAppleID)
        return buttonBuilder.build()
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupRegisger()
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func dynamicMargin() -> CGFloat {
        let screenWidth = UIScreen.main.bounds.width
        let baseScreenWidth: CGFloat = 375
        let baseMargin: CGFloat = 20

        return (screenWidth / baseScreenWidth) * baseMargin
    }

}


// MARK: - Extensions

extension OnboardingView {
    
    private func setupRegisger() {
        contentCollectionView.register(OnboardingContentCollectionViewCell.self, forCellWithReuseIdentifier: OnboardingContentCollectionViewCell.identifier)
    }
    
    private func setupLayout() {
        addSubviews([pageControl, contentCollectionView, signupButton, appleSignInButton])

        pageControl.snp.makeConstraints {
            $0.top.equalTo(safeAreaLayoutGuide).offset(30)
            $0.centerX.equalToSuperview()
        }
        
        contentCollectionView.snp.makeConstraints {
            $0.top.equalTo(pageControl.snp.bottom).offset(22)
            $0.leading.trailing.equalToSuperview().inset(convertByWidthRatio(20))
//            $0.width.equalTo(335)
            $0.height.equalTo(480)
        }
        
        signupButton.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(contentCollectionView.snp.bottom).offset(85)
            $0.width.equalTo(appleSignInButton)
        }
        
        appleSignInButton.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.bottom.equalToSuperview().inset(43)
        }
        appleSignInButton.addCenterXConstraint(to: self)
    }
}

// MARK: - UICollectionViewDelegateFlowLayout
extension OnboardingView: UICollectionViewDelegateFlowLayout {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let pageNumber = round(scrollView.contentOffset.x / scrollView.frame.size.width)
        pageControl.currentPage = Int(pageNumber)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let contentWidth: CGFloat = convertByWidthRatio(335)
        let contentHeight: CGFloat = convertByHeightRatio(480)
        return CGSize(width: contentWidth, height: contentHeight)
    }
}

// MARK: - UICollectionViewDataSource
extension OnboardingView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let contentCell = collectionView.dequeueReusableCell(withReuseIdentifier: OnboardingContentCollectionViewCell.identifier, for: indexPath) as? OnboardingContentCollectionViewCell else { return UICollectionViewCell() }
        return contentCell
    }
}


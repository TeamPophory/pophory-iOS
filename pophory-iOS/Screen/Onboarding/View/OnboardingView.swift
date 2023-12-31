//
//  OnboardingView.swift
//  pophory-iOS
//
//  Created by Joon Baek on 2023/07/04.
//

import UIKit

import SnapKit
import AuthenticationServices

final class OnboardingView: UIView {
    
    private lazy var contentCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 0
        
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
    
    private lazy var pageControl: UIPageControl = {
        let pageControl = UIPageControl()
        pageControl.numberOfPages = onboardingImages.count
        pageControl.currentPageIndicatorTintColor = .pophoryGray500
        pageControl.pageIndicatorTintColor = .pophoryGray400
        return pageControl
    }()
    
    private lazy var signupButton: UIButton = {
        let button = UIButton()
        button.setTitle("SNS로 간편 가입하기!", for: .normal)
        button.setTitleColor(UIColor.pophoryGray500, for: .normal)
        button.titleLabel?.font = .text1
        button.removePadding()
        return button
    }()
    
    lazy var realAppleSignInButton: PophoryButton = {
        let buttonBuilder = PophoryButtonBuilder()
            .setStyle(.primaryBlack)
            .setTitle(.startWithAppleID)
            .setImage("apple.logo")
            .setImageInset(UIEdgeInsets(top: 0, left: -125, bottom: 0, right: 0))
            .setTitleInset(UIEdgeInsets(top: 0, left: -15, bottom: 0, right: 0))
            .setTintColor(.pophoryWhite)
            .setFont(.head3)
        return buttonBuilder.build()
    }()
    
    let onboardingImages: [UIImage] = [
        ImageLiterals.OnboardingImage1,
        ImageLiterals.OnboardingImage2,
        ImageLiterals.OnboardingImage3,
        ImageLiterals.OnboardingImage4
    ]
    
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
        addSubviews([realAppleSignInButton, signupButton, pageControl, contentCollectionView])
        
        realAppleSignInButton.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.leading.equalToSuperview().offset(20)
            $0.height.equalTo(60)
            $0.bottom.equalToSuperview().inset(11)
        }
        
        signupButton.snp.makeConstraints {
            $0.bottom.equalTo(realAppleSignInButton.snp.top).offset(-14)
            $0.centerX.horizontalEdges.equalTo(realAppleSignInButton)
        }
        
        contentCollectionView.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview()
            $0.top.equalToSuperview().offset( UIScreen.main.hasNotch ? 72 : 30)
            $0.height.equalTo(UIScreen.main.bounds.width * 480 / 375 )
        }
        
        pageControl.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(contentCollectionView.snp.bottom).offset(UIScreen.main.hasNotch ? 25 : -10)
        }

    }
}

// MARK: - UICollectionViewDelegateFlowLayout

extension OnboardingView: UICollectionViewDelegateFlowLayout {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let pageNumber = round(scrollView.contentOffset.x / scrollView.frame.size.width)
        pageControl.currentPage = Int(pageNumber)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let screenWidth = UIScreen.main.bounds.width
        let contentHeight: CGFloat = collectionView.frame.height
        return CGSize(width: screenWidth, height: contentHeight)
    }
}

// MARK: - UICollectionViewDataSource

extension OnboardingView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return onboardingImages.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let contentCell = collectionView.dequeueReusableCell(withReuseIdentifier: OnboardingContentCollectionViewCell.identifier, for: indexPath) as? OnboardingContentCollectionViewCell else { return UICollectionViewCell() }
        
        contentCell.configureImage(image: onboardingImages[indexPath.item])
        
        return contentCell
    }
}


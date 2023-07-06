//
//  PophoryNavigationConfigurator.swift
//  pophory-iOS
//
//  Created by Joon Baek on 2023/07/01.
//

/**
 1. Navigatable 프로토콜 채택
 2. var navigationBarTitleText: String? { return "회원가입" }
 3. viewWillAppear() {
 
 * rightButton 없을 때:
 setupNavigationBar(with: PophoryNavigationConfigurator.shared)
 * rightButton 있을 때:
 PophoryNavigationConfigurator.shared.configureNavigationBar(in: self, navigationController: navigationController!, showRightButton: true, rightButtonImageType: .plus)
 }
 */

import UIKit

import SnapKit

protocol NavigationConfigurator {
    func configureNavigationBar(in viewController: UIViewController, navigationController: UINavigationController, showRightButton: Bool, rightButtonImageType: PophoryNavigationConfigurator.RightButtonImageType?)
}

class PophoryNavigationConfigurator: NavigationConfigurator {
    
    static let shared = PophoryNavigationConfigurator()
    
    enum RightButtonImageType {
        case plus
        case delete
    }

    private init() {}
    
    func configureNavigationBar(in viewController: UIViewController, navigationController: UINavigationController, showRightButton: Bool, rightButtonImageType: RightButtonImageType? = nil) {
        let navBarHeight: CGFloat = 66.0
        let navBarViewTag = 1011 // Add a unique tag for the navBarView
        navigationController.navigationBar.subviews.forEach { subview in
            if subview.tag == navBarViewTag {
                subview.removeFromSuperview()
            }
        }

        let navBarView = UIView()
        navBarView.tag = navBarViewTag // Assign the unique tag
        navBarView.backgroundColor = .white
        navigationController.navigationBar.addSubview(navBarView)
        navigationController.navigationBar.sendSubviewToBack(navBarView)

        navBarView.snp.makeConstraints {
            $0.height.equalTo(navBarHeight)
            $0.width.equalTo(navigationController.navigationBar)
            $0.top.leading.trailing.equalToSuperview()
        }

        let titleLabel = setupTitleLabel(for: viewController, in: navigationController, navBarView: navBarView)
        let backButton = setupBackButton(for: viewController, in: navigationController, navBarView: navBarView)
        configureRightButton(in: viewController, navigationController: navigationController, navBarView: navBarView, backButton: backButton, showRightButton: showRightButton, rightButtonImageType: rightButtonImageType)
    }

    private func setupTitleLabel(for viewController: UIViewController, in navigationController: UINavigationController, navBarView: UIView) -> UILabel {
        let titleFont = UIFont.h2
        let titleColor = UIColor.pophoryBlack
        let titleText = (viewController as? Navigatable)?.navigationBarTitleText ?? viewController.title ?? "NavTitle"
        let titleLabel = UILabel()
        titleLabel.textAlignment = .center
        titleLabel.font = titleFont
        titleLabel.textColor = titleColor
        titleLabel.text = titleText
        navBarView.addSubview(titleLabel)

        titleLabel.snp.makeConstraints {
            $0.centerX.equalTo(navBarView)
            $0.centerY.equalToSuperview()
        }

        let titleAttributes: [NSAttributedString.Key: Any] = [
            .font: titleFont,
            .foregroundColor: titleColor
        ]
        navigationController.navigationBar.titleTextAttributes = titleAttributes

        viewController.navigationItem.title = titleText
        return titleLabel
    }

    private func setupBackButton(for viewController: UIViewController, in navigationController: UINavigationController, navBarView: UIView) -> UIButton {
        let backButton = UIButton()
        backButton.setImage(ImageLiterals.backButtonIcon, for: .normal)
        backButton.addTarget(viewController, action: #selector(BaseViewController.backButtonOnClick), for: .touchUpInside)
        navBarView.addSubview(backButton)

        backButton.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalToSuperview().offset(20)
            $0.size.equalTo(24)
        }
        return backButton
    }

    private func configureRightButton(in viewController: UIViewController, navigationController: UINavigationController, navBarView: UIView, backButton: UIButton, showRightButton: Bool, rightButtonImageType: RightButtonImageType?) {
        if showRightButton {
            let rightButton = UIButton()
            switch rightButtonImageType {
            case .plus:
                rightButton.setImage(ImageLiterals.myAlbumPlusButtonIcon, for: .normal)
            case .delete:
                rightButton.setImage(ImageLiterals.placeholderDeleteIcon, for: .normal)
            default:
                rightButton.setImage(nil, for: .normal)
            }
            rightButton.addTarget(viewController, action: #selector(BaseViewController.rightButtonOnClick), for: .touchUpInside)

            navBarView.addSubview(rightButton)

            rightButton.snp.makeConstraints {
                $0.centerY.equalToSuperview()
                $0.trailing.equalToSuperview().inset(20)
                $0.size.equalTo(24)
            }
        } else {
            navBarView.subviews.forEach { button in
                if let button = button as? UIButton, button != backButton {
                    button.removeFromSuperview()
                }
            }
        }
    }
}


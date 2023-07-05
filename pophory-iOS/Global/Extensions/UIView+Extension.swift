//
//  UIView+Extension.swift
//  ZKFace
//
//  Created by Danna Lee on 2023/05/19.
//

import UIKit

extension UIView {
    
    /// 한 번에 여러 개의 UIView 또는 UIView의 하위 클래스 객체들을 상위 UIView에 추가
    @discardableResult
    func addSubviews<T: UIView>(_ subviews: [T], then closure: (([T]) -> Void)? = nil) -> [T] {
        subviews.forEach { addSubview($0) }
        closure?(subviews)
        return subviews
    }
    
    /// UIView 의 모서리가 둥근 정도를 설정
    /// - Parameter radius: radius 값
    /// - Parameter maskedCorners: radius를 적용할 코너 지정
    func makeRounded(radius: CGFloat? = nil, maskedCorners: CACornerMask? = nil) {
        if let corners = maskedCorners {
            self.layer.maskedCorners = corners
        }
        
        if let cornerRadius = radius {
            self.layer.cornerRadius = cornerRadius
        }  else {
            self.layer.cornerRadius = self.layer.frame.height / 2
        }
        
        self.layer.masksToBounds = true
    }
    
    /// UIView에 그림자 설정
    func dropShadow(color: UIColor = .black,
                    offset: CGSize = CGSize(width: 0, height: 8.0),
                    opacity: Float = 0.3,
                    radius: CGFloat = 10) {
        layer.shadowColor = color.cgColor
        layer.shadowOffset = offset
        layer.shadowOpacity = opacity
        layer.shadowRadius = radius
        layer.masksToBounds = false
        
        layer.shouldRasterize = true
        layer.rasterizationScale = UIScreen.main.scale
    }
    
    /// UIView background color를 그라데이션으로 설정
    @discardableResult
    func setGradient(color1: UIColor,
                     color2: UIColor,
                     startPoint: CGPoint = CGPoint(x: 1.0, y: 0.0),
                     endPoint: CGPoint = CGPoint(x: 1.0, y: 1.0)) -> CALayer {
        let gradient: CAGradientLayer = CAGradientLayer()
        gradient.colors = [color1.cgColor, color2.cgColor]
        gradient.locations = [0.0 , 1.0]
        gradient.startPoint = startPoint
        gradient.endPoint = endPoint
        gradient.frame = bounds
        
        layer.insertSublayer(gradient, at: 0)
        
        return gradient
    }
    
    func findConstraint(of type: NSLayoutConstraint.Attribute) -> NSLayoutConstraint? {
        return constraints.first(where: { $0.firstAttribute == type && $0.secondAttribute == type })
    }
    
    func loadXib(_ nibName: String) {
        let nibs = Bundle.main.loadNibNamed(nibName, owner: self, options: nil)
        
        guard let customView = nibs?.first as? UIView else { return }
        customView.frame = self.bounds
        self.addSubview(customView)
    }
    
    func rotate() {
        let rotation : CABasicAnimation = CABasicAnimation(keyPath: "transform.rotation.z")
        rotation.toValue = NSNumber(value: Double.pi * 2)
        rotation.duration = 1
        rotation.isCumulative = true
        rotation.repeatCount = Float.greatestFiniteMagnitude
        self.layer.add(rotation, forKey: "rotationAnimation")
    }
    
    func getDeviceWidth() -> CGFloat {
        return UIScreen.main.bounds.width
    }
    
    func getDeviceHeight() -> CGFloat {
        return UIScreen.main.bounds.height
    }
    
    /// 아이폰 13 미니(width 375)를 기준으로 레이아웃을 잡고, 기기의 width 사이즈를 곱해 대응 값을 구할 때 사용
    func convertByWidthRatio(_ convert: CGFloat) -> CGFloat {
        return (convert / 375) * getDeviceWidth()
    }
    
    /// 아이폰 13 미니(height 812)를 기준으로 레이아웃을 잡고, 기기의 height 사이즈를 곱해 대응 값을 구할 때 사용
    func convertByHeightRatio(_ convert: CGFloat) -> CGFloat {
        return (convert / 812) * getDeviceHeight()
    }
    
    func shapeWithCustomCorners(topLeftRadius: CGFloat, topRightRadius: CGFloat, bottomLeftRadius: CGFloat, bottomRightRadius: CGFloat) {
        let path = UIBezierPath()
        
        // Top left corner
        path.move(to: CGPoint(x: 0, y: topLeftRadius))
        path.addArc(withCenter: CGPoint(x: topLeftRadius, y: topLeftRadius),
                    radius: topLeftRadius,
                    startAngle: CGFloat.pi,
                    endAngle: CGFloat.pi * 1.5,
                    clockwise: true)
        
        // Top right corner
        path.addLine(to: CGPoint(x: self.bounds.width - topRightRadius, y: 0))
        path.addArc(withCenter: CGPoint(x: self.bounds.width - topRightRadius, y: topRightRadius),
                    radius: topRightRadius,
                    startAngle: CGFloat.pi * 1.5,
                    endAngle: 0,
                    clockwise: true)
        
        // Bottom right corner
        path.addLine(to: CGPoint(x: self.bounds.width, y: self.bounds.height - bottomRightRadius))
        path.addArc(withCenter: CGPoint(x: self.bounds.width - bottomRightRadius, y: self.bounds.height - bottomRightRadius),
                    radius: bottomRightRadius,
                    startAngle: 0,
                    endAngle: CGFloat.pi * 0.5,
                    clockwise: true)
        
        // Bottom left corner
        path.addLine(to: CGPoint(x: bottomLeftRadius, y: self.bounds.height))
        path.addArc(withCenter: CGPoint(x: bottomLeftRadius, y: self.bounds.height - bottomLeftRadius),
                    radius: bottomLeftRadius,
                    startAngle: CGFloat.pi * 0.5,
                    endAngle: CGFloat.pi,
                    clockwise: true)
        
        path.close()
        
        let shapeLayer = CAShapeLayer()
        shapeLayer.path = path.cgPath
        self.layer.mask = shapeLayer
    }
}

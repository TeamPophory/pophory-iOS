//
//  QRScannerViewController.swift
//  pophory-iOS
//
//  Created by Joon Baek on 2023/10/06.
//

import AVFoundation
import UIKit

import SnapKit

// MARK: - QRScannerViewController

class QRScannerViewController: UIViewController {
    
    // MARK: - Properties
    
    private var captureSession: AVCaptureSession?
    private var previewLayer: AVCaptureVideoPreviewLayer?
    
    // MARK: - UI Properties
    
    private var overlayView = UIView()
    
    private lazy var backButton = UIBarButtonItem(image: ImageLiterals.backButtonIcon, style: .plain, target: self, action: #selector(onClickBackButton))
    
    private let scannerFrame = UIImageView(image: ImageLiterals.qrScannerFrame)
    
    private let scanQrCodeLabel: UILabel = {
        let label = UILabel()
        label.font = .head3
        label.textColor = .pophoryWhite
        label.text = "QR코드를 스캔해주세요"
        return label
    }()
    
    // MARK: - Life Cycle
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        setupQRScannerNavigationBar()
        
        if !(captureSession?.isRunning ?? false) {
            captureSession?.startRunning()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupCameraRequestAccess()
        setupOverlayView()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        displayPreview()
        self.navigationController?.navigationBar.layer.zPosition = 1
    }
    
    private func displayPreview() {
        guard let previewLayer = self.previewLayer else { return }

        previewLayer.frame = view.layer.bounds
        previewLayer.videoGravity = .resizeAspectFill

        if previewLayer.superlayer == nil {
            view.layer.insertSublayer(previewLayer, at: 0)
        }

        view.bringSubviewToFront(overlayView)
    }
}

// MARK: - Extensions

extension QRScannerViewController {
    
    // MARK: - Settings
    
    private func setupOverlayView() {
        overlayView.frame = UIScreen.main.bounds
        overlayView.backgroundColor = UIColor.black.withAlphaComponent(0)
        
        let clearSquareFrame = CGRect(x: (overlayView.bounds.width - 249) / 2, y: (overlayView.bounds.height - 249) / 2, width: 249, height: 249)
        let clearSquare = UIView(frame: clearSquareFrame)
        clearSquare.backgroundColor = UIColor.clear
        
        overlayView.addSubview(clearSquare)
        
        createTransparentArea(aroundRect: clearSquare.frame, inOverlayview :overlayView)
        
        view.addSubview(overlayView)
        overlayView.addSubviews([scannerFrame,scanQrCodeLabel])
        
        scannerFrame.snp.makeConstraints { make in
            make.edges.equalTo(clearSquare).inset(-3)
        }
        
        scanQrCodeLabel.snp.makeConstraints { make in
            make.top.equalTo(clearSquare.snp.bottom).offset(23)
            make.centerX.equalToSuperview()
        }
    }
    
    private func createTransparentArea(aroundRect rect:CGRect ,inOverlayview:UIView){
        let pathBigRect = UIBezierPath(rect:view.frame)
        let pathSmallRect = UIBezierPath(roundedRect: rect, cornerRadius: 12)
        pathBigRect.append(pathSmallRect)
        pathBigRect.usesEvenOddFillRule = true
        
        let fillLayer = CAShapeLayer()
        fillLayer.path = pathBigRect.cgPath
        fillLayer.fillRule = .evenOdd
        fillLayer.fillColor=UIColor(white: 0, alpha: 0.5).cgColor
        
        inOverlayview.layer.addSublayer(fillLayer)
    }
    
    private func setupQRScannerNavigationBar() {
        navigationController?.setNavigationBarHidden(false, animated: false)
        self.navigationItem.title = "QR로 등록하기"
        self.navigationItem.leftBarButtonItem = backButton
        self.navigationController?.navigationBar.tintColor = .pophoryBlack
        
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = .pophoryWhite
        appearance.titleTextAttributes = [.foregroundColor: UIColor.black]
        
        self.navigationController?.navigationBar.standardAppearance = appearance
        self.navigationController?.navigationBar.scrollEdgeAppearance = appearance
    }
    
    private func setupCameraRequestAccess() {
        AVCaptureDevice.requestAccess(for: .video, completionHandler: { (granted: Bool) in
            if granted {
                DispatchQueue.main.async {
                    self.setupCamera()
                }
            } else {
                // The access has not been granted.
            }
        })
    }
    
    private func setupCamera() {
        guard let captureDevice = AVCaptureDevice.default(for: .video) else { return }
        
        do {
            let input = try AVCaptureDeviceInput(device: captureDevice)
            self.captureSession = AVCaptureSession()
            self.captureSession?.addInput(input)
            
            let output = AVCaptureMetadataOutput()
            self.captureSession?.addOutput(output)
            
            output.setMetadataObjectsDelegate(self, queue: DispatchQueue.main)
            output.metadataObjectTypes = [.qr]
            
            self.previewLayer = AVCaptureVideoPreviewLayer(session: self.captureSession!)
            
            DispatchQueue.global().async { [weak self] in
                self?.captureSession?.startRunning()
            }
        } catch {
            print(error)
            return
        }
    }
    
    // MARK: - Custom Methods
    
    @objc func onClickBackButton() {
        self.navigationController?.dismiss(animated: true)
    }
    
    // QR코드 값을 처리
    func handleQRCode(_ value: String) {
        captureSession?.stopRunning()
        
        let downloadWebViewController = QRDownLoadWebViewController()
        
        // Pass the URL to the downloadWebViewController
        downloadWebViewController.urlString = value
        
        downloadWebViewController.modalPresentationStyle = .overFullScreen
        self.present(downloadWebViewController, animated: true)
    }
}

extension QRScannerViewController: AVCaptureMetadataOutputObjectsDelegate {
    // 캡처한 메타데이터를 처리하는 델리게이트 메서드
    func metadataOutput(_ output: AVCaptureMetadataOutput, didOutput metadataObjects: [AVMetadataObject], from connection: AVCaptureConnection) {
        if let metadataObject = metadataObjects.first {
            guard let readableObject = metadataObject as? AVMetadataMachineReadableCodeObject else { return }
            guard let stringValue = readableObject.stringValue else { return }
            
            handleQRCode(stringValue)
        }
    }
}

//
//  QRScannerViewController.swift
//  pophory-iOS
//
//  Created by Joon Baek on 2023/10/06.
//

import AVFoundation
import UIKit

// MARK: - QRScannerViewController

class QRScannerViewController: UIViewController, AVCaptureMetadataOutputObjectsDelegate {
    
    // MARK: - Properties
    
    var captureSession: AVCaptureSession?

    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupCameraRequestAccess()
        
        let downloadWebViewController = QRDownLoadWebViewController()
        present(downloadWebViewController, animated: true, completion: nil)
    }
}

// MARK: - Extensions

extension QRScannerViewController {
    
    // MARK: - Settings
    
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
            let captureSession = AVCaptureSession()
            captureSession.addInput(input)

            let output = AVCaptureMetadataOutput()
            captureSession.addOutput(output)

            output.setMetadataObjectsDelegate(self, queue: DispatchQueue.main)
            output.metadataObjectTypes = [.qr]

            let previewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
            previewLayer.frame = view.layer.bounds
            previewLayer.videoGravity = .resizeAspectFill
            view.layer.addSublayer(previewLayer)
            
            // 오래 걸릴 수 있는 작업이므로, 이를 메인 스레드에서 호출하면 UI가 멈추거나 반응하지 않을 수 있음
            DispatchQueue.global().async {
                captureSession.startRunning()
            }

        } catch {
            print(error)
            return
        }
    }
    
    // MARK: - Custom Methods
    
    // 캡처한 메타데이터를 처리하는 델리게이트 메서드
    func metadataOutput(_ output: AVCaptureMetadataOutput, didOutput metadataObjects: [AVMetadataObject], from connection: AVCaptureConnection) {
        if let metadataObject = metadataObjects.first {
            guard let readableObject = metadataObject as? AVMetadataMachineReadableCodeObject else { return }
            guard let stringValue = readableObject.stringValue else { return }
            handleQRCode(stringValue)
        }
    }

    // QR코드 값을 처리
    func handleQRCode(_ value: String) {
        let downloadWebViewController = QRDownLoadWebViewController()

        // Pass the URL to the downloadWebViewController
        downloadWebViewController.loadURL(value)

        present(downloadWebViewController, animated: true, completion: nil)
    }

}

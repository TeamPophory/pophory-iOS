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

        setupCamera()
    }
}

// MARK: - Extensions

extension QRScannerViewController {
    
    // MARK: - Settings
    
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

            captureSession.startRunning()

        } catch {
            print(error)
            return
        }
    }
    
    // MARK: - Custom Methods
    
    // Delegate method to handle captured metadata
    func metadataOutput(_ output: AVCaptureMetadataOutput, didOutput metadataObjects: [AVMetadataObject], from connection: AVCaptureConnection) {
        if let metadataObject = metadataObjects.first {
            guard let readableObject = metadataObject as? AVMetadataMachineReadableCodeObject else { return }
            guard let stringValue = readableObject.stringValue else { return }
            handleQRCode(stringValue)
        }
    }

    // Function to handle the QR code value
    func handleQRCode(_ value: String) {
        // Your logic to handle the QR code value
        print("QR Code Value: \(value)")

        // Create an instance of QRDownLoadWebViewController
        let downloadWebViewController = QRDownLoadWebViewController()

        // Pass the URL to the downloadWebViewController
        downloadWebViewController.loadURL(value)

        // Present the downloadWebViewController (or push if you are using navigation controller)
        present(downloadWebViewController, animated: true, completion: nil)
    }

}

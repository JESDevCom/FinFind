//
//  ViewController.swift
//  App Name: FinFind
//
//  Created by Johhn Eric Schulz on 4/18/18.
//  Copyright © 2018 John E Schulz. All rights reserved.
//
//  Written: SWIFT 4.0
//
//  Description:
//  * Use a trained .h5 keras/tensorflow model.
//  * Convert the python .h5 model with Apples coremltools to a .coreml model
//  * Import the .coreml model into Xcode
//  * Send RGB video data using AVKit and Vision API to the .coreml model
//  * Read the prediction = feature or ("Indetifier") in coreml terms
//  * Read the prediction = hypothesis or ("Confidence") in coreml terms float value
//  * Display Results to UILabel live
//  * Keep live view of camera displaying on screen in the UIView at all times
//

import UIKit
import AVKit
import CoreML
import ImageIO
import Vision

//++++++++++++++++++++++++ GLOBAL DECLARATION +++++++++++++++++++++++//
var Glob_Identifier: String = "Feature: None"
var Glob_Confidence: Float = 0.0

//+++++++++++++++++++++++++ UIVIEW CONTROLLER +++++++++++++++++++++++//
class ViewController: UIViewController, AVCaptureVideoDataOutputSampleBufferDelegate {
    
    //***************************************************************
    //          IBOutlet Declaration
    //***************************************************************
    @IBOutlet weak var IdentifierLabel: UILabel!
    @IBOutlet weak var ConfidenceLabel: UILabel!
    @IBOutlet weak var ImageView: UIImageView!
    @IBOutlet weak var FeatureView: UIView!
    
    //***************************************************************
    //          Main Override
    //***************************************************************
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Default Label
        ViewDidLoadInitialization()
        
        //Request AV Access for Capture Type = video
        let CaptureSession = AVCaptureSession()
        guard let CaptureDevice = AVCaptureDevice.default(for: .video) else { return }
        guard let VideoIn = try? AVCaptureDeviceInput(device: CaptureDevice) else {return}

        //Run
        CaptureSession.addInput(VideoIn)
        CaptureSession.startRunning()
        
        //Initialize Video Settings ---> Capture Session to the UIView in the App
        let previewLayer = AVCaptureVideoPreviewLayer(session: CaptureSession)
        self.ImageView.layer.addSublayer(previewLayer)
        previewLayer.frame = self.ImageView.layer.bounds
        previewLayer.videoGravity = AVLayerVideoGravity.resizeAspectFill //fill whole ImageView
        
        
        let VideoOut = AVCaptureVideoDataOutput()
        VideoOut.setSampleBufferDelegate(self, queue: DispatchQueue(label: "videoQueue"))
        CaptureSession.addOutput(VideoOut)
    }

    //***************************************************************
    //          captureOutput API
    // Grab images from buffer. This function automatically loops
    // to continue pushing out the newest frame.
    // Embedded Functions Here
    //***************************************************************
    
    func captureOutput(_ output: AVCaptureOutput, didOutput sampleBuffer: CMSampleBuffer, from connection: AVCaptureConnection){
        
        //Setup PixelBuffer
        guard let pixelBuffer: CVPixelBuffer = CMSampleBufferGetImageBuffer(sampleBuffer) else {return}
        
        //Access Model Results, Guard against nil results
        guard let keras_model = try? VNCoreMLModel(for: coreML().model) else {return}
        
        //UIKit Labels are not thread safe since they are background tasks
        //Must use Dispatch Func to update (Swift 3:4 safe)
        DispatchQueue.main.async (){
            self.IdentifierLabel.text = Glob_Identifier
            self.ConfidenceLabel.text = "\(String(format:"%.4f",Glob_Confidence))"
        }

        //Apply Neural Network
         let request = VNCoreMLRequest(model: keras_model) { (finished, error0) in
            
                ///Force Unwrap since the results will always be from Core ML model
                guard let hypothesis = finished.results as? [VNClassificationObservation] else { return }
            
                //Look for nil being passed
                if hypothesis.isEmpty {
                    Glob_Identifier = "Can't See"
                    }
                //Otherwise update label and print to console
                else {
                    
                    guard let Choice1 = hypothesis.first else {return}
                    //self.FeatureLabel.text = "Confidence: \(String(Choice1.confidence))"
                    print(Glob_Identifier, Choice1.confidence)
                    
                    if ( Choice1.confidence > 0.0 ){
                        Glob_Identifier = (hypothesis.first)!.identifier
                        Glob_Confidence = (hypothesis.first)!.confidence
                        
                    }
                }
        }
        try? VNImageRequestHandler(cvPixelBuffer: pixelBuffer, options: [:]).perform([request])

    }

    //***************************************************************
    //          (void)ViewDidLoadInitialization(void)
    // Set the UI visuals for UILabels and UIViews
    //***************************************************************
    func ViewDidLoadInitialization(){
        
        //Bring UILabels to the front incase they are behind something
        self.view.bringSubview(toFront: IdentifierLabel)
        self.view.bringSubview(toFront: ConfidenceLabel)
        
        //Round Corners of UILabels
        self.IdentifierLabel.layer.cornerRadius = 5
        self.ConfidenceLabel.layer.cornerRadius = 5
        
        //Set Font Color of UILabels
        self.IdentifierLabel.textColor = UIColor.lightGray
        self.ConfidenceLabel.textColor = UIColor.lightGray
        
        //Set Background Color of UILabels
        self.IdentifierLabel.backgroundColor = UIColor.clear
        self.ConfidenceLabel.backgroundColor = UIColor.clear
        
        //Set Text Alignment within UILabels
        self.IdentifierLabel.textAlignment = .center
        self.ConfidenceLabel.textAlignment = .center
        
        //Set Background color of Horizonatl UIStack
        FeatureView.backgroundColor = UIColor.clear
    }


}// end of ViewController




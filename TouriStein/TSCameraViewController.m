//
//  TSCameraController.m
//  TouriStein
//
//  Created by Gernot Poetsch on 16.05.14.
//  Copyright (c) 2014 TouriStein 3D. All rights reserved.
//

@import AVFoundation;

#import "TSCameraView.h"

#import "TSCameraViewController.h"

@interface TSCameraViewController () <AVCaptureMetadataOutputObjectsDelegate, AVCaptureVideoDataOutputSampleBufferDelegate>

@property AVCaptureSession *captureSession;
@property AVCaptureMetadataOutput *metadataOutput;
@property AVCaptureVideoDataOutput *videoDataOutput;

@property CIDetector *faceDetector;

@property TSCameraView *cameraView;

@end

@implementation TSCameraViewController

- (instancetype)init;
{
    self = [super init];
    if (self) {
        
        //Set up the Face detector
        self.faceDetector = [CIDetector detectorOfType:CIDetectorTypeFace context:nil options:@{CIDetectorAccuracy: CIDetectorAccuracyHigh}];
        
        //Get the Front Camera
        NSArray *devices = [AVCaptureDevice devicesWithMediaType:AVMediaTypeVideo];
        AVCaptureDevice *device = nil;
        for (AVCaptureDevice *deviceCandidate in devices) {
            if (deviceCandidate.position == AVCaptureDevicePositionFront) {
                device = deviceCandidate;
                break;
            }
        }
        
        self.captureSession = [[AVCaptureSession alloc] init];
        
        //Set the Input and Output
        NSError *inputError = nil;
        AVCaptureDeviceInput *input = [[AVCaptureDeviceInput alloc] initWithDevice:device error:&inputError];
        if (inputError) {
            NSLog(@"Error Opening Input: %@", inputError);
        } else {
            [self.captureSession addInput:input];
            
            self.metadataOutput = [[AVCaptureMetadataOutput alloc] init];
            [self.captureSession addOutput:self.metadataOutput];
            
            self.metadataOutput.metadataObjectTypes = @[AVMetadataObjectTypeFace];
            [self.metadataOutput setMetadataObjectsDelegate:self queue:dispatch_queue_create(nil, nil)];
            
            self.videoDataOutput = [[AVCaptureVideoDataOutput alloc] init];
            [self.videoDataOutput setSampleBufferDelegate:self queue:dispatch_queue_create(nil, nil)];
            [self.captureSession addOutput:self.videoDataOutput];
            
            [self.captureSession startRunning];
        }
    }
    return self;
}

- (void)dealloc;
{
    [self.captureSession stopRunning];
}

#pragma mark UIViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor greenColor];
    
    self.cameraView = [[TSCameraView alloc] initWithFrame:self.view.bounds session:self.captureSession];
    self.cameraView.autoresizingMask = (UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight);
    //[self.view addSubview:self.cameraView];
}


#pragma mark AVCaptureMetadataOutputObjectsDelegate

- (void)captureOutput:(AVCaptureOutput *)captureOutput didOutputMetadataObjects:(NSArray *)metadataObjects fromConnection:(AVCaptureConnection *)connection
{
    BOOL hasFace = (metadataObjects.count > 0);
    
    //Don't set all the time
    if (hasFace != self.hasFace) {
        self.hasFace = hasFace;
        NSLog(@"We have %@ face", hasFace ? @"a" : @"no");
    }
}

- (void)setHasFace:(BOOL)hasFace
{
    if (hasFace == _hasFace) {
        return;
    }
    _hasFace = hasFace;
    if (hasFace && [self.delegate respondsToSelector:@selector(cameraViewControllerFaceDidAppear:)]) {
        [self.delegate cameraViewControllerFaceDidAppear:self];
    }
    
    if (!hasFace && [self.delegate respondsToSelector:@selector(cameraViewControllerFaceDidDisappear:)]) {
        [self.delegate cameraViewControllerFaceDidDisappear:self];
    }
}

#pragma mark AVCaptureVideoDataOutputSampleBufferDelegate

- (void)captureOutput:(AVCaptureOutput *)captureOutput didDropSampleBuffer:(CMSampleBufferRef)sampleBuffer fromConnection:(AVCaptureConnection *)connection
{
    //NSLog(@"Dropped a frame :-(");
}

- (void)captureOutput:(AVCaptureOutput *)captureOutput didOutputSampleBuffer:(CMSampleBufferRef)sampleBuffer fromConnection:(AVCaptureConnection *)connection
{
    CIImage *image = [CIImage imageWithCVPixelBuffer:CMSampleBufferGetImageBuffer(sampleBuffer) options:nil];
    NSArray *features = [self.faceDetector featuresInImage:image options:@{CIDetectorImageOrientation: @6,
                                                                           CIDetectorSmile: @YES}];
    for (CIFaceFeature *feature in features) {
        if (feature.hasSmile) {
            if ([self.delegate respondsToSelector:@selector(cameraViewControllerDidDetectHappyTourist:)]) {
                [self.delegate cameraViewControllerDidDetectHappyTourist:self];
            }
        } else {
            if ([self.delegate respondsToSelector:@selector(cameraViewControllerDidDetectSadTourist:)]) {
                [self.delegate cameraViewControllerDidDetectSadTourist:self];
            }
        }
    }
}

@end

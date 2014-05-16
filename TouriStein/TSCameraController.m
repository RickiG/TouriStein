//
//  TSCameraController.m
//  TouriStein
//
//  Created by Gernot Poetsch on 16.05.14.
//  Copyright (c) 2014 TouriStein 3D. All rights reserved.
//

@import AVFoundation;

#import "TSCameraController.h"

@interface TSCameraController () <AVCaptureMetadataOutputObjectsDelegate>

@property AVCaptureSession *captureSession;
@property AVCaptureMetadataOutput *metadataOutput;

@end

@implementation TSCameraController

- (instancetype)init;
{
    self = [super init];
    if (self) {
        
        NSArray *devices = [AVCaptureDevice devicesWithMediaType:AVMediaTypeVideo];
        
        //Get the Front Camera
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
            
            [self.captureSession startRunning];
        }
    }
    return self;
}

- (void)dealloc;
{
    [self.captureSession stopRunning];
}

#pragma mark AVCaptureMetadataOutputObjectsDelegate

- (void)captureOutput:(AVCaptureOutput *)captureOutput didOutputMetadataObjects:(NSArray *)metadataObjects fromConnection:(AVCaptureConnection *)connection
{
    if (metadataObjects.count > 0) {
        NSLog(@"Got a Face!");
    }
}

@end

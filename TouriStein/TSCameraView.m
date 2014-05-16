//
//  TSCameraView.m
//  TouriStein
//
//  Created by Gernot Poetsch on 16.05.14.
//  Copyright (c) 2014 TouriStein 3D. All rights reserved.
//

@import AVFoundation;

#import "TSCameraView.h"

@interface TSCameraView ()

@property AVCaptureVideoPreviewLayer *previewLayer;

@end

@implementation TSCameraView

- (id)initWithFrame:(CGRect)frame session:(AVCaptureSession *)session;
{
    self = [super initWithFrame:frame];
    if (self) {
        self.previewLayer = [[AVCaptureVideoPreviewLayer alloc] initWithSession:session];
        self.previewLayer.frame = self.layer.bounds;
        self.previewLayer.videoGravity = AVLayerVideoGravityResizeAspectFill;
        [self.layer addSublayer:self.previewLayer];
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    self.previewLayer.frame = self.layer.bounds;
}

@end

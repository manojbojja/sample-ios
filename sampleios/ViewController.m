//
//  ViewController.m
//  sampleios
//
//  Created by Administrator on 10/16/19.
//  Copyright © 2019 Administrator. All rights reserved.
//

#import "ViewController.h"
#import <StripeTerminal/StripeTerminal.h>

@interface ViewController ()<SCPDiscoveryDelegate, SCPTerminalDelegate>

@property (nonatomic, nullable, strong) SCPCancelable *discoverCancelable;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)connectReaderAction: (NSString *) scanType {
    SCPDiscoveryConfiguration *config = nil;
    NSLog(scanType);
    if ([scanType isEqualToString:@"scan"]) {
        config = [[SCPDiscoveryConfiguration alloc] initWithDeviceType:SCPDeviceTypeChipper2X discoveryMethod:SCPDiscoveryMethodBluetoothScan simulated:NO];
    } else {
        config = [[SCPDiscoveryConfiguration alloc] initWithDeviceType:SCPDeviceTypeChipper2X discoveryMethod:SCPDiscoveryMethodBluetoothProximity simulated:NO];
    }
    
    self.discoverCancelable = [[SCPTerminal shared] discoverReaders:config delegate:self completion:^(NSError *error) {
        if (error != nil) {
            NSLog(@"discoverReaders failed: %@", error);
            self.statusLabel.text = error.localizedDescription;
        }
        else {
            NSLog(@"discoverReaders succeeded");
            self.statusLabel.text = @"discoverReaders succeeded";
        }
    }];
}

- (void)terminal:(SCPTerminal *)terminal didUpdateDiscoveredReaders:(NSArray<SCPReader *> *)readers {
    // Just select the first reader in this example
    SCPReader *selectedReader = [readers firstObject];
    // Only connect if we aren't currently connected.
    if (terminal.connectionStatus != SCPConnectionStatusNotConnected) {
        return;
    }

    // In your app, display the discovered reader(s) to the user.
    // Call `connectReader` with the selected reader.
    [[SCPTerminal shared] connectReader:selectedReader completion:^(SCPReader *reader, NSError *error) {
        if (reader != nil) {
            NSLog(@"Successfully connected to reader: %@", reader);
        }
        else {
            NSLog(@"connectReader failed: %@", error);
        }
    }];
}

- (IBAction)triggerDiscover:(id)sender {
    [self connectReaderAction:@"proximity"];
}

- (IBAction)triggerDiscoverByScan:(id)sender {
    [self connectReaderAction:@"scan"];
}




@end

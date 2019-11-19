//
//  DisplayFreeBoundVehicleViewController.m
//  TaxiApp
//
//  Created by Dipak V. Vyawahare on 19/11/19.
//  Copyright © 2019 MyOrganization. All rights reserved.
//

#import "DisplayFreeBoundVehicleViewController.h"
#import "TaxiApp-Swift.h"

@interface DisplayFreeBoundVehicleViewController () {
    VehiclesViewModel * viewModel;
}
    @property(nonatomic, strong) IBOutlet MapView * mapView;
    @property(nonatomic, strong) VehiclesMapDataSource * dataSource;
    @property(nonatomic, strong) VehicleMapViewDelegate * mapViewConfigurator;
    @end

@implementation DisplayFreeBoundVehicleViewController
    
- (void)viewDidLoad {
    [super viewDidLoad];
    self.dataSource = [[VehiclesMapDataSource alloc] init];
    self.mapViewConfigurator = [[VehicleMapViewDelegate alloc] init];
    self.mapView.dataSource = self.dataSource;
    self.mapView.delegate = self.mapViewConfigurator;
    
    __weak typeof(self) weakSelf = self;
    [self.dataSource.data addAndNotifyWithObserver:self
                                 completionHandler:^() {
                                     [weakSelf.mapView reloadAnnotations];
                                 }];
    
    [self viewModel].onErrorHandling = ^(ErrorResult *error) {
        [weakSelf showAlert: error.message];
    };
   
    [self viewModel].fetchProgress = ^(BOOL isLoading) {
        if(isLoading) {
            [[PKHUD sharedHUD] showOnView: nil];
        } else {
            [[PKHUD sharedHUD] hideWithAnimated: true
                                     completion: nil];
        }
    };
    
    self.mapViewConfigurator.delegate = [self viewModel];
    [self.mapView resetFocus];
    
}
    
-(void) viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [viewModel cancelFetching];
}
    
-(VehiclesViewModel *) viewModel {
    if (viewModel == nil) {
        viewModel = [[VehiclesViewModel alloc] initWithDataSources: @[self.dataSource]];
    }
    return viewModel;
}
    
-(IBAction) backButtonPressed {
    [self.navigationController popViewControllerAnimated: true];
}
    
-(void) showAlert:(NSString *) message {
    __weak typeof(self) weakSelf = self;
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"An error occured"
                                                                   message:message
                                                            preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *action = [UIAlertAction actionWithTitle:@"Close"
                                                     style:UIAlertActionStyleDefault
                                                   handler:^(UIAlertAction * action) {
                                                       [weakSelf backButtonPressed];
                                                   }];
    [alert addAction:action];
    [self.view.window.rootViewController presentViewController:alert animated:YES completion:nil];
}
    
    @end


// Created by Sinisa Drpa, 2015.

#import "ViewController.h"
#import "EZPClient+Address.h"

@interface ViewController ()
@property (strong) EZPClient *easyPostClient;
@end

@implementation ViewController

- (void)awakeFromNib
{
    self.easyPostClient = [EZPClient defaultClient];
    NSAssert(![self.easyPostClient.APISecretKey isEqualToString:@"YOUR_TEST_API_KEY"],
             @"Don't forget to use your real EasyPost API key");
    NSAssert(![self.easyPostClient.APISecretKey isEqualToString:@"YOUR_LIVE_API_KEY"],
             @"Don't forget to use your real EasyPost API key");
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)createAddress:(UIButton *)sender {
    [self.easyPostClient createAddressWithParameters:[self addressParameters]
                                          completion:^(EZPAddress *address, NSError *error) {
        if (error) {
            NSLog(@"Error: %@", [error localizedDescription]);
        }
        NSLog(@"Address: %@", address);
    }];
}

- (NSDictionary *)addressParameters {
    NSDictionary *parameters = @{@"address[name]": @"Dr. Steve Brule",
                                 @"address[street1]": @"179 N Harbor Dr",
                                 @"address[city]": @"Redondo Beach",
                                 @"address[state]": @"CA",
                                 @"address[zip]": @"90277",
                                 @"address[country]": @"US",
                                 @"address[email]": @"dr_steve_brule@gmail.com"
                                 };
    return parameters;
}

@end


#import <UIKit/UIKit.h>
#import "aNasssfggvifsgastionTehemde.h"

NS_ASSUME_NONNULL_BEGIN

typedef void (^NavigationIntialSetup)(aNasssfggvifsgastionTehemde *);

@interface BsTableViewController : UITableViewController

@property (nullable, copy, nonatomic) NavigationIntialSetup navigationSetup;

@end

NS_ASSUME_NONNULL_END

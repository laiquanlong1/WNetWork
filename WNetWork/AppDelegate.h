//
//  AppDelegate.h
//  WNetWork
//
//  Created by HoTia on 15/9/6.
//  Copyright (c) 2015年 will. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>
#import "WNetCheck.h"


@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (nonatomic, strong) WNetCheck *netCheck;

@property (strong, nonatomic) UIWindow *window;

@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;

- (void)saveContext;
- (NSURL *)applicationDocumentsDirectory;


@end


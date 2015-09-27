//
//  AppDelegate.h
//  DayCounter + Schedule
//
//  Created by Sam Kim on 9/11/14.
//  Last edited on 6/2/15.
//

#import <Cocoa/Cocoa.h>

@interface AppDelegate : NSObject <NSApplicationDelegate> {
    NSInteger dayNumber;
    NSInteger assemblyState;
    NSInteger specialState;
    
    NSString *APeriodName;
    NSString *BPeriodName;
    NSString *CPeriodName;
    NSString *DPeriodName;
    NSString *EPeriodName;
    NSString *FPeriodName;
    NSString *GPeriodName;
    
    IBOutlet NSMenu *dctMenu;
    NSStatusItem *dctMenuItem;
    IBOutlet NSMenuItem *dctAssemblyMenuItem;
    IBOutlet NSMenuItem *dctSpecialMenuItem;
    IBOutlet NSMenuItem *dctDay0MenuItem;
    IBOutlet NSMenuItem *dctDay1MenuItem;
    IBOutlet NSMenuItem *dctDay2MenuItem;
    IBOutlet NSMenuItem *dctDay3MenuItem;
    IBOutlet NSMenuItem *dctDay4MenuItem;
    IBOutlet NSMenuItem *dctDay5MenuItem;
    IBOutlet NSMenuItem *dctDay6MenuItem;
    IBOutlet NSMenuItem *dctDay7MenuItem;
    IBOutlet NSMenuItem *dctDaySpecialMenuItem;
    
    IBOutlet NSMenu *schMenu;
    NSStatusItem *schMenuItem;
    IBOutlet NSMenuItem *schDay1MenuItem;
    IBOutlet NSMenuItem *schDay2MenuItem;
    IBOutlet NSMenuItem *schDay3MenuItem;
    IBOutlet NSMenuItem *schDay4MenuItem;
    IBOutlet NSMenuItem *schDay5MenuItem;
    IBOutlet NSMenuItem *schDay6MenuItem;
    IBOutlet NSMenuItem *schDay7MenuItem;
    IBOutlet NSMenu *schDay1Menu;
    IBOutlet NSMenu *schDay2Menu;
    IBOutlet NSMenu *schDay3Menu;
    IBOutlet NSMenu *schDay4Menu;
    IBOutlet NSMenu *schDay5Menu;
    IBOutlet NSMenu *schDay6Menu;
    IBOutlet NSMenu *schDay7Menu;
    
    IBOutlet NSTextField *inputAPeriod;
    IBOutlet NSTextField *inputBPeriod;
    IBOutlet NSTextField *inputCPeriod;
    IBOutlet NSTextField *inputDPeriod;
    IBOutlet NSTextField *inputEPeriod;
    IBOutlet NSTextField *inputFPeriod;
    IBOutlet NSTextField *inputGPeriod;
    
    IBOutlet NSWindow *settingsWindow;
    
    NSTimer *schTimer;
    NSDateComponents *nowDateComponents;
    NSInteger nowInMinutes;
    NSInteger nowPeriod;
}

- (IBAction)dctNextDay:(id)sender;
- (IBAction)dctDay0:(id)sender;
- (IBAction)dctDay1:(id)sender;
- (IBAction)dctDay2:(id)sender;
- (IBAction)dctDay3:(id)sender;
- (IBAction)dctDay4:(id)sender;
- (IBAction)dctDay5:(id)sender;
- (IBAction)dctDay6:(id)sender;
- (IBAction)dctDay7:(id)sender;
- (IBAction)dctDaySpecial:(id)sender;
- (IBAction)dctAssembly:(id)sender;
- (IBAction)dctSpecial:(id)sender;
- (IBAction)openSettings:(id)sender;
- (IBAction)saveSettings:(id)sender;

@end
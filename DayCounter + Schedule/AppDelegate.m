//
//  AppDelegate.m
//  DayCounter + Schedule
//
//  Created by Sam Kim on 9/11/14.
//  Last edited on 6/4/15.
//

#import "AppDelegate.h"

@implementation AppDelegate

- (IBAction)dctNextDay:(id)sender {
    if (dayNumber==7) {
        dayNumber = 1;
    } else {
        dayNumber += 1;
    }
    [self dctProcessing];
}

- (IBAction)dctDay0:(id)sender {
    dayNumber = 0;
    [dctDay0MenuItem setState:NSOnState];
    [self dctProcessing];
}

- (IBAction)dctDay1:(id)sender {
    dayNumber = 1;
    [dctDay1MenuItem setState:NSOnState];
    [self dctProcessing];
}

- (IBAction)dctDay2:(id)sender {
    dayNumber = 2;
    [dctDay2MenuItem setState:NSOnState];
    [self dctProcessing];
}

- (IBAction)dctDay3:(id)sender {
    dayNumber = 3;
    [dctDay3MenuItem setState:NSOnState];
    [self dctProcessing];
}

- (IBAction)dctDay4:(id)sender {
    dayNumber = 4;
    [dctDay4MenuItem setState:NSOnState];
    [self dctProcessing];
}

- (IBAction)dctDay5:(id)sender {
    dayNumber = 5;
    [dctDay5MenuItem setState:NSOnState];
    [self dctProcessing];
}

- (IBAction)dctDay6:(id)sender {
    dayNumber = 6;
    [dctDay6MenuItem setState:NSOnState];
    [self dctProcessing];
}

- (IBAction)dctDay7:(id)sender {
    dayNumber = 7;
    [dctDay7MenuItem setState:NSOnState];
    [self dctProcessing];
}

- (IBAction)dctDaySpecial:(id)sender {
    dayNumber = -1;
    [dctDaySpecialMenuItem setState:NSOnState];
    [self dctProcessing];
}

- (IBAction)dctAssembly:(id)sender {
    if (assemblyState == 1) {
        [self assemblyOff];
    } else {
        [self assemblyOn];
    }
}

- (IBAction)dctSpecial:(id)sender {
    if (specialState == 1) {
        [self specialOff];
    } else {
        [self specialOn];
    }
}

- (IBAction)openSettings:(id)sender {
    [NSApp activateIgnoringOtherApps:YES];
    [settingsWindow makeKeyAndOrderFront:nil];
}

- (IBAction)saveSettings:(id)sender {
    APeriodName = [inputAPeriod stringValue];
    BPeriodName = [inputBPeriod stringValue];
    CPeriodName = [inputCPeriod stringValue];
    DPeriodName = [inputDPeriod stringValue];
    EPeriodName = [inputEPeriod stringValue];
    FPeriodName = [inputFPeriod stringValue];
    GPeriodName = [inputGPeriod stringValue];
    
    [[NSUserDefaults standardUserDefaults] setObject:APeriodName forKey:@"APeriodNameKey"];
    [[NSUserDefaults standardUserDefaults] setObject:BPeriodName forKey:@"BPeriodNameKey"];
    [[NSUserDefaults standardUserDefaults] setObject:CPeriodName forKey:@"CPeriodNameKey"];
    [[NSUserDefaults standardUserDefaults] setObject:DPeriodName forKey:@"DPeriodNameKey"];
    [[NSUserDefaults standardUserDefaults] setObject:EPeriodName forKey:@"EPeriodNameKey"];
    [[NSUserDefaults standardUserDefaults] setObject:FPeriodName forKey:@"FPeriodNameKey"];
    [[NSUserDefaults standardUserDefaults] setObject:GPeriodName forKey:@"GPeriodNameKey"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    [settingsWindow close];
    [self dctProcessing];
}

- (void)assemblyOff {
    assemblyState = 0;
    [[NSUserDefaults standardUserDefaults] setInteger:assemblyState forKey:@"assemblyStateKey"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    [dctAssemblyMenuItem setState:NSOffState];
    if (dayNumber != -1) {
        if (specialState == 0) {
            [dctMenuItem setTitle:[NSString stringWithFormat:@"Day %ld",dayNumber]];
        } else {
            [dctMenuItem setTitle:[NSString stringWithFormat:@"Day %ld*",dayNumber]];
        }
    } else {
        [dctMenuItem setTitle:@"Day ★"];
    }
    [self schWipeMenus];
    if (specialState == 0) {
        [self schFillMenus];
    } else {
        [self schFillMenusSpecial];
    }
    [schMenuItem setImage:[NSImage imageNamed:@"iconTemplate.png"]];
}

- (void)assemblyOn {
    assemblyState = 1;
    [[NSUserDefaults standardUserDefaults] setInteger:assemblyState forKey:@"assemblyStateKey"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    [dctAssemblyMenuItem setState:NSOnState];
    if (dayNumber != -1) {
        if (specialState == 0) {
            [dctMenuItem setTitle:[NSString stringWithFormat:@"Day %ldA",dayNumber]];
        } else {
            [dctMenuItem setTitle:[NSString stringWithFormat:@"Day %ldA*",dayNumber]];
        }
    } else {
        [dctMenuItem setTitle:@"Day ★A"];
    }
    [self schWipeMenus];
    if (specialState == 0) {
        [self schFillMenusAssembly];
    } else {
        [self schFillMenusSpecialAssembly];
    }
    [schMenuItem setImage:[NSImage imageNamed:@"iconAltTemplate.png"]];
}

- (void)specialOff {
    specialState = 0;
    [[NSUserDefaults standardUserDefaults] setInteger:specialState forKey:@"specialStateKey"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    [dctSpecialMenuItem setState:NSOffState];
    if (dayNumber != -1) {
        if (assemblyState == 0) {
            [dctMenuItem setTitle:[NSString stringWithFormat:@"Day %ld",dayNumber]];
        } else {
            [dctMenuItem setTitle:[NSString stringWithFormat:@"Day %ldA",dayNumber]];
        }
    } else {
        if (assemblyState == 0) {
            [dctMenuItem setTitle:@"Day ★"];
        } else {
            [dctMenuItem setTitle:@"Day ★A"];
        }
    }
    [self schWipeMenus];
    if (assemblyState == 0) {
        [self schFillMenus];
    } else {
        [self schFillMenusAssembly];
    }
}

- (void)specialOn {
    specialState = 1;
    [[NSUserDefaults standardUserDefaults] setInteger:specialState forKey:@"specialStateKey"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    [dctSpecialMenuItem setState:NSOnState];
    if (assemblyState == 0) {
        [dctMenuItem setTitle:[NSString stringWithFormat:@"Day %ld*",dayNumber]];
    } else {
        [dctMenuItem setTitle:[NSString stringWithFormat:@"Day %ldA*",dayNumber]];
    }
    [self schWipeMenus];
    if (assemblyState == 0) {
        [self schFillMenusSpecial];
    } else {
        [self schFillMenusSpecialAssembly];
    }
}

- (void)dctProcessing {
    if (dayNumber != -1) {
        [dctSpecialMenuItem setTarget:self];
        [dctSpecialMenuItem setAction:@selector(dctSpecial:)];
        if (assemblyState == 0) {
            if (specialState == 0) {
                [dctMenuItem setTitle:[NSString stringWithFormat:@"Day %ld",dayNumber]];
            } else {
                [dctMenuItem setTitle:[NSString stringWithFormat:@"Day %ld*",dayNumber]];
            }
        } else {
            if (specialState == 0) {
                [dctMenuItem setTitle:[NSString stringWithFormat:@"Day %ldA",dayNumber]];
            } else {
                [dctMenuItem setTitle:[NSString stringWithFormat:@"Day %ldA*",dayNumber]];
            }
        }
    } else {
        [dctSpecialMenuItem setTarget:nil];
        [dctSpecialMenuItem setAction:nil];
        [self specialOff];
        if (assemblyState == 0) {
            [dctMenuItem setTitle:@"Day ★"];
        } else {
            [dctMenuItem setTitle:@"Day ★A"];
        }
    }
    [[NSUserDefaults standardUserDefaults] setInteger:dayNumber forKey:@"dayNumberKey"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    [schDay1MenuItem setState:NSOffState];
    [schDay2MenuItem setState:NSOffState];
    [schDay3MenuItem setState:NSOffState];
    [schDay4MenuItem setState:NSOffState];
    [schDay5MenuItem setState:NSOffState];
    [schDay6MenuItem setState:NSOffState];
    [schDay7MenuItem setState:NSOffState];
    if (dayNumber == 1) {
        [schDay1MenuItem setState:NSOnState];
    } else if (dayNumber == 2) {
        [schDay2MenuItem setState:NSOnState];
    } else if (dayNumber == 3) {
        [schDay3MenuItem setState:NSOnState];
    } else if (dayNumber == 4) {
        [schDay4MenuItem setState:NSOnState];
    } else if (dayNumber == 5) {
        [schDay5MenuItem setState:NSOnState];
    } else if (dayNumber == 6) {
        [schDay6MenuItem setState:NSOnState];
    } else if (dayNumber == 7) {
        [schDay7MenuItem setState:NSOnState];
    }
}

- (void)schWipeMenus {
    [schDay1Menu removeAllItems];
    [schDay2Menu removeAllItems];
    [schDay3Menu removeAllItems];
    [schDay4Menu removeAllItems];
    [schDay5Menu removeAllItems];
    [schDay6Menu removeAllItems];
    [schDay7Menu removeAllItems];
}

- (void)schFillMenus {
    [schDay1Menu addItemWithTitle:@"8:15 - 9:05" action:nil keyEquivalent:@""];
    [schDay1Menu addItemWithTitle:[NSString stringWithFormat:@"B: %@", BPeriodName] action:@selector(action:) keyEquivalent:@""];
    [schDay1Menu addItem:[NSMenuItem separatorItem]];
    [schDay1Menu addItemWithTitle:@"9:30 - 10:20" action:nil keyEquivalent:@""];
    [schDay1Menu addItemWithTitle:[NSString stringWithFormat:@"C: %@", CPeriodName] action:@selector(action:) keyEquivalent:@""];
    [schDay1Menu addItemWithTitle:@"10:25 - 11:15" action:nil keyEquivalent:@""];
    [schDay1Menu addItemWithTitle:[NSString stringWithFormat:@"D: %@", DPeriodName] action:@selector(action:) keyEquivalent:@""];
    [schDay1Menu addItem:[NSMenuItem separatorItem]];
    [schDay1Menu addItemWithTitle:@"11:55 - 12:45" action:nil keyEquivalent:@""];
    [schDay1Menu addItemWithTitle:[NSString stringWithFormat:@"G: %@", GPeriodName] action:@selector(action:) keyEquivalent:@""];
    [schDay1Menu addItem:[NSMenuItem separatorItem]];
    [schDay1Menu addItemWithTitle:@"1:30 - 2:20" action:nil keyEquivalent:@""];
    [schDay1Menu addItemWithTitle:[NSString stringWithFormat:@"F: %@", FPeriodName] action:@selector(action:) keyEquivalent:@""];
    [schDay1Menu addItemWithTitle:@"2:25 - 3:15" action:nil keyEquivalent:@""];
    [schDay1Menu addItemWithTitle:[NSString stringWithFormat:@"E: %@", EPeriodName] action:@selector(action:) keyEquivalent:@""];
    
    [schDay2Menu addItemWithTitle:@"8:15 - 9:05" action:nil keyEquivalent:@""];
    [schDay2Menu addItemWithTitle:[NSString stringWithFormat:@"C: %@", CPeriodName] action:@selector(action:) keyEquivalent:@""];
    [schDay2Menu addItem:[NSMenuItem separatorItem]];
    [schDay2Menu addItemWithTitle:@"9:30 - 10:20" action:nil keyEquivalent:@""];
    [schDay2Menu addItemWithTitle:[NSString stringWithFormat:@"A: %@", APeriodName] action:@selector(action:) keyEquivalent:@""];
    [schDay2Menu addItemWithTitle:@"10:25 - 11:15" action:nil keyEquivalent:@""];
    [schDay2Menu addItemWithTitle:[NSString stringWithFormat:@"D: %@", DPeriodName] action:@selector(action:) keyEquivalent:@""];
    [schDay2Menu addItem:[NSMenuItem separatorItem]];
    [schDay2Menu addItemWithTitle:@"11:55 - 12:45" action:nil keyEquivalent:@""];
    [schDay2Menu addItemWithTitle:[NSString stringWithFormat:@"F: %@", FPeriodName] action:@selector(action:) keyEquivalent:@""];
    [schDay2Menu addItem:[NSMenuItem separatorItem]];
    [schDay2Menu addItemWithTitle:@"1:30 - 2:20" action:nil keyEquivalent:@""];
    [schDay2Menu addItemWithTitle:[NSString stringWithFormat:@"E: %@", EPeriodName] action:@selector(action:) keyEquivalent:@""];
    [schDay2Menu addItemWithTitle:@"2:25 - 3:15" action:nil keyEquivalent:@""];
    [schDay2Menu addItemWithTitle:[NSString stringWithFormat:@"G: %@", GPeriodName] action:@selector(action:) keyEquivalent:@""];
    
    [schDay3Menu addItemWithTitle:@"8:15 - 9:05" action:nil keyEquivalent:@""];
    [schDay3Menu addItemWithTitle:[NSString stringWithFormat:@"A: %@", APeriodName] action:@selector(action:) keyEquivalent:@""];
    [schDay3Menu addItem:[NSMenuItem separatorItem]];
    [schDay3Menu addItemWithTitle:@"9:30 - 10:20" action:nil keyEquivalent:@""];
    [schDay3Menu addItemWithTitle:[NSString stringWithFormat:@"B: %@", BPeriodName] action:@selector(action:) keyEquivalent:@""];
    [schDay3Menu addItemWithTitle:@"10:25 - 11:15" action:nil keyEquivalent:@""];
    [schDay3Menu addItemWithTitle:[NSString stringWithFormat:@"D: %@", DPeriodName] action:@selector(action:) keyEquivalent:@""];
    [schDay3Menu addItem:[NSMenuItem separatorItem]];
    [schDay3Menu addItemWithTitle:@"11:55 - 12:45" action:nil keyEquivalent:@""];
    [schDay3Menu addItemWithTitle:[NSString stringWithFormat:@"G: %@", GPeriodName] action:@selector(action:) keyEquivalent:@""];
    [schDay3Menu addItem:[NSMenuItem separatorItem]];
    [schDay3Menu addItemWithTitle:@"1:30 - 2:20" action:nil keyEquivalent:@""];
    [schDay3Menu addItemWithTitle:[NSString stringWithFormat:@"E: %@", EPeriodName] action:@selector(action:) keyEquivalent:@""];
    [schDay3Menu addItemWithTitle:@"2:25 - 3:15" action:nil keyEquivalent:@""];
    [schDay3Menu addItemWithTitle:[NSString stringWithFormat:@"F: %@", FPeriodName] action:@selector(action:) keyEquivalent:@""];
    
    [schDay4Menu addItemWithTitle:@"8:15 - 9:05" action:nil keyEquivalent:@""];
    [schDay4Menu addItemWithTitle:[NSString stringWithFormat:@"B: %@", BPeriodName] action:@selector(action:) keyEquivalent:@""];
    [schDay4Menu addItem:[NSMenuItem separatorItem]];
    [schDay4Menu addItemWithTitle:@"9:30 - 10:20" action:nil keyEquivalent:@""];
    [schDay4Menu addItemWithTitle:[NSString stringWithFormat:@"A: %@", APeriodName] action:@selector(action:) keyEquivalent:@""];
    [schDay4Menu addItemWithTitle:@"10:25 - 11:15" action:nil keyEquivalent:@""];
    [schDay4Menu addItemWithTitle:[NSString stringWithFormat:@"C: %@", CPeriodName] action:@selector(action:) keyEquivalent:@""];
    [schDay4Menu addItem:[NSMenuItem separatorItem]];
    [schDay4Menu addItemWithTitle:@"11:55 - 12:45" action:nil keyEquivalent:@""];
    [schDay4Menu addItemWithTitle:[NSString stringWithFormat:@"E: %@", EPeriodName] action:@selector(action:) keyEquivalent:@""];
    [schDay4Menu addItem:[NSMenuItem separatorItem]];
    [schDay4Menu addItemWithTitle:@"1:30 - 2:20" action:nil keyEquivalent:@""];
    [schDay4Menu addItemWithTitle:[NSString stringWithFormat:@"F: %@", FPeriodName] action:@selector(action:) keyEquivalent:@""];
    [schDay4Menu addItemWithTitle:@"2:25 - 3:15" action:nil keyEquivalent:@""];
    [schDay4Menu addItemWithTitle:[NSString stringWithFormat:@"G: %@", GPeriodName] action:@selector(action:) keyEquivalent:@""];
    
    [schDay5Menu addItemWithTitle:@"8:15 - 9:05" action:nil keyEquivalent:@""];
    [schDay5Menu addItemWithTitle:[NSString stringWithFormat:@"C: %@", CPeriodName] action:@selector(action:) keyEquivalent:@""];
    [schDay5Menu addItem:[NSMenuItem separatorItem]];
    [schDay5Menu addItemWithTitle:@"9:30 - 10:20" action:nil keyEquivalent:@""];
    [schDay5Menu addItemWithTitle:[NSString stringWithFormat:@"B: %@", BPeriodName] action:@selector(action:) keyEquivalent:@""];
    [schDay5Menu addItemWithTitle:@"10:25 - 11:15" action:nil keyEquivalent:@""];
    [schDay5Menu addItemWithTitle:[NSString stringWithFormat:@"A: %@", APeriodName] action:@selector(action:) keyEquivalent:@""];
    [schDay5Menu addItem:[NSMenuItem separatorItem]];
    [schDay5Menu addItemWithTitle:@"11:55 - 12:45" action:nil keyEquivalent:@""];
    [schDay5Menu addItemWithTitle:[NSString stringWithFormat:@"D: %@", DPeriodName] action:@selector(action:) keyEquivalent:@""];
    [schDay5Menu addItem:[NSMenuItem separatorItem]];
    [schDay5Menu addItemWithTitle:@"1:30 - 2:20" action:nil keyEquivalent:@""];
    [schDay5Menu addItemWithTitle:[NSString stringWithFormat:@"G: %@", GPeriodName] action:@selector(action:) keyEquivalent:@""];
    [schDay5Menu addItemWithTitle:@"2:25 - 3:15" action:nil keyEquivalent:@""];
    [schDay5Menu addItemWithTitle:[NSString stringWithFormat:@"F: %@", FPeriodName] action:@selector(action:) keyEquivalent:@""];
    
    [schDay6Menu addItemWithTitle:@"8:15 - 9:05" action:nil keyEquivalent:@""];
    [schDay6Menu addItemWithTitle:[NSString stringWithFormat:@"A: %@", APeriodName] action:@selector(action:) keyEquivalent:@""];
    [schDay6Menu addItem:[NSMenuItem separatorItem]];
    [schDay6Menu addItemWithTitle:@"9:30 - 10:20" action:nil keyEquivalent:@""];
    [schDay6Menu addItemWithTitle:[NSString stringWithFormat:@"C: %@", CPeriodName] action:@selector(action:) keyEquivalent:@""];
    [schDay6Menu addItemWithTitle:@"10:25 - 11:15" action:nil keyEquivalent:@""];
    [schDay6Menu addItemWithTitle:[NSString stringWithFormat:@"B: %@", BPeriodName] action:@selector(action:) keyEquivalent:@""];
    [schDay6Menu addItem:[NSMenuItem separatorItem]];
    [schDay6Menu addItemWithTitle:@"11:55 - 12:45" action:nil keyEquivalent:@""];
    [schDay6Menu addItemWithTitle:[NSString stringWithFormat:@"D: %@", DPeriodName] action:@selector(action:) keyEquivalent:@""];
    [schDay6Menu addItem:[NSMenuItem separatorItem]];
    [schDay6Menu addItemWithTitle:@"1:30 - 2:20" action:nil keyEquivalent:@""];
    [schDay6Menu addItemWithTitle:[NSString stringWithFormat:@"E: %@", EPeriodName] action:@selector(action:) keyEquivalent:@""];
    [schDay6Menu addItemWithTitle:@"2:25 - 3:15" action:nil keyEquivalent:@""];
    [schDay6Menu addItemWithTitle:[NSString stringWithFormat:@"G: %@", GPeriodName] action:@selector(action:) keyEquivalent:@""];
    
    [schDay7Menu addItemWithTitle:@"8:15 - 9:05" action:nil keyEquivalent:@""];
    [schDay7Menu addItemWithTitle:[NSString stringWithFormat:@"C: %@", CPeriodName] action:@selector(action:) keyEquivalent:@""];
    [schDay7Menu addItem:[NSMenuItem separatorItem]];
    [schDay7Menu addItemWithTitle:@"9:30 - 10:20" action:nil keyEquivalent:@""];
    [schDay7Menu addItemWithTitle:[NSString stringWithFormat:@"B: %@", BPeriodName] action:@selector(action:) keyEquivalent:@""];
    [schDay7Menu addItemWithTitle:@"10:25 - 11:15" action:nil keyEquivalent:@""];
    [schDay7Menu addItemWithTitle:[NSString stringWithFormat:@"A: %@", APeriodName] action:@selector(action:) keyEquivalent:@""];
    [schDay7Menu addItem:[NSMenuItem separatorItem]];
    [schDay7Menu addItemWithTitle:@"11:55 - 12:45" action:nil keyEquivalent:@""];
    [schDay7Menu addItemWithTitle:[NSString stringWithFormat:@"D: %@", DPeriodName] action:@selector(action:) keyEquivalent:@""];
    [schDay7Menu addItem:[NSMenuItem separatorItem]];
    [schDay7Menu addItemWithTitle:@"1:30 - 2:20" action:nil keyEquivalent:@""];
    [schDay7Menu addItemWithTitle:[NSString stringWithFormat:@"E: %@", EPeriodName] action:@selector(action:) keyEquivalent:@""];
    [schDay7Menu addItemWithTitle:@"2:25 - 3:15" action:nil keyEquivalent:@""];
    [schDay7Menu addItemWithTitle:[NSString stringWithFormat:@"F: %@", FPeriodName] action:@selector(action:) keyEquivalent:@""];
}

- (void)schFillMenusAssembly {
    [schDay1Menu addItemWithTitle:@"8:15 - 9:05" action:nil keyEquivalent:@""];
    [schDay1Menu addItemWithTitle:[NSString stringWithFormat:@"B: %@", BPeriodName] action:@selector(action:) keyEquivalent:@""];
    [schDay1Menu addItemWithTitle:@"9:10 - 10:00" action:nil keyEquivalent:@""];
    [schDay1Menu addItemWithTitle:[NSString stringWithFormat:@"C: %@", CPeriodName] action:@selector(action:) keyEquivalent:@""];
    [schDay1Menu addItem:[NSMenuItem separatorItem]];
    [schDay1Menu addItemWithTitle:@"11:00 - 11:50" action:nil keyEquivalent:@""];
    [schDay1Menu addItemWithTitle:[NSString stringWithFormat:@"D: %@", DPeriodName] action:@selector(action:) keyEquivalent:@""];
    [schDay1Menu addItemWithTitle:@"11:55 - 12:45" action:nil keyEquivalent:@""];
    [schDay1Menu addItemWithTitle:[NSString stringWithFormat:@"G: %@", GPeriodName] action:@selector(action:) keyEquivalent:@""];
    [schDay1Menu addItem:[NSMenuItem separatorItem]];
    [schDay1Menu addItemWithTitle:@"1:30 - 2:20" action:nil keyEquivalent:@""];
    [schDay1Menu addItemWithTitle:[NSString stringWithFormat:@"F: %@", FPeriodName] action:@selector(action:) keyEquivalent:@""];
    [schDay1Menu addItemWithTitle:@"2:25 - 3:15" action:nil keyEquivalent:@""];
    [schDay1Menu addItemWithTitle:[NSString stringWithFormat:@"E: %@", EPeriodName] action:@selector(action:) keyEquivalent:@""];
    
    [schDay2Menu addItemWithTitle:@"8:15 - 9:05" action:nil keyEquivalent:@""];
    [schDay2Menu addItemWithTitle:[NSString stringWithFormat:@"C: %@", CPeriodName] action:@selector(action:) keyEquivalent:@""];
    [schDay2Menu addItemWithTitle:@"9:10 - 10:00" action:nil keyEquivalent:@""];
    [schDay2Menu addItemWithTitle:[NSString stringWithFormat:@"A: %@", APeriodName] action:@selector(action:) keyEquivalent:@""];
    [schDay2Menu addItem:[NSMenuItem separatorItem]];
    [schDay2Menu addItemWithTitle:@"11:00 - 11:50" action:nil keyEquivalent:@""];
    [schDay2Menu addItemWithTitle:[NSString stringWithFormat:@"D: %@", DPeriodName] action:@selector(action:) keyEquivalent:@""];
    [schDay2Menu addItemWithTitle:@"11:55 - 12:45" action:nil keyEquivalent:@""];
    [schDay2Menu addItemWithTitle:[NSString stringWithFormat:@"F: %@", FPeriodName] action:@selector(action:) keyEquivalent:@""];
    [schDay2Menu addItem:[NSMenuItem separatorItem]];
    [schDay2Menu addItemWithTitle:@"1:30 - 2:20" action:nil keyEquivalent:@""];
    [schDay2Menu addItemWithTitle:[NSString stringWithFormat:@"E: %@", EPeriodName] action:@selector(action:) keyEquivalent:@""];
    [schDay2Menu addItemWithTitle:@"2:25 - 3:15" action:nil keyEquivalent:@""];
    [schDay2Menu addItemWithTitle:[NSString stringWithFormat:@"G: %@", GPeriodName] action:@selector(action:) keyEquivalent:@""];
    
    [schDay3Menu addItemWithTitle:@"8:15 - 9:05" action:nil keyEquivalent:@""];
    [schDay3Menu addItemWithTitle:[NSString stringWithFormat:@"A: %@", APeriodName] action:@selector(action:) keyEquivalent:@""];
    [schDay3Menu addItemWithTitle:@"9:10 - 10:00" action:nil keyEquivalent:@""];
    [schDay3Menu addItemWithTitle:[NSString stringWithFormat:@"B: %@", BPeriodName] action:@selector(action:) keyEquivalent:@""];
    [schDay3Menu addItem:[NSMenuItem separatorItem]];
    [schDay3Menu addItemWithTitle:@"11:00 - 11:50" action:nil keyEquivalent:@""];
    [schDay3Menu addItemWithTitle:[NSString stringWithFormat:@"D: %@", DPeriodName] action:@selector(action:) keyEquivalent:@""];
    [schDay3Menu addItemWithTitle:@"11:55 - 12:45" action:nil keyEquivalent:@""];
    [schDay3Menu addItemWithTitle:[NSString stringWithFormat:@"G: %@", GPeriodName] action:@selector(action:) keyEquivalent:@""];
    [schDay3Menu addItem:[NSMenuItem separatorItem]];
    [schDay3Menu addItemWithTitle:@"1:30 - 2:20" action:nil keyEquivalent:@""];
    [schDay3Menu addItemWithTitle:[NSString stringWithFormat:@"E: %@", EPeriodName] action:@selector(action:) keyEquivalent:@""];
    [schDay3Menu addItemWithTitle:@"2:25 - 3:15" action:nil keyEquivalent:@""];
    [schDay3Menu addItemWithTitle:[NSString stringWithFormat:@"F: %@", FPeriodName] action:@selector(action:) keyEquivalent:@""];
    
    [schDay4Menu addItemWithTitle:@"8:15 - 9:05" action:nil keyEquivalent:@""];
    [schDay4Menu addItemWithTitle:[NSString stringWithFormat:@"B: %@", BPeriodName] action:@selector(action:) keyEquivalent:@""];
    [schDay4Menu addItemWithTitle:@"9:10 - 10:00" action:nil keyEquivalent:@""];
    [schDay4Menu addItemWithTitle:[NSString stringWithFormat:@"A: %@", APeriodName] action:@selector(action:) keyEquivalent:@""];
    [schDay4Menu addItem:[NSMenuItem separatorItem]];
    [schDay4Menu addItemWithTitle:@"11:00 - 11:50" action:nil keyEquivalent:@""];
    [schDay4Menu addItemWithTitle:[NSString stringWithFormat:@"C: %@", CPeriodName] action:@selector(action:) keyEquivalent:@""];
    [schDay4Menu addItemWithTitle:@"11:55 - 12:45" action:nil keyEquivalent:@""];
    [schDay4Menu addItemWithTitle:[NSString stringWithFormat:@"E: %@", EPeriodName] action:@selector(action:) keyEquivalent:@""];
    [schDay4Menu addItem:[NSMenuItem separatorItem]];
    [schDay4Menu addItemWithTitle:@"1:30 - 2:20" action:nil keyEquivalent:@""];
    [schDay4Menu addItemWithTitle:[NSString stringWithFormat:@"F: %@", FPeriodName] action:@selector(action:) keyEquivalent:@""];
    [schDay4Menu addItemWithTitle:@"2:25 - 3:15" action:nil keyEquivalent:@""];
    [schDay4Menu addItemWithTitle:[NSString stringWithFormat:@"G: %@", GPeriodName] action:@selector(action:) keyEquivalent:@""];
    
    [schDay5Menu addItemWithTitle:@"8:15 - 9:05" action:nil keyEquivalent:@""];
    [schDay5Menu addItemWithTitle:[NSString stringWithFormat:@"C: %@", CPeriodName] action:@selector(action:) keyEquivalent:@""];
    [schDay5Menu addItemWithTitle:@"9:10 - 10:00" action:nil keyEquivalent:@""];
    [schDay5Menu addItemWithTitle:[NSString stringWithFormat:@"B: %@", BPeriodName] action:@selector(action:) keyEquivalent:@""];
    [schDay5Menu addItem:[NSMenuItem separatorItem]];
    [schDay5Menu addItemWithTitle:@"11:00 - 11:50" action:nil keyEquivalent:@""];
    [schDay5Menu addItemWithTitle:[NSString stringWithFormat:@"A: %@", APeriodName] action:@selector(action:) keyEquivalent:@""];
    [schDay5Menu addItemWithTitle:@"11:55 - 12:45" action:nil keyEquivalent:@""];
    [schDay5Menu addItemWithTitle:[NSString stringWithFormat:@"D: %@", DPeriodName] action:@selector(action:) keyEquivalent:@""];
    [schDay5Menu addItem:[NSMenuItem separatorItem]];
    [schDay5Menu addItemWithTitle:@"1:30 - 2:20" action:nil keyEquivalent:@""];
    [schDay5Menu addItemWithTitle:[NSString stringWithFormat:@"G: %@", GPeriodName] action:@selector(action:) keyEquivalent:@""];
    [schDay5Menu addItemWithTitle:@"2:25 - 3:15" action:nil keyEquivalent:@""];
    [schDay5Menu addItemWithTitle:[NSString stringWithFormat:@"F: %@", FPeriodName] action:@selector(action:) keyEquivalent:@""];
    
    [schDay6Menu addItemWithTitle:@"8:15 - 9:05" action:nil keyEquivalent:@""];
    [schDay6Menu addItemWithTitle:[NSString stringWithFormat:@"A: %@", APeriodName] action:@selector(action:) keyEquivalent:@""];
    [schDay6Menu addItemWithTitle:@"9:10 - 10:00" action:nil keyEquivalent:@""];
    [schDay6Menu addItemWithTitle:[NSString stringWithFormat:@"C: %@", CPeriodName] action:@selector(action:) keyEquivalent:@""];
    [schDay6Menu addItem:[NSMenuItem separatorItem]];
    [schDay6Menu addItemWithTitle:@"11:00 - 11:50" action:nil keyEquivalent:@""];
    [schDay6Menu addItemWithTitle:[NSString stringWithFormat:@"B: %@", BPeriodName] action:@selector(action:) keyEquivalent:@""];
    [schDay6Menu addItemWithTitle:@"11:55 - 12:45" action:nil keyEquivalent:@""];
    [schDay6Menu addItemWithTitle:[NSString stringWithFormat:@"D: %@", DPeriodName] action:@selector(action:) keyEquivalent:@""];
    [schDay6Menu addItem:[NSMenuItem separatorItem]];
    [schDay6Menu addItemWithTitle:@"1:30 - 2:20" action:nil keyEquivalent:@""];
    [schDay6Menu addItemWithTitle:[NSString stringWithFormat:@"E: %@", EPeriodName] action:@selector(action:) keyEquivalent:@""];
    [schDay6Menu addItemWithTitle:@"2:25 - 3:15" action:nil keyEquivalent:@""];
    [schDay6Menu addItemWithTitle:[NSString stringWithFormat:@"G: %@", GPeriodName] action:@selector(action:) keyEquivalent:@""];
    
    [schDay7Menu addItemWithTitle:@"8:15 - 9:05" action:nil keyEquivalent:@""];
    [schDay7Menu addItemWithTitle:[NSString stringWithFormat:@"C: %@", CPeriodName] action:@selector(action:) keyEquivalent:@""];
    [schDay7Menu addItemWithTitle:@"9:10 - 10:00" action:nil keyEquivalent:@""];
    [schDay7Menu addItemWithTitle:[NSString stringWithFormat:@"B: %@", BPeriodName] action:@selector(action:) keyEquivalent:@""];
    [schDay7Menu addItem:[NSMenuItem separatorItem]];
    [schDay7Menu addItemWithTitle:@"11:00 - 11:50" action:nil keyEquivalent:@""];
    [schDay7Menu addItemWithTitle:[NSString stringWithFormat:@"A: %@", APeriodName] action:@selector(action:) keyEquivalent:@""];
    [schDay7Menu addItemWithTitle:@"11:55 - 12:45" action:nil keyEquivalent:@""];
    [schDay7Menu addItemWithTitle:[NSString stringWithFormat:@"D: %@", DPeriodName] action:@selector(action:) keyEquivalent:@""];
    [schDay7Menu addItem:[NSMenuItem separatorItem]];
    [schDay7Menu addItemWithTitle:@"1:30 - 2:20" action:nil keyEquivalent:@""];
    [schDay7Menu addItemWithTitle:[NSString stringWithFormat:@"E: %@", EPeriodName] action:@selector(action:) keyEquivalent:@""];
    [schDay7Menu addItemWithTitle:@"2:25 - 3:15" action:nil keyEquivalent:@""];
    [schDay7Menu addItemWithTitle:[NSString stringWithFormat:@"F: %@", FPeriodName] action:@selector(action:) keyEquivalent:@""];
}

- (void)schFillMenusSpecial {
    [schDay1Menu addItemWithTitle:@"--:-- - --:--" action:nil keyEquivalent:@""];
    [schDay1Menu addItemWithTitle:[NSString stringWithFormat:@"B: %@", BPeriodName] action:@selector(action:) keyEquivalent:@""];
    [schDay1Menu addItem:[NSMenuItem separatorItem]];
    [schDay1Menu addItemWithTitle:@"--:-- - --:--" action:nil keyEquivalent:@""];
    [schDay1Menu addItemWithTitle:[NSString stringWithFormat:@"C: %@", CPeriodName] action:@selector(action:) keyEquivalent:@""];
    [schDay1Menu addItem:[NSMenuItem separatorItem]];
    [schDay1Menu addItemWithTitle:@"--:-- - --:--" action:nil keyEquivalent:@""];
    [schDay1Menu addItemWithTitle:[NSString stringWithFormat:@"D: %@", DPeriodName] action:@selector(action:) keyEquivalent:@""];
    [schDay1Menu addItem:[NSMenuItem separatorItem]];
    [schDay1Menu addItemWithTitle:@"--:-- - --:--" action:nil keyEquivalent:@""];
    [schDay1Menu addItemWithTitle:[NSString stringWithFormat:@"G: %@", GPeriodName] action:@selector(action:) keyEquivalent:@""];
    [schDay1Menu addItem:[NSMenuItem separatorItem]];
    [schDay1Menu addItemWithTitle:@"--:-- - --:--" action:nil keyEquivalent:@""];
    [schDay1Menu addItemWithTitle:[NSString stringWithFormat:@"F: %@", FPeriodName] action:@selector(action:) keyEquivalent:@""];
    [schDay1Menu addItem:[NSMenuItem separatorItem]];
    [schDay1Menu addItemWithTitle:@"--:-- - --:--" action:nil keyEquivalent:@""];
    [schDay1Menu addItemWithTitle:[NSString stringWithFormat:@"E: %@", EPeriodName] action:@selector(action:) keyEquivalent:@""];
    
    [schDay2Menu addItemWithTitle:@"--:-- - --:--" action:nil keyEquivalent:@""];
    [schDay2Menu addItemWithTitle:[NSString stringWithFormat:@"C: %@", CPeriodName] action:@selector(action:) keyEquivalent:@""];
    [schDay2Menu addItem:[NSMenuItem separatorItem]];
    [schDay2Menu addItemWithTitle:@"--:-- - --:--" action:nil keyEquivalent:@""];
    [schDay2Menu addItemWithTitle:[NSString stringWithFormat:@"A: %@", APeriodName] action:@selector(action:) keyEquivalent:@""];
    [schDay2Menu addItem:[NSMenuItem separatorItem]];
    [schDay2Menu addItemWithTitle:@"--:-- - --:--" action:nil keyEquivalent:@""];
    [schDay2Menu addItemWithTitle:[NSString stringWithFormat:@"D: %@", DPeriodName] action:@selector(action:) keyEquivalent:@""];
    [schDay2Menu addItem:[NSMenuItem separatorItem]];
    [schDay2Menu addItemWithTitle:@"--:-- - --:--" action:nil keyEquivalent:@""];
    [schDay2Menu addItemWithTitle:[NSString stringWithFormat:@"F: %@", FPeriodName] action:@selector(action:) keyEquivalent:@""];
    [schDay2Menu addItem:[NSMenuItem separatorItem]];
    [schDay2Menu addItemWithTitle:@"--:-- - --:--" action:nil keyEquivalent:@""];
    [schDay2Menu addItemWithTitle:[NSString stringWithFormat:@"E: %@", EPeriodName] action:@selector(action:) keyEquivalent:@""];
    [schDay2Menu addItem:[NSMenuItem separatorItem]];
    [schDay2Menu addItemWithTitle:@"--:-- - --:--" action:nil keyEquivalent:@""];
    [schDay2Menu addItemWithTitle:[NSString stringWithFormat:@"G: %@", GPeriodName] action:@selector(action:) keyEquivalent:@""];
    
    [schDay3Menu addItemWithTitle:@"--:-- - --:--" action:nil keyEquivalent:@""];
    [schDay3Menu addItemWithTitle:[NSString stringWithFormat:@"A: %@", APeriodName] action:@selector(action:) keyEquivalent:@""];
    [schDay3Menu addItem:[NSMenuItem separatorItem]];
    [schDay3Menu addItemWithTitle:@"--:-- - --:--" action:nil keyEquivalent:@""];
    [schDay3Menu addItemWithTitle:[NSString stringWithFormat:@"B: %@", BPeriodName] action:@selector(action:) keyEquivalent:@""];
    [schDay3Menu addItem:[NSMenuItem separatorItem]];
    [schDay3Menu addItemWithTitle:@"--:-- - --:--" action:nil keyEquivalent:@""];
    [schDay3Menu addItemWithTitle:[NSString stringWithFormat:@"D: %@", DPeriodName] action:@selector(action:) keyEquivalent:@""];
    [schDay3Menu addItem:[NSMenuItem separatorItem]];
    [schDay3Menu addItemWithTitle:@"--:-- - --:--" action:nil keyEquivalent:@""];
    [schDay3Menu addItemWithTitle:[NSString stringWithFormat:@"G: %@", GPeriodName] action:@selector(action:) keyEquivalent:@""];
    [schDay3Menu addItem:[NSMenuItem separatorItem]];
    [schDay3Menu addItemWithTitle:@"--:-- - --:--" action:nil keyEquivalent:@""];
    [schDay3Menu addItemWithTitle:[NSString stringWithFormat:@"E: %@", EPeriodName] action:@selector(action:) keyEquivalent:@""];
    [schDay3Menu addItem:[NSMenuItem separatorItem]];
    [schDay3Menu addItemWithTitle:@"--:-- - --:--" action:nil keyEquivalent:@""];
    [schDay3Menu addItemWithTitle:[NSString stringWithFormat:@"F: %@", FPeriodName] action:@selector(action:) keyEquivalent:@""];
    
    [schDay4Menu addItemWithTitle:@"--:-- - --:--" action:nil keyEquivalent:@""];
    [schDay4Menu addItemWithTitle:[NSString stringWithFormat:@"B: %@", BPeriodName] action:@selector(action:) keyEquivalent:@""];
    [schDay4Menu addItem:[NSMenuItem separatorItem]];
    [schDay4Menu addItemWithTitle:@"--:-- - --:--" action:nil keyEquivalent:@""];
    [schDay4Menu addItemWithTitle:[NSString stringWithFormat:@"A: %@", APeriodName] action:@selector(action:) keyEquivalent:@""];
    [schDay4Menu addItem:[NSMenuItem separatorItem]];
    [schDay4Menu addItemWithTitle:@"--:-- - --:--" action:nil keyEquivalent:@""];
    [schDay4Menu addItemWithTitle:[NSString stringWithFormat:@"C: %@", CPeriodName] action:@selector(action:) keyEquivalent:@""];
    [schDay4Menu addItem:[NSMenuItem separatorItem]];
    [schDay4Menu addItemWithTitle:@"--:-- - --:--" action:nil keyEquivalent:@""];
    [schDay4Menu addItemWithTitle:[NSString stringWithFormat:@"E: %@", EPeriodName] action:@selector(action:) keyEquivalent:@""];
    [schDay4Menu addItem:[NSMenuItem separatorItem]];
    [schDay4Menu addItemWithTitle:@"--:-- - --:--" action:nil keyEquivalent:@""];
    [schDay4Menu addItemWithTitle:[NSString stringWithFormat:@"F: %@", FPeriodName] action:@selector(action:) keyEquivalent:@""];
    [schDay4Menu addItem:[NSMenuItem separatorItem]];
    [schDay4Menu addItemWithTitle:@"--:-- - --:--" action:nil keyEquivalent:@""];
    [schDay4Menu addItemWithTitle:[NSString stringWithFormat:@"G: %@", GPeriodName] action:@selector(action:) keyEquivalent:@""];
    
    [schDay5Menu addItemWithTitle:@"--:-- - --:--" action:nil keyEquivalent:@""];
    [schDay5Menu addItemWithTitle:[NSString stringWithFormat:@"C: %@", CPeriodName] action:@selector(action:) keyEquivalent:@""];
    [schDay5Menu addItem:[NSMenuItem separatorItem]];
    [schDay5Menu addItemWithTitle:@"--:-- - --:--" action:nil keyEquivalent:@""];
    [schDay5Menu addItemWithTitle:[NSString stringWithFormat:@"B: %@", BPeriodName] action:@selector(action:) keyEquivalent:@""];
    [schDay5Menu addItem:[NSMenuItem separatorItem]];
    [schDay5Menu addItemWithTitle:@"--:-- - --:--" action:nil keyEquivalent:@""];
    [schDay5Menu addItemWithTitle:[NSString stringWithFormat:@"A: %@", APeriodName] action:@selector(action:) keyEquivalent:@""];
    [schDay5Menu addItem:[NSMenuItem separatorItem]];
    [schDay5Menu addItemWithTitle:@"--:-- - --:--" action:nil keyEquivalent:@""];
    [schDay5Menu addItemWithTitle:[NSString stringWithFormat:@"D: %@", DPeriodName] action:@selector(action:) keyEquivalent:@""];
    [schDay5Menu addItem:[NSMenuItem separatorItem]];
    [schDay5Menu addItemWithTitle:@"--:-- - --:--" action:nil keyEquivalent:@""];
    [schDay5Menu addItemWithTitle:[NSString stringWithFormat:@"G: %@", GPeriodName] action:@selector(action:) keyEquivalent:@""];
    [schDay5Menu addItem:[NSMenuItem separatorItem]];
    [schDay5Menu addItemWithTitle:@"--:-- - --:--" action:nil keyEquivalent:@""];
    [schDay5Menu addItemWithTitle:[NSString stringWithFormat:@"F: %@", FPeriodName] action:@selector(action:) keyEquivalent:@""];
    
    [schDay6Menu addItemWithTitle:@"--:-- - --:--" action:nil keyEquivalent:@""];
    [schDay6Menu addItemWithTitle:[NSString stringWithFormat:@"A: %@", APeriodName] action:@selector(action:) keyEquivalent:@""];
    [schDay6Menu addItem:[NSMenuItem separatorItem]];
    [schDay6Menu addItemWithTitle:@"--:-- - --:--" action:nil keyEquivalent:@""];
    [schDay6Menu addItemWithTitle:[NSString stringWithFormat:@"C: %@", CPeriodName] action:@selector(action:) keyEquivalent:@""];
    [schDay6Menu addItem:[NSMenuItem separatorItem]];
    [schDay6Menu addItemWithTitle:@"--:-- - --:--" action:nil keyEquivalent:@""];
    [schDay6Menu addItemWithTitle:[NSString stringWithFormat:@"B: %@", BPeriodName] action:@selector(action:) keyEquivalent:@""];
    [schDay6Menu addItem:[NSMenuItem separatorItem]];
    [schDay6Menu addItemWithTitle:@"--:-- - --:--" action:nil keyEquivalent:@""];
    [schDay6Menu addItemWithTitle:[NSString stringWithFormat:@"D: %@", DPeriodName] action:@selector(action:) keyEquivalent:@""];
    [schDay6Menu addItem:[NSMenuItem separatorItem]];
    [schDay6Menu addItemWithTitle:@"--:-- - --:--" action:nil keyEquivalent:@""];
    [schDay6Menu addItemWithTitle:[NSString stringWithFormat:@"E: %@", EPeriodName] action:@selector(action:) keyEquivalent:@""];
    [schDay6Menu addItem:[NSMenuItem separatorItem]];
    [schDay6Menu addItemWithTitle:@"--:-- - --:--" action:nil keyEquivalent:@""];
    [schDay6Menu addItemWithTitle:[NSString stringWithFormat:@"G: %@", GPeriodName] action:@selector(action:) keyEquivalent:@""];
    
    [schDay7Menu addItemWithTitle:@"--:-- - --:--" action:nil keyEquivalent:@""];
    [schDay7Menu addItemWithTitle:[NSString stringWithFormat:@"C: %@", CPeriodName] action:@selector(action:) keyEquivalent:@""];
    [schDay7Menu addItem:[NSMenuItem separatorItem]];
    [schDay7Menu addItemWithTitle:@"--:-- - --:--" action:nil keyEquivalent:@""];
    [schDay7Menu addItemWithTitle:[NSString stringWithFormat:@"B: %@", BPeriodName] action:@selector(action:) keyEquivalent:@""];
    [schDay7Menu addItem:[NSMenuItem separatorItem]];
    [schDay7Menu addItemWithTitle:@"--:-- - --:--" action:nil keyEquivalent:@""];
    [schDay7Menu addItemWithTitle:[NSString stringWithFormat:@"A: %@", APeriodName] action:@selector(action:) keyEquivalent:@""];
    [schDay7Menu addItem:[NSMenuItem separatorItem]];
    [schDay7Menu addItemWithTitle:@"--:-- - --:--" action:nil keyEquivalent:@""];
    [schDay7Menu addItemWithTitle:[NSString stringWithFormat:@"D: %@", DPeriodName] action:@selector(action:) keyEquivalent:@""];
    [schDay7Menu addItem:[NSMenuItem separatorItem]];
    [schDay7Menu addItemWithTitle:@"--:-- - --:--" action:nil keyEquivalent:@""];
    [schDay7Menu addItemWithTitle:[NSString stringWithFormat:@"E: %@", EPeriodName] action:@selector(action:) keyEquivalent:@""];
    [schDay7Menu addItem:[NSMenuItem separatorItem]];
    [schDay7Menu addItemWithTitle:@"--:-- - --:--" action:nil keyEquivalent:@""];
    [schDay7Menu addItemWithTitle:[NSString stringWithFormat:@"F: %@", FPeriodName] action:@selector(action:) keyEquivalent:@""];
}

- (void)schFillMenusSpecialAssembly {
    [schDay1Menu addItemWithTitle:@"--:-- - --:--" action:nil keyEquivalent:@""];
    [schDay1Menu addItemWithTitle:[NSString stringWithFormat:@"B: %@", BPeriodName] action:@selector(action:) keyEquivalent:@""];
    [schDay1Menu addItemWithTitle:@"--:-- - --:--" action:nil keyEquivalent:@""];
    [schDay1Menu addItemWithTitle:[NSString stringWithFormat:@"C: %@", CPeriodName] action:@selector(action:) keyEquivalent:@""];
    [schDay1Menu addItem:[NSMenuItem separatorItem]];
    [schDay1Menu addItemWithTitle:@"--:-- - --:--" action:nil keyEquivalent:@""];
    [schDay1Menu addItemWithTitle:[NSString stringWithFormat:@"D: %@", DPeriodName] action:@selector(action:) keyEquivalent:@""];
    [schDay1Menu addItemWithTitle:@"--:-- - --:--" action:nil keyEquivalent:@""];
    [schDay1Menu addItemWithTitle:[NSString stringWithFormat:@"G: %@", GPeriodName] action:@selector(action:) keyEquivalent:@""];
    [schDay1Menu addItem:[NSMenuItem separatorItem]];
    [schDay1Menu addItemWithTitle:@"--:-- - --:--" action:nil keyEquivalent:@""];
    [schDay1Menu addItemWithTitle:[NSString stringWithFormat:@"F: %@", FPeriodName] action:@selector(action:) keyEquivalent:@""];
    [schDay1Menu addItemWithTitle:@"--:-- - --:--" action:nil keyEquivalent:@""];
    [schDay1Menu addItemWithTitle:[NSString stringWithFormat:@"E: %@", EPeriodName] action:@selector(action:) keyEquivalent:@""];
    
    [schDay2Menu addItemWithTitle:@"--:-- - --:--" action:nil keyEquivalent:@""];
    [schDay2Menu addItemWithTitle:[NSString stringWithFormat:@"C: %@", CPeriodName] action:@selector(action:) keyEquivalent:@""];
    [schDay2Menu addItemWithTitle:@"--:-- - --:--" action:nil keyEquivalent:@""];
    [schDay2Menu addItemWithTitle:[NSString stringWithFormat:@"A: %@", APeriodName] action:@selector(action:) keyEquivalent:@""];
    [schDay2Menu addItem:[NSMenuItem separatorItem]];
    [schDay2Menu addItemWithTitle:@"--:-- - --:--" action:nil keyEquivalent:@""];
    [schDay2Menu addItemWithTitle:[NSString stringWithFormat:@"D: %@", DPeriodName] action:@selector(action:) keyEquivalent:@""];
    [schDay2Menu addItemWithTitle:@"--:-- - --:--" action:nil keyEquivalent:@""];
    [schDay2Menu addItemWithTitle:[NSString stringWithFormat:@"F: %@", FPeriodName] action:@selector(action:) keyEquivalent:@""];
    [schDay2Menu addItem:[NSMenuItem separatorItem]];
    [schDay2Menu addItemWithTitle:@"--:-- - --:--" action:nil keyEquivalent:@""];
    [schDay2Menu addItemWithTitle:[NSString stringWithFormat:@"E: %@", EPeriodName] action:@selector(action:) keyEquivalent:@""];
    [schDay2Menu addItemWithTitle:@"--:-- - --:--" action:nil keyEquivalent:@""];
    [schDay2Menu addItemWithTitle:[NSString stringWithFormat:@"G: %@", GPeriodName] action:@selector(action:) keyEquivalent:@""];
    
    [schDay3Menu addItemWithTitle:@"--:-- - --:--" action:nil keyEquivalent:@""];
    [schDay3Menu addItemWithTitle:[NSString stringWithFormat:@"A: %@", APeriodName] action:@selector(action:) keyEquivalent:@""];
    [schDay3Menu addItemWithTitle:@"--:-- - --:--" action:nil keyEquivalent:@""];
    [schDay3Menu addItemWithTitle:[NSString stringWithFormat:@"B: %@", BPeriodName] action:@selector(action:) keyEquivalent:@""];
    [schDay3Menu addItem:[NSMenuItem separatorItem]];
    [schDay3Menu addItemWithTitle:@"--:-- - --:--" action:nil keyEquivalent:@""];
    [schDay3Menu addItemWithTitle:[NSString stringWithFormat:@"D: %@", DPeriodName] action:@selector(action:) keyEquivalent:@""];
    [schDay3Menu addItemWithTitle:@"--:-- - --:--" action:nil keyEquivalent:@""];
    [schDay3Menu addItemWithTitle:[NSString stringWithFormat:@"G: %@", GPeriodName] action:@selector(action:) keyEquivalent:@""];
    [schDay3Menu addItem:[NSMenuItem separatorItem]];
    [schDay3Menu addItemWithTitle:@"--:-- - --:--" action:nil keyEquivalent:@""];
    [schDay3Menu addItemWithTitle:[NSString stringWithFormat:@"E: %@", EPeriodName] action:@selector(action:) keyEquivalent:@""];
    [schDay3Menu addItemWithTitle:@"--:-- - --:--" action:nil keyEquivalent:@""];
    [schDay3Menu addItemWithTitle:[NSString stringWithFormat:@"F: %@", FPeriodName] action:@selector(action:) keyEquivalent:@""];
    
    [schDay4Menu addItemWithTitle:@"--:-- - --:--" action:nil keyEquivalent:@""];
    [schDay4Menu addItemWithTitle:[NSString stringWithFormat:@"B: %@", BPeriodName] action:@selector(action:) keyEquivalent:@""];
    [schDay4Menu addItemWithTitle:@"--:-- - --:--" action:nil keyEquivalent:@""];
    [schDay4Menu addItemWithTitle:[NSString stringWithFormat:@"A: %@", APeriodName] action:@selector(action:) keyEquivalent:@""];
    [schDay4Menu addItem:[NSMenuItem separatorItem]];
    [schDay4Menu addItemWithTitle:@"--:-- - --:--" action:nil keyEquivalent:@""];
    [schDay4Menu addItemWithTitle:[NSString stringWithFormat:@"C: %@", CPeriodName] action:@selector(action:) keyEquivalent:@""];
    [schDay4Menu addItemWithTitle:@"--:-- - --:--" action:nil keyEquivalent:@""];
    [schDay4Menu addItemWithTitle:[NSString stringWithFormat:@"E: %@", EPeriodName] action:@selector(action:) keyEquivalent:@""];
    [schDay4Menu addItem:[NSMenuItem separatorItem]];
    [schDay4Menu addItemWithTitle:@"--:-- - --:--" action:nil keyEquivalent:@""];
    [schDay4Menu addItemWithTitle:[NSString stringWithFormat:@"F: %@", FPeriodName] action:@selector(action:) keyEquivalent:@""];
    [schDay4Menu addItemWithTitle:@"--:-- - --:--" action:nil keyEquivalent:@""];
    [schDay4Menu addItemWithTitle:[NSString stringWithFormat:@"G: %@", GPeriodName] action:@selector(action:) keyEquivalent:@""];
    
    [schDay5Menu addItemWithTitle:@"--:-- - --:--" action:nil keyEquivalent:@""];
    [schDay5Menu addItemWithTitle:[NSString stringWithFormat:@"C: %@", CPeriodName] action:@selector(action:) keyEquivalent:@""];
    [schDay5Menu addItemWithTitle:@"--:-- - --:--" action:nil keyEquivalent:@""];
    [schDay5Menu addItemWithTitle:[NSString stringWithFormat:@"B: %@", BPeriodName] action:@selector(action:) keyEquivalent:@""];
    [schDay5Menu addItem:[NSMenuItem separatorItem]];
    [schDay5Menu addItemWithTitle:@"--:-- - --:--" action:nil keyEquivalent:@""];
    [schDay5Menu addItemWithTitle:[NSString stringWithFormat:@"A: %@", APeriodName] action:@selector(action:) keyEquivalent:@""];
    [schDay5Menu addItemWithTitle:@"--:-- - --:--" action:nil keyEquivalent:@""];
    [schDay5Menu addItemWithTitle:[NSString stringWithFormat:@"D: %@", DPeriodName] action:@selector(action:) keyEquivalent:@""];
    [schDay5Menu addItem:[NSMenuItem separatorItem]];
    [schDay5Menu addItemWithTitle:@"--:-- - --:--" action:nil keyEquivalent:@""];
    [schDay5Menu addItemWithTitle:[NSString stringWithFormat:@"G: %@", GPeriodName] action:@selector(action:) keyEquivalent:@""];
    [schDay5Menu addItemWithTitle:@"--:-- - --:--" action:nil keyEquivalent:@""];
    [schDay5Menu addItemWithTitle:[NSString stringWithFormat:@"F: %@", FPeriodName] action:@selector(action:) keyEquivalent:@""];
    
    [schDay6Menu addItemWithTitle:@"--:-- - --:--" action:nil keyEquivalent:@""];
    [schDay6Menu addItemWithTitle:[NSString stringWithFormat:@"A: %@", APeriodName] action:@selector(action:) keyEquivalent:@""];
    [schDay6Menu addItemWithTitle:@"--:-- - --:--" action:nil keyEquivalent:@""];
    [schDay6Menu addItemWithTitle:[NSString stringWithFormat:@"C: %@", CPeriodName] action:@selector(action:) keyEquivalent:@""];
    [schDay6Menu addItem:[NSMenuItem separatorItem]];
    [schDay6Menu addItemWithTitle:@"--:-- - --:--" action:nil keyEquivalent:@""];
    [schDay6Menu addItemWithTitle:[NSString stringWithFormat:@"B: %@", BPeriodName] action:@selector(action:) keyEquivalent:@""];
    [schDay6Menu addItemWithTitle:@"--:-- - --:--" action:nil keyEquivalent:@""];
    [schDay6Menu addItemWithTitle:[NSString stringWithFormat:@"D: %@", DPeriodName] action:@selector(action:) keyEquivalent:@""];
    [schDay6Menu addItem:[NSMenuItem separatorItem]];
    [schDay6Menu addItemWithTitle:@"--:-- - --:--" action:nil keyEquivalent:@""];
    [schDay6Menu addItemWithTitle:[NSString stringWithFormat:@"E: %@", EPeriodName] action:@selector(action:) keyEquivalent:@""];
    [schDay6Menu addItemWithTitle:@"--:-- - --:--" action:nil keyEquivalent:@""];
    [schDay6Menu addItemWithTitle:[NSString stringWithFormat:@"G: %@", GPeriodName] action:@selector(action:) keyEquivalent:@""];
    
    [schDay7Menu addItemWithTitle:@"--:-- - --:--" action:nil keyEquivalent:@""];
    [schDay7Menu addItemWithTitle:[NSString stringWithFormat:@"C: %@", CPeriodName] action:@selector(action:) keyEquivalent:@""];
    [schDay7Menu addItemWithTitle:@"--:-- - --:--" action:nil keyEquivalent:@""];
    [schDay7Menu addItemWithTitle:[NSString stringWithFormat:@"B: %@", BPeriodName] action:@selector(action:) keyEquivalent:@""];
    [schDay7Menu addItem:[NSMenuItem separatorItem]];
    [schDay7Menu addItemWithTitle:@"--:-- - --:--" action:nil keyEquivalent:@""];
    [schDay7Menu addItemWithTitle:[NSString stringWithFormat:@"A: %@", APeriodName] action:@selector(action:) keyEquivalent:@""];
    [schDay7Menu addItemWithTitle:@"--:-- - --:--" action:nil keyEquivalent:@""];
    [schDay7Menu addItemWithTitle:[NSString stringWithFormat:@"D: %@", DPeriodName] action:@selector(action:) keyEquivalent:@""];
    [schDay7Menu addItem:[NSMenuItem separatorItem]];
    [schDay7Menu addItemWithTitle:@"--:-- - --:--" action:nil keyEquivalent:@""];
    [schDay7Menu addItemWithTitle:[NSString stringWithFormat:@"E: %@", EPeriodName] action:@selector(action:) keyEquivalent:@""];
    [schDay7Menu addItemWithTitle:@"--:-- - --:--" action:nil keyEquivalent:@""];
    [schDay7Menu addItemWithTitle:[NSString stringWithFormat:@"F: %@", FPeriodName] action:@selector(action:) keyEquivalent:@""];
}

- (void)action:(id)sender {
}

- (void)schTimer:(NSTimer *)timer {
    nowDateComponents = [[NSCalendar currentCalendar] components:(NSHourCalendarUnit | NSMinuteCalendarUnit | NSWeekdayCalendarUnit) fromDate:[NSDate date]];
    nowInMinutes = (60 * [nowDateComponents hour]) + [nowDateComponents minute];
    [self dctSetStatesOff];
    [self schSetStatesOff];
    
    if (dayNumber == 0) {[dctDay0MenuItem setState:NSOnState];}
    if (dayNumber == 1) {[dctDay1MenuItem setState:NSOnState];}
    if (dayNumber == 2) {[dctDay2MenuItem setState:NSOnState];}
    if (dayNumber == 3) {[dctDay3MenuItem setState:NSOnState];}
    if (dayNumber == 4) {[dctDay4MenuItem setState:NSOnState];}
    if (dayNumber == 5) {[dctDay5MenuItem setState:NSOnState];}
    if (dayNumber == 6) {[dctDay6MenuItem setState:NSOnState];}
    if (dayNumber == 7) {[dctDay7MenuItem setState:NSOnState];}
    if (dayNumber == -1) {[dctDaySpecialMenuItem setState:NSOnState];}
    
    if ((([nowDateComponents weekday] != 1) && ([nowDateComponents weekday] != 7)) && (dayNumber > 0) && (specialState == 0)) {
        if ((nowInMinutes >= 420) && (nowInMinutes < 495)) {
            //Before 1st period
            if (dayNumber == 1) {[[schDay1Menu itemAtIndex:1] setState:NSMixedState];}
            if (dayNumber == 2) {[[schDay2Menu itemAtIndex:1] setState:NSMixedState];}
            if (dayNumber == 3) {[[schDay3Menu itemAtIndex:1] setState:NSMixedState];}
            if (dayNumber == 4) {[[schDay4Menu itemAtIndex:1] setState:NSMixedState];}
            if (dayNumber == 5) {[[schDay5Menu itemAtIndex:1] setState:NSMixedState];}
            if (dayNumber == 6) {[[schDay6Menu itemAtIndex:1] setState:NSMixedState];}
            if (dayNumber == 7) {[[schDay7Menu itemAtIndex:1] setState:NSMixedState];}
        } else if ((nowInMinutes >= 495) && (nowInMinutes < 545)) {
            //1st period
            if (dayNumber == 1) {[[schDay1Menu itemAtIndex:1] setState:NSOnState];}
            if (dayNumber == 2) {[[schDay2Menu itemAtIndex:1] setState:NSOnState];}
            if (dayNumber == 3) {[[schDay3Menu itemAtIndex:1] setState:NSOnState];}
            if (dayNumber == 4) {[[schDay4Menu itemAtIndex:1] setState:NSOnState];}
            if (dayNumber == 5) {[[schDay5Menu itemAtIndex:1] setState:NSOnState];}
            if (dayNumber == 6) {[[schDay6Menu itemAtIndex:1] setState:NSOnState];}
            if (dayNumber == 7) {[[schDay7Menu itemAtIndex:1] setState:NSOnState];}
        }
        if (assemblyState == 0) {
            if ((nowInMinutes >= 545) && (nowInMinutes < 570)) {
                //Before 2nd period
                if (dayNumber == 1) {[[schDay1Menu itemAtIndex:4] setState:NSMixedState];}
                if (dayNumber == 2) {[[schDay2Menu itemAtIndex:4] setState:NSMixedState];}
                if (dayNumber == 3) {[[schDay3Menu itemAtIndex:4] setState:NSMixedState];}
                if (dayNumber == 4) {[[schDay4Menu itemAtIndex:4] setState:NSMixedState];}
                if (dayNumber == 5) {[[schDay5Menu itemAtIndex:4] setState:NSMixedState];}
                if (dayNumber == 6) {[[schDay6Menu itemAtIndex:4] setState:NSMixedState];}
                if (dayNumber == 7) {[[schDay7Menu itemAtIndex:4] setState:NSMixedState];}
            } else if ((nowInMinutes >= 570) && (nowInMinutes < 620)) {
                //2nd period
                if (dayNumber == 1) {[[schDay1Menu itemAtIndex:4] setState:NSOnState];}
                if (dayNumber == 2) {[[schDay2Menu itemAtIndex:4] setState:NSOnState];}
                if (dayNumber == 3) {[[schDay3Menu itemAtIndex:4] setState:NSOnState];}
                if (dayNumber == 4) {[[schDay4Menu itemAtIndex:4] setState:NSOnState];}
                if (dayNumber == 5) {[[schDay5Menu itemAtIndex:4] setState:NSOnState];}
                if (dayNumber == 6) {[[schDay6Menu itemAtIndex:4] setState:NSOnState];}
                if (dayNumber == 7) {[[schDay7Menu itemAtIndex:4] setState:NSOnState];}
            } else if ((nowInMinutes >= 620) && (nowInMinutes < 625)) {
                //Before 3rd period
                if (dayNumber == 1) {[[schDay1Menu itemAtIndex:6] setState:NSMixedState];}
                if (dayNumber == 2) {[[schDay2Menu itemAtIndex:6] setState:NSMixedState];}
                if (dayNumber == 3) {[[schDay3Menu itemAtIndex:6] setState:NSMixedState];}
                if (dayNumber == 4) {[[schDay4Menu itemAtIndex:6] setState:NSMixedState];}
                if (dayNumber == 5) {[[schDay5Menu itemAtIndex:6] setState:NSMixedState];}
                if (dayNumber == 6) {[[schDay6Menu itemAtIndex:6] setState:NSMixedState];}
                if (dayNumber == 7) {[[schDay7Menu itemAtIndex:6] setState:NSMixedState];}
            } else if ((nowInMinutes >= 625) && (nowInMinutes < 675)) {
                //3rd period
                if (dayNumber == 1) {[[schDay1Menu itemAtIndex:6] setState:NSOnState];}
                if (dayNumber == 2) {[[schDay2Menu itemAtIndex:6] setState:NSOnState];}
                if (dayNumber == 3) {[[schDay3Menu itemAtIndex:6] setState:NSOnState];}
                if (dayNumber == 4) {[[schDay4Menu itemAtIndex:6] setState:NSOnState];}
                if (dayNumber == 5) {[[schDay5Menu itemAtIndex:6] setState:NSOnState];}
                if (dayNumber == 6) {[[schDay6Menu itemAtIndex:6] setState:NSOnState];}
                if (dayNumber == 7) {[[schDay7Menu itemAtIndex:6] setState:NSOnState];}
            } else if ((nowInMinutes >= 675) && (nowInMinutes < 715)) {
                //Before 4th period
                if (dayNumber == 1) {[[schDay1Menu itemAtIndex:9] setState:NSMixedState];}
                if (dayNumber == 2) {[[schDay2Menu itemAtIndex:9] setState:NSMixedState];}
                if (dayNumber == 3) {[[schDay3Menu itemAtIndex:9] setState:NSMixedState];}
                if (dayNumber == 4) {[[schDay4Menu itemAtIndex:9] setState:NSMixedState];}
                if (dayNumber == 5) {[[schDay5Menu itemAtIndex:9] setState:NSMixedState];}
                if (dayNumber == 6) {[[schDay6Menu itemAtIndex:9] setState:NSMixedState];}
                if (dayNumber == 7) {[[schDay7Menu itemAtIndex:9] setState:NSMixedState];}
            } else if ((nowInMinutes >= 715) && (nowInMinutes < 765)) {
                //4th period
                if (dayNumber == 1) {[[schDay1Menu itemAtIndex:9] setState:NSOnState];}
                if (dayNumber == 2) {[[schDay2Menu itemAtIndex:9] setState:NSOnState];}
                if (dayNumber == 3) {[[schDay3Menu itemAtIndex:9] setState:NSOnState];}
                if (dayNumber == 4) {[[schDay4Menu itemAtIndex:9] setState:NSOnState];}
                if (dayNumber == 5) {[[schDay5Menu itemAtIndex:9] setState:NSOnState];}
                if (dayNumber == 6) {[[schDay6Menu itemAtIndex:9] setState:NSOnState];}
                if (dayNumber == 7) {[[schDay7Menu itemAtIndex:9] setState:NSOnState];}
            } else if ((nowInMinutes >= 765) && (nowInMinutes < 810)) {
                //Before 5th period
                if (dayNumber == 1) {[[schDay1Menu itemAtIndex:12] setState:NSMixedState];}
                if (dayNumber == 2) {[[schDay2Menu itemAtIndex:12] setState:NSMixedState];}
                if (dayNumber == 3) {[[schDay3Menu itemAtIndex:12] setState:NSMixedState];}
                if (dayNumber == 4) {[[schDay4Menu itemAtIndex:12] setState:NSMixedState];}
                if (dayNumber == 5) {[[schDay5Menu itemAtIndex:12] setState:NSMixedState];}
                if (dayNumber == 6) {[[schDay6Menu itemAtIndex:12] setState:NSMixedState];}
                if (dayNumber == 7) {[[schDay7Menu itemAtIndex:12] setState:NSMixedState];}
            } else if ((nowInMinutes >= 810) && (nowInMinutes < 860)) {
                //5th period
                if (dayNumber == 1) {[[schDay1Menu itemAtIndex:12] setState:NSOnState];}
                if (dayNumber == 2) {[[schDay2Menu itemAtIndex:12] setState:NSOnState];}
                if (dayNumber == 3) {[[schDay3Menu itemAtIndex:12] setState:NSOnState];}
                if (dayNumber == 4) {[[schDay4Menu itemAtIndex:12] setState:NSOnState];}
                if (dayNumber == 5) {[[schDay5Menu itemAtIndex:12] setState:NSOnState];}
                if (dayNumber == 6) {[[schDay6Menu itemAtIndex:12] setState:NSOnState];}
                if (dayNumber == 7) {[[schDay7Menu itemAtIndex:12] setState:NSOnState];}
            } else if ((nowInMinutes >= 860 && (nowInMinutes) < 865)) {
                //Before 6th period
                if (dayNumber == 1) {[[schDay1Menu itemAtIndex:14] setState:NSMixedState];}
                if (dayNumber == 2) {[[schDay2Menu itemAtIndex:14] setState:NSMixedState];}
                if (dayNumber == 3) {[[schDay3Menu itemAtIndex:14] setState:NSMixedState];}
                if (dayNumber == 4) {[[schDay4Menu itemAtIndex:14] setState:NSMixedState];}
                if (dayNumber == 5) {[[schDay5Menu itemAtIndex:14] setState:NSMixedState];}
                if (dayNumber == 6) {[[schDay6Menu itemAtIndex:14] setState:NSMixedState];}
                if (dayNumber == 7) {[[schDay7Menu itemAtIndex:14] setState:NSMixedState];}
            } else if ((nowInMinutes >= 865 && (nowInMinutes) < 915)) {
                //6th period
                if (dayNumber == 1) {[[schDay1Menu itemAtIndex:14] setState:NSOnState];}
                if (dayNumber == 2) {[[schDay2Menu itemAtIndex:14] setState:NSOnState];}
                if (dayNumber == 3) {[[schDay3Menu itemAtIndex:14] setState:NSOnState];}
                if (dayNumber == 4) {[[schDay4Menu itemAtIndex:14] setState:NSOnState];}
                if (dayNumber == 5) {[[schDay5Menu itemAtIndex:14] setState:NSOnState];}
                if (dayNumber == 6) {[[schDay6Menu itemAtIndex:14] setState:NSOnState];}
                if (dayNumber == 7) {[[schDay7Menu itemAtIndex:14] setState:NSOnState];}
            }
        } else {
            if ((nowInMinutes > 545) && (nowInMinutes <= 550)) {
                //Before 2nd period
                if (dayNumber == 1) {[[schDay1Menu itemAtIndex:3] setState:NSMixedState];}
                if (dayNumber == 2) {[[schDay2Menu itemAtIndex:3] setState:NSMixedState];}
                if (dayNumber == 3) {[[schDay3Menu itemAtIndex:3] setState:NSMixedState];}
                if (dayNumber == 4) {[[schDay4Menu itemAtIndex:3] setState:NSMixedState];}
                if (dayNumber == 5) {[[schDay5Menu itemAtIndex:3] setState:NSMixedState];}
                if (dayNumber == 6) {[[schDay6Menu itemAtIndex:3] setState:NSMixedState];}
                if (dayNumber == 7) {[[schDay7Menu itemAtIndex:3] setState:NSMixedState];}
            } else if ((nowInMinutes >= 550) && (nowInMinutes < 600)) {
                //2nd period
                if (dayNumber == 1) {[[schDay1Menu itemAtIndex:3] setState:NSOnState];}
                if (dayNumber == 2) {[[schDay2Menu itemAtIndex:3] setState:NSOnState];}
                if (dayNumber == 3) {[[schDay3Menu itemAtIndex:3] setState:NSOnState];}
                if (dayNumber == 4) {[[schDay4Menu itemAtIndex:3] setState:NSOnState];}
                if (dayNumber == 5) {[[schDay5Menu itemAtIndex:3] setState:NSOnState];}
                if (dayNumber == 6) {[[schDay6Menu itemAtIndex:3] setState:NSOnState];}
                if (dayNumber == 7) {[[schDay7Menu itemAtIndex:3] setState:NSOnState];}
            }  else if ((nowInMinutes >= 600) && (nowInMinutes < 660)) {
                //Before 3rd period
                if (dayNumber == 1) {[[schDay1Menu itemAtIndex:6] setState:NSMixedState];}
                if (dayNumber == 2) {[[schDay2Menu itemAtIndex:6] setState:NSMixedState];}
                if (dayNumber == 3) {[[schDay3Menu itemAtIndex:6] setState:NSMixedState];}
                if (dayNumber == 4) {[[schDay4Menu itemAtIndex:6] setState:NSMixedState];}
                if (dayNumber == 5) {[[schDay5Menu itemAtIndex:6] setState:NSMixedState];}
                if (dayNumber == 6) {[[schDay6Menu itemAtIndex:6] setState:NSMixedState];}
                if (dayNumber == 7) {[[schDay7Menu itemAtIndex:6] setState:NSMixedState];}
            } else if ((nowInMinutes >= 660) && (nowInMinutes < 710)) {
                //3rd period
                if (dayNumber == 1) {[[schDay1Menu itemAtIndex:6] setState:NSOnState];}
                if (dayNumber == 2) {[[schDay2Menu itemAtIndex:6] setState:NSOnState];}
                if (dayNumber == 3) {[[schDay3Menu itemAtIndex:6] setState:NSOnState];}
                if (dayNumber == 4) {[[schDay4Menu itemAtIndex:6] setState:NSOnState];}
                if (dayNumber == 5) {[[schDay5Menu itemAtIndex:6] setState:NSOnState];}
                if (dayNumber == 6) {[[schDay6Menu itemAtIndex:6] setState:NSOnState];}
                if (dayNumber == 7) {[[schDay7Menu itemAtIndex:6] setState:NSOnState];}
            } else if ((nowInMinutes >= 710) && (nowInMinutes < 715)) {
                //Before 4th period
                if (dayNumber == 1) {[[schDay1Menu itemAtIndex:8] setState:NSMixedState];}
                if (dayNumber == 2) {[[schDay2Menu itemAtIndex:8] setState:NSMixedState];}
                if (dayNumber == 3) {[[schDay3Menu itemAtIndex:8] setState:NSMixedState];}
                if (dayNumber == 4) {[[schDay4Menu itemAtIndex:8] setState:NSMixedState];}
                if (dayNumber == 5) {[[schDay5Menu itemAtIndex:8] setState:NSMixedState];}
                if (dayNumber == 6) {[[schDay6Menu itemAtIndex:8] setState:NSMixedState];}
                if (dayNumber == 7) {[[schDay7Menu itemAtIndex:8] setState:NSMixedState];}
            } else if ((nowInMinutes >= 715) && (nowInMinutes < 765)) {
                //4th period
                if (dayNumber == 1) {[[schDay1Menu itemAtIndex:8] setState:NSOnState];}
                if (dayNumber == 2) {[[schDay2Menu itemAtIndex:8] setState:NSOnState];}
                if (dayNumber == 3) {[[schDay3Menu itemAtIndex:8] setState:NSOnState];}
                if (dayNumber == 4) {[[schDay4Menu itemAtIndex:8] setState:NSOnState];}
                if (dayNumber == 5) {[[schDay5Menu itemAtIndex:8] setState:NSOnState];}
                if (dayNumber == 6) {[[schDay6Menu itemAtIndex:8] setState:NSOnState];}
                if (dayNumber == 7) {[[schDay7Menu itemAtIndex:8] setState:NSOnState];}
            } else if ((nowInMinutes >= 765) && (nowInMinutes < 810)) {
                //Before 5th period
                if (dayNumber == 1) {[[schDay1Menu itemAtIndex:11] setState:NSMixedState];}
                if (dayNumber == 2) {[[schDay2Menu itemAtIndex:11] setState:NSMixedState];}
                if (dayNumber == 3) {[[schDay3Menu itemAtIndex:11] setState:NSMixedState];}
                if (dayNumber == 4) {[[schDay4Menu itemAtIndex:11] setState:NSMixedState];}
                if (dayNumber == 5) {[[schDay5Menu itemAtIndex:11] setState:NSMixedState];}
                if (dayNumber == 6) {[[schDay6Menu itemAtIndex:11] setState:NSMixedState];}
                if (dayNumber == 7) {[[schDay7Menu itemAtIndex:11] setState:NSMixedState];}
            } else if ((nowInMinutes >= 810) && (nowInMinutes < 860)) {
                //5th period
                if (dayNumber == 1) {[[schDay1Menu itemAtIndex:11] setState:NSOnState];}
                if (dayNumber == 2) {[[schDay2Menu itemAtIndex:11] setState:NSOnState];}
                if (dayNumber == 3) {[[schDay3Menu itemAtIndex:11] setState:NSOnState];}
                if (dayNumber == 4) {[[schDay4Menu itemAtIndex:11] setState:NSOnState];}
                if (dayNumber == 5) {[[schDay5Menu itemAtIndex:11] setState:NSOnState];}
                if (dayNumber == 6) {[[schDay6Menu itemAtIndex:11] setState:NSOnState];}
                if (dayNumber == 7) {[[schDay7Menu itemAtIndex:11] setState:NSOnState];}
            } else if ((nowInMinutes >= 860 && (nowInMinutes) < 865)) {
                //Before 6th period
                if (dayNumber == 1) {[[schDay1Menu itemAtIndex:13] setState:NSMixedState];}
                if (dayNumber == 2) {[[schDay2Menu itemAtIndex:13] setState:NSMixedState];}
                if (dayNumber == 3) {[[schDay3Menu itemAtIndex:13] setState:NSMixedState];}
                if (dayNumber == 4) {[[schDay4Menu itemAtIndex:13] setState:NSMixedState];}
                if (dayNumber == 5) {[[schDay5Menu itemAtIndex:13] setState:NSMixedState];}
                if (dayNumber == 6) {[[schDay6Menu itemAtIndex:13] setState:NSMixedState];}
                if (dayNumber == 7) {[[schDay7Menu itemAtIndex:13] setState:NSMixedState];}
            } else if ((nowInMinutes >= 865 && (nowInMinutes) < 915)) {
                //6th period
                if (dayNumber == 1) {[[schDay1Menu itemAtIndex:13] setState:NSOnState];}
                if (dayNumber == 2) {[[schDay2Menu itemAtIndex:13] setState:NSOnState];}
                if (dayNumber == 3) {[[schDay3Menu itemAtIndex:13] setState:NSOnState];}
                if (dayNumber == 4) {[[schDay4Menu itemAtIndex:13] setState:NSOnState];}
                if (dayNumber == 5) {[[schDay5Menu itemAtIndex:13] setState:NSOnState];}
                if (dayNumber == 6) {[[schDay6Menu itemAtIndex:13] setState:NSOnState];}
                if (dayNumber == 7) {[[schDay7Menu itemAtIndex:13] setState:NSOnState];}
            }
        }
    }
}

- (void)dctSetStatesOff {
    [dctDay0MenuItem setState:NSOffState];
    [dctDay1MenuItem setState:NSOffState];
    [dctDay2MenuItem setState:NSOffState];
    [dctDay3MenuItem setState:NSOffState];
    [dctDay4MenuItem setState:NSOffState];
    [dctDay5MenuItem setState:NSOffState];
    [dctDay6MenuItem setState:NSOffState];
    [dctDay7MenuItem setState:NSOffState];
    [dctDaySpecialMenuItem setState:NSOffState];
}

- (void)schSetStatesOff {
    if (specialState == 0) {
        for (int i=0; i<13; i++) {
            [[schDay1Menu itemAtIndex:i] setState:NSOffState];
            [[schDay2Menu itemAtIndex:i] setState:NSOffState];
            [[schDay3Menu itemAtIndex:i] setState:NSOffState];
            [[schDay4Menu itemAtIndex:i] setState:NSOffState];
            [[schDay5Menu itemAtIndex:i] setState:NSOffState];
            [[schDay6Menu itemAtIndex:i] setState:NSOffState];
            [[schDay7Menu itemAtIndex:i] setState:NSOffState];
        }
        if (assemblyState == 0) {
            [[schDay1Menu itemAtIndex:14] setState:NSOffState];
            [[schDay2Menu itemAtIndex:14] setState:NSOffState];
            [[schDay3Menu itemAtIndex:14] setState:NSOffState];
            [[schDay4Menu itemAtIndex:14] setState:NSOffState];
            [[schDay5Menu itemAtIndex:14] setState:NSOffState];
            [[schDay6Menu itemAtIndex:14] setState:NSOffState];
            [[schDay7Menu itemAtIndex:14] setState:NSOffState];
        }
    }
}

- (void)awakeFromNib {
    dayNumber = [[NSUserDefaults standardUserDefaults] integerForKey:@"dayNumberKey"];
    assemblyState = [[NSUserDefaults standardUserDefaults] integerForKey:@"assemblyStateKey"];
    specialState = [[NSUserDefaults standardUserDefaults] integerForKey:@"specialStateKey"];
    
    APeriodName = [[NSUserDefaults standardUserDefaults] stringForKey:@"APeriodNameKey"];
    BPeriodName = [[NSUserDefaults standardUserDefaults] stringForKey:@"BPeriodNameKey"];
    CPeriodName = [[NSUserDefaults standardUserDefaults] stringForKey:@"CPeriodNameKey"];
    DPeriodName = [[NSUserDefaults standardUserDefaults] stringForKey:@"DPeriodNameKey"];
    EPeriodName = [[NSUserDefaults standardUserDefaults] stringForKey:@"EPeriodNameKey"];
    FPeriodName = [[NSUserDefaults standardUserDefaults] stringForKey:@"FPeriodNameKey"];
    GPeriodName = [[NSUserDefaults standardUserDefaults] stringForKey:@"GPeriodNameKey"];
    
    dctMenuItem = [[NSStatusBar systemStatusBar] statusItemWithLength:NSVariableStatusItemLength];
    [dctMenuItem setMenu:dctMenu];
    [dctMenuItem setHighlightMode:YES];
    [self dctProcessing];
    
    schMenuItem = [[NSStatusBar systemStatusBar] statusItemWithLength:NSVariableStatusItemLength];
    [schMenuItem setMenu:schMenu];
    [schMenuItem setImage:[NSImage imageNamed:@"iconTemplate.png"]];
    [schMenuItem setHighlightMode:YES];
    [schMenu setSubmenu:schDay1Menu forItem:schDay1MenuItem];
    [schMenu setSubmenu:schDay2Menu forItem:schDay2MenuItem];
    [schMenu setSubmenu:schDay3Menu forItem:schDay3MenuItem];
    [schMenu setSubmenu:schDay4Menu forItem:schDay4MenuItem];
    [schMenu setSubmenu:schDay5Menu forItem:schDay5MenuItem];
    [schMenu setSubmenu:schDay6Menu forItem:schDay6MenuItem];
    [schMenu setSubmenu:schDay7Menu forItem:schDay7MenuItem];
    
    [inputAPeriod setStringValue:APeriodName];
    [inputBPeriod setStringValue:BPeriodName];
    [inputCPeriod setStringValue:CPeriodName];
    [inputDPeriod setStringValue:DPeriodName];
    [inputEPeriod setStringValue:EPeriodName];
    [inputFPeriod setStringValue:FPeriodName];
    [inputGPeriod setStringValue:GPeriodName];
    
    [self schWipeMenus];
    if (assemblyState == 0) {
        if (specialState == 0) {
            [self schFillMenus];
        } else {
            [self specialOn];
        }
    } else {
        [self assemblyOn];
        if (specialState == 1) {
            [dctSpecialMenuItem setState:NSOnState];
        }
    }
    
    if (dayNumber == 0) {[dctDay0MenuItem setState:NSOnState];}
    if (dayNumber == 1) {[dctDay1MenuItem setState:NSOnState];}
    if (dayNumber == 2) {[dctDay2MenuItem setState:NSOnState];}
    if (dayNumber == 3) {[dctDay3MenuItem setState:NSOnState];}
    if (dayNumber == 4) {[dctDay4MenuItem setState:NSOnState];}
    if (dayNumber == 5) {[dctDay5MenuItem setState:NSOnState];}
    if (dayNumber == 6) {[dctDay6MenuItem setState:NSOnState];}
    if (dayNumber == 7) {[dctDay7MenuItem setState:NSOnState];}
    if (dayNumber == -1) {[dctDaySpecialMenuItem setState:NSOnState];}
    
    schTimer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(schTimer:) userInfo:nil repeats:YES];
}

@end

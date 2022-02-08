#import <Cocoa/Cocoa.h>

@interface MyViewController
    : NSViewController <NSOutlineViewDelegate, NSOutlineViewDataSource> {
  NSMutableArray *data;
  NSString *currentPath;
  NSFileManager *fileManager;
}
@end

@implementation MyViewController
- (void)initWithDir:(NSString *)path view:(NSOutlineView *)view {
  self->data = [[NSMutableArray alloc] init];
  fileManager = [NSFileManager defaultManager];
  NSArray *files = [fileManager contentsOfDirectoryAtPath:path error:nil];
  for (NSString *file in files) {
    [self->data addObject:file];
  }
  self->currentPath = [fileManager displayNameAtPath:path];
  NSLog(@"current path: %@", self->currentPath);
  NSLog(@"internal data: %@", self->data);
  view.delegate = self;
  view.dataSource = self;
}
// protocol NSOutlineViewDataSource
- (id)outlineView:(NSOutlineView *)outlineView
            child:(NSInteger)index
           ofItem:(id)item {
  if (item == nil) {
    NSLog(@"index item: %@, %@", item, [data objectAtIndex:index]);
    return [data objectAtIndex:index];
  }

  if ([item isKindOfClass:[NSMutableArray class]]) {
    NSLog(@"index item: %@, %@", item, [item objectAtIndex:index]);
    return [item objectAtIndex:index];
  }

  NSLog(@"index item: %@, %@", item, item);
  return item;
}
- (BOOL)outlineView:(NSOutlineView *)outlineView isItemExpandable:(id)item {
  if ([item isKindOfClass:[NSString class]]) {
    NSLog(@"expandable item: %@", item);
    return false;
  }
  if ([item isKindOfClass:[NSMutableArray class]]) {
    NSLog(@"expandable item: %@", item);
    return true;
  }
  NSLog(@"non expandable item: %@", item);
  return false;
}
- (NSInteger)outlineView:(NSOutlineView *)outlineView
    numberOfChildrenOfItem:(id)item {
  // root
  if (item == nil) {
    NSLog(@"count item: %@, %lu", item, [data count]);
    return [data count];
  }

  if ([item isKindOfClass:[NSMutableArray class]]) {
    NSLog(@"count item: %@, %lu", item, [item count]);
    return [item count];
  }

  return 0;
}
// protocol NSOutlineViewDelegate
- (NSView *)outlineView:(NSOutlineView *)outlineView
     viewForTableColumn:(NSTableColumn *)tableColumn
                   item:(id)item {
  NSTextField *tf = [[NSTextField alloc] init];
  if ([item isKindOfClass:[NSString class]]) {
    NSString *path = (NSString *)item;
    [tf setStringValue:path];
    NSLog(@"to draw: %@", tf);
  }
  return tf;
}
@end

int main(int argc, const char *argv[]) {
  @autoreleasepool {
    NSApp = [NSApplication sharedApplication];
    NSRect frame = NSMakeRect(300, 300, 400, 400);
    NSWindow *myWindow =
        [[NSWindow alloc] initWithContentRect:frame
                                    styleMask:NSWindowStyleMaskTitled
                                      backing:NSBackingStoreBuffered
                                        defer:NO];
    [myWindow setTitle:@"outlineview"];
    NSOutlineView *myView = [[NSOutlineView alloc] initWithFrame:frame];
    // set delegate and data source
    [[MyViewController alloc] initWithDir:@"../../" view:myView];
    // table column init
    NSTableColumn *tableColumn = [[NSTableColumn alloc] init];
    tableColumn.resizingMask = NSTableColumnAutoresizingMask;
    [myView addTableColumn:tableColumn];
    // window bring up
    [myWindow setContentView:myView];
    [myWindow makeKeyAndOrderFront:nil];
    [NSApp run];
  }
  return (EXIT_SUCCESS);
}

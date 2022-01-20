#import <Cocoa/Cocoa.h>

@interface DemoView : NSView {
}
- (void)drawRect:(NSRect)rect;
@end

@implementation DemoView
#define X(t) (sin(t) + 1) * width * 0.5
#define Y(t) (cos(t) + 1) * height * 0.5
- (void)drawRect:(NSRect)rect {
  double const pi = 2 * acos(0.0);
  int n = 12;
  float width = [self bounds].size.width;
  float height = [self bounds].size.height;

  [[NSColor whiteColor] set];
  NSRectFill([self bounds]);

  [[NSColor blackColor] set];
  for (double f = 0; f < 2 * pi; f += 2 * pi / n) {
    for (double g = 0; g < 2 * pi; g += 2 * pi / n) {
      NSPoint p1 = NSMakePoint(X(f), Y(f));
      NSPoint p2 = NSMakePoint(X(g), Y(g));
      [NSBezierPath strokeLineFromPoint:p1 toPoint:p2];
    }
  }
}
- (void)windowWillClose:(NSNotification *)notification {
  [NSApp terminate:self];
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
    [myWindow setTitle:@"editor"];
    NSView *myView = [[DemoView alloc] initWithFrame:frame];
    [myWindow setContentView:myView];
    [myWindow makeKeyAndOrderFront:nil];
    [NSApp run];
  }
  return (EXIT_SUCCESS);
}

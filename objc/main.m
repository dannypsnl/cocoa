//
//  main.m
//  editor
//
//  Created by 林子篆 on 2022/1/9.
//
#import <Cocoa/Cocoa.h>

@interface DemoView : NSView {
}
- (void)drawRect:(NSRect)rect;
@end

@implementation DemoView                 // implementation of DemoView class
#define X(t) (sin(t) + 1) * width * 0.5  // macro for X(t)
#define Y(t) (cos(t) + 1) * height * 0.5 // macro for Y(t)
- (void)drawRect:(NSRect)rect {
  double f, g;
  double const pi = 2 * acos(0.0);

  int n = 12; // number of sides of the polygon

  // get the size of the application's window and view objects
  float width = [self bounds].size.width;
  float height = [self bounds].size.height;

  [[NSColor whiteColor] set]; // set the drawing color to white
  NSRectFill([self bounds]);  // fill the view with white

  // the following statements trace two polygons with n sides
  // and connect all of the vertices with lines

  [[NSColor blackColor] set]; // set the drawing color to black

  for (f = 0; f < 2 * pi; f += 2 * pi / n) { // draw the fancy pattern
    for (g = 0; g < 2 * pi; g += 2 * pi / n) {
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

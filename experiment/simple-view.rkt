#lang racket/base
(require ffi/unsafe
         ffi/unsafe/objc
         racket/math
         "../main.rkt")

(import-class NSColor
              NSBezierPath
              NSWindow
              NSApplication
              NSRect
              NSView)

(define app #f)

(define-cpointer-type _NSNotification)
(define-cocoa NSRectFill (_fun _id -> _void))

(define-objc-class MyView NSView
  ()
  (- _void (drawRect: [_NSRect rect])
     (define n 12)
     (define width 400)
     (define height 400)

     (tell (tell NSColor whiteColor) set)
     (NSRectFill (tell self bounds))

     (tell (tell NSColor blackColor) set)

     (define (x t) (* (add1 (sin t)) width 0.5))
     (define (y t) (* (add1 (cos t)) height 0.5))
     (for ([f (in-range (* 2 pi)
                        (/ (* 2 pi) n))])
       (for ([g (in-range (* 2 pi)
                          (/ (* 2 pi) n))])
         (define p1 (make-NSPoint (x f) (y f)))
         (define p2 (make-NSPoint (x g) (y g)))
         (tell NSBezierPath strokeLineFromPoint: p1 toPoint: p2))))
  (- _void (windowWillClose: [_NSNotification notification])
     (tell app terminate: #:type _id self)))

(call-with-autorelease
 (lambda ()
   (define frame (make-NSRect (make-NSPoint 300 300) (make-NSSize 400 400)))
   (define mainView (tell (tell MyView alloc)
                          initWithFrame: #:type _NSRect frame))

   (set! app (tell NSApplication sharedApplication))
   (define win (tell (tell NSWindow alloc)
                     initWithContentRect: #:type _NSRect frame
                     styleMask: #:type _int NSWindowStyleMaskTitled
                     backing: #:type _int NSBackingStoreBuffered
                     defer: NO))
   (tell win setTitle: #:type _NSString "test")
   (tell win setContentView: #:type _id mainView)
   (tell win makeKeyAndOrderFront: #f)
   (tell app run)))

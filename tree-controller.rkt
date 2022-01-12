#lang racket/base
(require ffi/unsafe
         ffi/unsafe/objc
         "main.rkt")

(import-class NSWindow
              NSApplication
              NSRect
              NSView
              NSOutlineView)

((get-ffi-obj 'signal #f (_fun _int _intptr -> _void)) 2 0)
(define app #f)

(define-cpointer-type _NSNotification)

(define-objc-class MyOutlineView NSOutlineView
  ()
  (- _void (windowWillClose: [_NSNotification notification])
     (tell app terminate: #:type _id self)))

(call-with-autorelease
 (lambda ()
   (define frame (make-NSRect (make-NSPoint 0 0) (make-NSSize 200 200)))
   (define mainView (tell (tell MyOutlineView alloc)
                          initWithFrame: #:type _NSRect frame))

   (set! app (tell NSApplication sharedApplication))
   (define win (tell (tell NSWindow alloc)
                     initWithContentRect: #:type _NSRect frame
                     styleMask: #:type _int NSWindowStyleMaskTitled
                     backing: #:type _int NSBackingStoreBuffered
                     defer: NO))
   (tell win setTitle: #:type _NSString "outlineview")
   (tell win setContentView: #:type _id mainView)
   (tell win makeKeyAndOrderFront: #f)
   (tell app run)))

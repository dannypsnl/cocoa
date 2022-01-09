#lang racket/base
(require ffi/unsafe
         ffi/unsafe/objc
         "types.rkt"
         "utils.rkt")

(import-class NSWindow
              NSApplication
              NSRect
              NSView
              NSOutlineView
              NSTreeController
              )

(call-with-autorelease
 (lambda ()
   (define frame (make-NSRect (make-NSPoint 0 0) (make-NSSize 200 200)))
   (define mainView (tell (tell NSOutlineView alloc)
                          initWithFrame: #:type _NSRect frame))

   (define app (tell NSApplication sharedApplication))
   (define win (tell (tell NSWindow alloc)
                     initWithContentRect: #:type _NSRect frame
                     styleMask: #:type _int 1
                     backing: #:type _int 2
                     defer: NO))
   (tell win setTitle: #:type _NSString "editor")
   (tell win setContentView: #:type _id mainView)
   (tell win makeKeyAndOrderFront: #f)
   (tell app run)))

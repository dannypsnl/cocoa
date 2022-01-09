#lang racket/base
(require ffi/unsafe
         ffi/unsafe/objc
         "types.rkt"
         "utils.rkt")

(import-class NSObject
              NSString
              NSWindow
              NSApplication
              NSRect
              NSView
              NSSplitViewController
              NSSplitView
              NSSplitViewItem
              NSOutlineView
              NSTreeController
              )

(define-cocoa NSLog (_fun _NSString -> _void))

(define-objc-class Photo NSObject
  (cap pho)
  (- _NSString (caption) cap)
  (- _NSString (photographer) pho)
  (- _void (setCaption: [_NSString input])
     (set! cap input))
  (- _void (setPhotographer: [_NSString input])
     (set! pho input))
  (- _void (dealloc)
     (tell cap release)
     (tell pho release)
     (super-tell dealloc)))

(define p (tell (tell Photo alloc) init))
(tell p setPhotographer: (->NSString "photo"))
(tell p setCaption: (->NSString "caption"))
(tell p photographer)
(NSLog "hkle")

(define frame (make-NSRect (make-NSPoint 0 0) (make-NSSize 200 200)))
(define mainView (tell (tell NSSplitView alloc)
                       initWithFrame: #:type _NSRect frame))

(define app (tell NSApplication sharedApplication))
(define win (tell (tell NSWindow alloc)
                  initWithContentRect: #:type _NSRect frame
                  styleMask: #:type _int 0
                  backing: #:type _int 2
                  defer: NO))
(tell win setTitle: #:type _NSString "editor")
(tell win setContentView: #:type _id mainView)
(tell win makeKeyAndOrderFront: #f)
(tell app run)

#lang racket/base
(require ffi/unsafe
         ffi/unsafe/objc
         ffi/unsafe/nsstring
         "utils.rkt")

(import-class NSObject
              NSString
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
(define pho (tell (tell NSString alloc)
                  initWithUTF8String: #:type _string "photo"))
(tell p setPhotographer: pho)
(NSLog "hkle")
(tell p dealloc)

(define mainView (tell (tell NSSplitView alloc) init))
(define mainViewC (tell NSSplitViewController alloc))
mainView

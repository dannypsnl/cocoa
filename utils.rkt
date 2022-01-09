#lang racket/base
(provide with-autorelease
         call-with-autorelease
         define-cocoa
         define-cf
         define-appserv
         define-appkit
         define-cg
         ->NSString
         ; version
         version-10.6-or-later?
         version-10.7-or-later?
         version-10.9-or-later?
         version-10.10-or-later?
         version-10.11-or-later?
         version-10.12-or-later?
         version-10.13-or-later?
         version-10.14-or-later?
         version-10.15-or-later?
         version-11.0-or-later?
         version-12.0-or-later?)

(require ffi/unsafe
         ffi/unsafe/objc
         ffi/unsafe/define
         ffi/unsafe/nsalloc)

(define cocoa-lib (ffi-lib (format "/System/Library/Frameworks/Cocoa.framework/Cocoa")))
(define cf-lib (ffi-lib (format "/System/Library/Frameworks/CoreFoundation.framework/CoreFoundation")))
(define appserv-lib (ffi-lib (format "/System/Library/Frameworks/ApplicationServices.framework/ApplicationServices")))
(define appkit-lib (ffi-lib (format "/System/Library/Frameworks/AppKit.framework/AppKit")))
(define cg-lib (ffi-lib (format "/System/Library/Frameworks/CoreGraphics.framework/CoreGraphics") #:fail (lambda () #f)))

(define-ffi-definer define-cocoa cocoa-lib)
(define-ffi-definer define-cf cf-lib)
(define-ffi-definer define-appserv appserv-lib)
(define-ffi-definer define-appkit appkit-lib)
(define-ffi-definer define-cg cg-lib)

(import-class NSString)
(define (->NSString s)
  (tell (tell NSString alloc)
        initWithUTF8String: #:type _string s))

(define-appkit NSAppKitVersionNumber _double)
(define (version-10.6-or-later?) ; Snow Leopard
  (NSAppKitVersionNumber . >= . 1038))
(define (version-10.7-or-later?) ; Lion
  (NSAppKitVersionNumber . >= . 1138))
(define (version-10.9-or-later?) ; Mavericks
  (NSAppKitVersionNumber . >= . 1265))
(define (version-10.10-or-later?) ; Yosemite
  (NSAppKitVersionNumber . >= . 1331))
(define (version-10.11-or-later?) ; El Capitan
  (NSAppKitVersionNumber . >= . 1404))
(define (version-10.12-or-later?) ; Sierra
  (NSAppKitVersionNumber . >= . 1504))
(define (version-10.13-or-later?) ; High Sierra
  (NSAppKitVersionNumber . >= . 1561))
(define (version-10.14-or-later?) ; Mojave
  (NSAppKitVersionNumber . >= . 1671))
(define (version-10.15-or-later?) ; Catalina
  (NSAppKitVersionNumber . >= . 1700))
(define (version-11.0-or-later?) ; Big Sur
  (NSAppKitVersionNumber . >= . 2000))
(define (version-12.0-or-later?) ; Monterey
  (NSAppKitVersionNumber . >= . 2100))

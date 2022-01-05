#lang racket/base
(require ffi/unsafe/objc)

(import-class NSSplitViewController
              NSSplitView
              NSSplitViewItem
              NSOutlineView
              NSTreeController
              )

(with-autorelease
    (define treeView (tell NSOutlineView alloc))
  (define editorView (tell NSOutlineView alloc))
  (define mainView (tell NSSplitView alloc))
  (define mainViewC (tell NSSplitViewController alloc))
  (tellv mainViewC addSplitViewItem: treeView)
  (tellv mainViewC addSplitViewItem: editorView)

  )

//
//  InitiatePrinting.swift
//  
//
//  Created by Wolf McNally on 2/4/21.
//

import SwiftUI

public enum PageFitting {
    case fitToPrintableRect
    case fitToPaper
}

public func presentPrintInteractionController<Page>(page: Page, fitting: PageFitting = .fitToPrintableRect) where Page: View {
    let printController = UIPrintInteractionController()
    printController.printPageRenderer = PageRenderer(page: page, fitting: fitting)
    printController.present(animated: true, completionHandler: nil)
}

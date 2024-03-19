//
//  PDFGeneration.swift
//  DadosCatan
//
//  Created by coni garcia on 18/03/2024.
//

import SwiftUI
import Foundation
import PDFKit

@MainActor func tablePDF(game: Game, path: String) -> URL {
    let renderer = ImageRenderer(content: PDFGameTable(game: game).frame(width: 393).padding())
    let url = URL.documentsDirectory.appending(path: path)
    renderer.render { size, context in
        var pdfDimension = CGRect(x: 0, y: 0, width: size.width, height: size.height)
        
        guard let pdf = CGContext(url as CFURL, mediaBox: &pdfDimension, nil) else {
            return
        }
        pdf.beginPDFPage(nil)
        context(pdf)
        pdf.endPDFPage()
        pdf.closePDF()
    }
    return url
}

@MainActor func chartPDF(game: Game, path: String) -> URL {
    let renderer = ImageRenderer(content: PDFGameChart(game: game).frame(width: 393).padding())
    let url = URL.documentsDirectory.appending(path: path)
    renderer.render { size, context in
        var pdfDimension = CGRect(x: 0, y: 0, width: size.width, height: size.height)
        
        guard let pdf = CGContext(url as CFURL, mediaBox: &pdfDimension, nil) else {
            return
        }
        pdf.beginPDFPage(nil)
        context(pdf)
        pdf.endPDFPage()
        pdf.closePDF()
    }
    return url
}

@MainActor func totalPDF(path: String) -> URL {
    let renderer = ImageRenderer(content: PDFTotalCharts().frame(width: 393).padding().modelContainer(for: Game.self))
    let url = URL.documentsDirectory.appending(path: path)
    renderer.render { size, context in
        var pdfDimension = CGRect(x: 0, y: 0, width: size.width, height: size.height)
        
        guard let pdf = CGContext(url as CFURL, mediaBox: &pdfDimension, nil) else {
            return
        }
        pdf.beginPDFPage(nil)
        context(pdf)
        pdf.endPDFPage()
        pdf.closePDF()
    }
    return url
}

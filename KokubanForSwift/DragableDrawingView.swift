//
//  DragableDrawingView.swift
//  KokubanForSwift
//
//  Created by 平塚俊輔 on 2021/05/13.
//  Copyright © 2021 HIRATSUKA SHUNSUKE. All rights reserved.
//

import CoreGraphics
import UIKit

struct Drawing {
    var color = UIColor.black
    var points = [CGPoint]()
}

import UIKit

class DragableDrawingView: UIView {
    
    var isDraw: Bool = false
    
    var currentDrawing: Drawing?
    var finishedDrawings = [Drawing]()
    var currentColor = UIColor.white
    
    override func draw(_ rect: CGRect) {
        for drawing in finishedDrawings {
            drawing.color.setStroke()
            stroke(drawing: drawing)
        }
        
        if let drawing = currentDrawing {
            drawing.color.setStroke()
            stroke(drawing: drawing)
        }
    }
    
    open override func addSubview(_ view: UIView){
        super.addSubview(view)
        view.center = center
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        // [1]
        guard let touch = touches.first
              , let view = touch.view else { return }
        
        if view != self{
            isDraw = false
        }else{
            isDraw = true
        }
        
        let location = touch.location(in: self)
        currentDrawing = Drawing()
        currentDrawing?.color = currentColor
        currentDrawing?.points.append(location)
        setNeedsDisplay()
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        
        if isDraw{
            let touch = touches.first!
            let location = touch.location(in: self)
                    
            currentDrawing?.points.append(location)
            
            setNeedsDisplay()
        }else{
            dragMoved(touches, with: event)
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        if isDraw{
            if var drawing = currentDrawing {
                let touch = touches.first!
                let location = touch.location(in: self)
                drawing.points.append(location)
                finishedDrawings.append(drawing)
            }
            currentDrawing = nil
            setNeedsDisplay()
        }else{
            dragMoved(touches, with: event)
        }
        
        
    }
    
    func clear() {
        finishedDrawings.removeAll()
        setNeedsDisplay()
    }
    
    func undo() {
        if finishedDrawings.count == 0 {
            return
        }
        finishedDrawings.remove(at: finishedDrawings.count - 1)
        setNeedsDisplay()
    }
    
    func setDrawingColor(color : UIColor){
        currentColor = color
    }
    
    func stroke(drawing: Drawing) {
        let path = UIBezierPath()
        path.lineWidth = 10.0
        path.lineCapStyle = .round
        path.lineJoinStyle = .round
        
        let begin = drawing.points[0];
        path.move(to: begin)
        
        if drawing.points.count > 1 {
            for i in 1...(drawing.points.count - 1) {
                let end = drawing.points[i]
                path.addLine(to: end)
            }
        }
        path.stroke()
    }
}


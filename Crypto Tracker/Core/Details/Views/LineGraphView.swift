//
//  ChartView.swift
//  Crypto Tracker
//
//  Created by shopnil hasan on 27/12/24.
//

import SwiftUI
import Charts

struct LineGraphView: View {
    let data: [Double]
    let lineColor: Color
    @State private var selectedIndex: Int? = nil
    
    init(coin: CoinModel) {
        self.data = coin.sparklineIn7D?.price ?? []
        let line = (data.last ?? 0) - (data.first ?? 0)
        print(line)
        lineColor = line >= 0 ? Color.green : Color.red
    }
    // Skipped data points
    var filteredData: [Double] {
        data.enumerated().compactMap { index, value in
            index % 20 == 0 ? value : nil
        }
    }
    
    var body: some View {
        GeometryReader { geometry in
            let path = createPath(in: geometry.size)
            let gradientPath = createGradientPath(in: geometry.size)
            let graphWidth = geometry.size.width
            let pointSpacing = graphWidth / CGFloat(filteredData.count - 1)
            
            ZStack {
                // Gradient below the line
                gradientPath
                    .fill(
                        LinearGradient(
                            gradient: Gradient(colors: [lineColor.opacity(0.3), Color.clear]),
                            startPoint: .top,
                            endPoint: .bottom
                        )
                    )
                
                // Draw the graph line
                path
                    .stroke(lineColor, lineWidth: 2)
                    .shadow(color: .gray.opacity(0.5), radius: 5)
                
                // Add points on the graph
                ForEach(0..<filteredData.count, id: \.self) { index in
                    let point = pointPosition(for: index, in: geometry.size)
                    Circle()
                        .fill(lineColor)
                        .frame(width: 6, height: 6)
                        .position(point)
                }
                
                // Indicator for selected point
                if let selectedIndex = selectedIndex {
                    let point = pointPosition(for: selectedIndex, in: geometry.size)
                    let value = filteredData[selectedIndex]
                    
                    VStack(spacing: 4) {
                        Text(String(format: "%.2f", value))
                            .font(.caption)
                            .padding(6)
                            .background(Color.white)
                            .cornerRadius(6)
                            .shadow(radius: 3)
                        
                        Circle()
                            .fill(Color.red)
                            .frame(width: 10, height: 10)
                    }
                    .position(point)
                    .offset(y: -10)
                }
            }
            .gesture(
                DragGesture()
                    .onChanged { value in
                        // Find the nearest index based on drag location
                        let index = Int(round(value.location.x / pointSpacing))
                        if index >= 0 && index < filteredData.count {
                            selectedIndex = index
                        }
                    }
            )
        }
    }
    
    private func createPath(in size: CGSize) -> Path {
        var path = Path()
        let scaleX = size.width / CGFloat(filteredData.count - 1)
        let scaleY = size.height / (filteredData.max() ?? 1.0)
        let offsetY = (filteredData.min() ?? 0) < 0 ? CGFloat(filteredData.min()!) * scaleY : 0
        
        for index in filteredData.indices {
            let x = CGFloat(index) * scaleX
            let y = size.height - (CGFloat(filteredData[index]) * scaleY + offsetY)
            
            if index == 0 {
                path.move(to: CGPoint(x: x, y: y))
            } else {
                path.addLine(to: CGPoint(x: x, y: y))
            }
        }
        
        return path
    }
    
    private func createGradientPath(in size: CGSize) -> Path {
        var path = createPath(in: size)
        let scaleX = size.width / CGFloat(filteredData.count - 1)
        
        // Extend the path down to the bottom of the graph
        path.addLine(to: CGPoint(x: CGFloat(filteredData.count - 1) * scaleX, y: size.height))
        path.addLine(to: CGPoint(x: 0, y: size.height))
        path.closeSubpath()
        
        return path
    }
    
    private func pointPosition(for index: Int, in size: CGSize) -> CGPoint {
        let scaleX = size.width / CGFloat(filteredData.count - 1)
        let scaleY = size.height / (filteredData.max() ?? 1.0)
        let offsetY = (filteredData.min() ?? 0) < 0 ? CGFloat(filteredData.min()!) * scaleY : 0
        
        let x = CGFloat(index) * scaleX
        let y = size.height - (CGFloat(filteredData[index]) * scaleY + offsetY)
        return CGPoint(x: x, y: y)
    }
}


#Preview {
    LineGraphView(coin: .placeHolder)
        .padding(30)
}

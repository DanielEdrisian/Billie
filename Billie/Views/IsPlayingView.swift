//
//  IsPlayingView.swift
//  HackNC2020
//
//  Created by Samuel Shi on 10/17/20.
//

import SwiftUI

struct IsPlayingView: View {
    
    @State private var isAnimating: Bool = false
    
    let ratios: [CGFloat] = [0.7, 0.5, 0.9, 0.6]
    
    var body: some View {
        VStack {
            HStack {
                ForEach (0..<4) { i in
                    GeometryReader { geo in
                        RoundedRectangle(cornerRadius: geo.size.height / 10)
                            .scaleEffect(x: 1, y: isAnimating ? ratios[i] : ratios[(i + 2)%4], anchor: .center)
                            .animation(Animation.default.repeatForever(autoreverses: true))
                    }
                }
            }
        }
        .onAppear {
            isAnimating = true
        }
        .scaleEffect(0.5)
    }
    
    func barHeight(index: Int, height: CGFloat) -> CGFloat {
        height / (isAnimating ? CGFloat((index + 2) % 4 + 1) : CGFloat(index + 1))
    }
}

struct IsPlayingView_Previews: PreviewProvider {
    static var previews: some View {
        IsPlayingView()
            .frame(width: 100, height: 100)
            .background(Circle().fill(Color.green))
            .foregroundColor(.white)
    }
}

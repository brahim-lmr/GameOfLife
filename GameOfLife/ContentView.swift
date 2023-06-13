//
//  ContentView.swift
//  GameOfLife
//
//  Created by Brahim Lamri on 9/6/2023.
//

import SwiftUI

enum Constant {
    static let horizontalInset: CGFloat = 16.0
}

struct ContentView: View {
    
    @StateObject private var game = Game(numberOfRows: 15, numberOfColums: 10)
    
    var body: some View {
        VStack {
            
            Text("GAME OF LIFE")
                .font(.largeTitle)
                .foregroundColor(.blue)
                .padding(Constant.horizontalInset)
            
            GeometryReader { geometry in
                VStack(spacing: .zero) {
                    ForEach(game.grid, id: \.self) { row in
                        HStack(spacing: .zero) {
                            ForEach(row, id: \.self) { cell in
                                Rectangle()
                                    .fill(fillColorForCell(state: cell.state))
                                    .frame(
                                        width: calculateCellWidth(in: geometry),
                                        height: calculateCellWidth(in: geometry)
                                    )
                                    .border(.gray.opacity(0.5), width: 1)
                                    .onTapGesture {
                                        game.grid[cell.x][cell.y]
                                            .state
                                            .toggle()
                                    }
                            }
                        }
                    }
                }
                .border(.gray.opacity(0.5), width: 2)
            }
            .padding(.horizontal, Constant.horizontalInset)
            
            Button(action: {
            }) {
                Text("LAUNCH THE GAME")
                    .frame(maxWidth: .infinity)
                    .font(.headline)
            }
            .padding(.horizontal, Constant.horizontalInset)
            .tint(.blue)
            .buttonStyle(.borderedProminent)
            .buttonBorderShape(.automatic)
            .controlSize(.large)
            
        }
        .onAppear {
            initializeGame()
        }
        
    }
    
    private func calculateCellWidth(in geometry: GeometryProxy) -> CGFloat {
       (geometry.size.width) / CGFloat(game.numberOfColums)
    }
    
    private func fillColorForCell(state: CellState) -> Color {
        switch state {
        case .alive:
            return .blue
        case .dead:
            return .clear
        }
    }
    
    private func initializeGame() {
        for _ in 0...75 {
            let x = getXRandomLocation()
            let y = getYRandomLocation()
            
            game.grid[x][y]
                .state
                .toggle()
        }
    }
    
    private func getXRandomLocation() -> Int {
        return Int(arc4random()) % game.numberOfRows
    }
    
    private func getYRandomLocation() -> Int {
        return Int(arc4random()) % game.numberOfColums
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

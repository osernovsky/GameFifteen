//
//  ContentView.swift
//  GameFifteen
//
//  Created by Sergey Dubrovin on 19.01.2025.
//

import SwiftUI

struct ContentView: View {
    
    @State private var field = Field(size: 2)
    @State private var filedSolved: Bool = false
    @State private var LevelSelect: Bool = false
    @State private var moveCount: Int = 0
    @StateObject private var records = Records.shared
    
    var body: some View {
        
        ZStack {
            
            RadialGradient(gradient: Gradient(colors: [color2, color1]), center: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/, startRadius: 100, endRadius: 500)
                .ignoresSafeArea()
            
            VStack {
                Text("15")
                    .font(.system(size: 150))
                    .bold()
                    .foregroundStyle(Color.white)
                    .multilineTextAlignment(.center)
                    .cornerRadius(10)
                
                Text("Текущий уровень - \(field.size)x\(field.size)")
                    .foregroundStyle(Color.white)
                    .font(.title2)
                
                Spacer()
                
                if records.recordTable[field.size - 2] == 0 {
                    Text("Рекорда еще нет. Сейчас - \(moveCount) ходов")
                        .foregroundStyle(Color.white)
                        .padding(30)
                } else {
                    Text("Рекорд поля - \(records.recordTable[field.size - 2]). Сейчас - \(moveCount) ходов")
                        .foregroundStyle(Color.white)
                        .padding(30)
                }
                
                HStack {
                    Button {
                        LevelSelect = true
                    } label: {
                        Text("Выбрать уровень")
                            .font(.title2)
                    }
                    .padding(20)
                    .background(color4)
                    .foregroundStyle(Color.white)
                    .cornerRadius(10)
                    .padding(10)
                    
                    Spacer()
                    
                    Button {
                        moveCount = 0
                        field.newGame()
                    } label: {
                        Text("Заново")
                            .font(.title2)
                    }
                    .padding(20)
                    .background(color4)
                    .foregroundStyle(Color.white)
                    .cornerRadius(10)
                    .padding(10)
                }
            }
            
            GeometryReader { geometry in
                let tileSize = geometry.size.width / CGFloat(field.size) // Размер плитки
                let padding: CGFloat = CGFloat(10 - field.size)
                
                ZStack {
                    ForEach(field.tiles) { tile in
                        let isHome = tile.row * field.size + tile.col + 1 == tile.value
                        if tile.value != 0 {
                            Rectangle()
                                .fill(isHome ? color2 : color5)
                                .cornerRadius(CGFloat(40 / field.size))
                                .frame(width: tileSize - padding, height: tileSize - padding)
                                .overlay(
                                    Text("\(tile.value)")
                                        .foregroundColor(.white)
                                        .font(.system(size: tileSize / 3))
                                )
                                .position(x: CGFloat(tile.col) * tileSize + tileSize / 2,
                                          y: CGFloat(tile.row) * tileSize + tileSize / 2)
                                .animation(Animation.easeInOut(duration: 0.2), value: tile.row)
                                .animation(Animation.easeInOut(duration: 0.2), value: tile.col)
                                .onTapGesture {
                                    handleTileTap(tile)
                                }
                        }
                    }
                }
                .background(color3)
                .cornerRadius(CGFloat(40 / field.size))
                .frame(width: geometry.size.width, height: geometry.size.width)
                .position(x: geometry.size.width / 2, y: geometry.size.height / 2 + 30)
            }
            .alert("Поле \(field.size)x\(field.size) пройдено", isPresented: $filedSolved) {
                Button("OK", role: .cancel) {
                    if moveCount < Records.shared.recordTable[field.size - 2] || Records.shared.recordTable[field.size - 2] == 0 {
                        Records.shared.recordTable[field.size - 2] = moveCount
                        Records.shared.saveRecord()
                    }
                    field.size = min(field.size + 1, 6)
                    moveCount = 0
                    field.newGame()
                }
            } message: {
                Text("На прохождение потрачено \(moveCount) ходов!")
            }
            
            .alert("Выберите уровень", isPresented: $LevelSelect) {
                Button("Поле 2х2") { field.size = 2
                    moveCount = 0
                    field.newGame()}
                Button("Поле 3х3") { field.size = 3
                    moveCount = 0
                    field.newGame()}
                Button("Поле 4х4") { field.size = 4
                    moveCount = 0
                    field.newGame()}
                Button("Поле 5х5") { field.size = 5
                    moveCount = 0
                    field.newGame()}
                Button("Поле 6х6") { field.size = 6
                    moveCount = 0
                    field.newGame()}
                Button("Отмена", role: .cancel) {}
            }
        }
    }
    
    private func handleTileTap(_ tile: Tile) {
        guard let index = field.tiles.firstIndex(where: { $0.id == tile.id }) else { return }
        if field.move(at: index) { moveCount += 1 }
        if field.tableSolved() {
            filedSolved = true
        }
    }
    
}

#Preview {
    ContentView()
}

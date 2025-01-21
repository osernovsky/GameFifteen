//
//  HexToColor.swift
//  GameFifteen
//
//  Created by Sergey Dubrovin on 21.01.2025.
//

import SwiftUI

import SwiftUI

extension Color {
    init?(hex: String) {
        // Удаляем пробелы и символ #
        var hexSanitized = hex.trimmingCharacters(in: .whitespacesAndNewlines)
        hexSanitized = hexSanitized.replacingOccurrences(of: "#", with: "")

        // Проверяем, что строка имеет правильную длину (6 или 8 символов)
        guard hexSanitized.count == 6 || hexSanitized.count == 8 else {
            return nil
        }

        // Переменная для хранения RGB(A)
        var rgb: UInt64 = 0
        Scanner(string: hexSanitized).scanHexInt64(&rgb)

        // Извлекаем компоненты
        let red = Double((rgb >> 16) & 0xFF) / 255.0
        let green = Double((rgb >> 8) & 0xFF) / 255.0
        let blue = Double(rgb & 0xFF) / 255.0

        // Если длина HEX равна 8 символам, извлекаем альфа-компонент
        let alpha: Double
        if hexSanitized.count == 8 {
            alpha = Double((rgb >> 24) & 0xFF) / 255.0
        } else {
            alpha = 1.0
        }

        // Создаем Color
        self.init(red: red, green: green, blue: blue, opacity: alpha)
    }
}

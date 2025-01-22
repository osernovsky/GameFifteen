//
//  Leaders.swift
//  GameFifteen
//
//  Created by Sergey Dubrovin on 21.01.2025.
//


import Foundation

class Records: ObservableObject {
    
    static let shared = Records()
    private static let storageKey: String = "MaxScoreData"
    
    @Published var recordTable = [0, 0, 0, 0, 0]
    
    func saveRecord() {
        
        do {
            let data = try JSONEncoder().encode(recordTable)
            UserDefaults.standard.set(data, forKey: Records.storageKey)
        } catch {
            print("Ошибка записи данных: \(error)")
        }
    }
    
    func loadRecord() {
        
        guard let data = UserDefaults.standard.data(forKey: Records.storageKey) else {
            saveRecord()
            return
        }
        
        do {
            recordTable = try JSONDecoder().decode([Int].self, from: data)
        } catch {
            print("Ошибка загрузки данных: \(error)")
        }
    }
    
    func deleteRecord() {
        UserDefaults.standard.removeObject(forKey: Records.storageKey)
    }
}

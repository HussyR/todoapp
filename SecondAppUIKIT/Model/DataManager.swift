//
//  DataManager.swift
//  SecondAppUIKIT
//
//  Created by Данил on 16.01.2022.
//

import Foundation

struct DataManager {
    
    static func documentDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
    
    static func dataFilePath() -> URL {
        return documentDirectory().appendingPathComponent("Checklists.plist")
    }
    
    static func writeData(data: [Model]) {
        let encoder = PropertyListEncoder()
        do {
            let data = try encoder.encode(data) // кодируем в binary code
            try data.write(to: dataFilePath(), options: .atomic) // записываем в файл
            
        } catch {
            print(error.localizedDescription)
        }
        
    }
    
    static func downloadData(closure: ([Model]) -> ()) {
        let path = dataFilePath()
        guard let data = try? Data(contentsOf: path) else {return}
        let decoder = PropertyListDecoder()
        do {
            let items = try decoder.decode([Model].self, from: data)
            closure(items)
        } catch {
            print(error.localizedDescription)
        }
    }
    
    
}

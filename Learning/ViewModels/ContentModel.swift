//
//  ContentModel.swift
//  Learning
//
//  Created by 王柏凱 on 2021-12-07.
//

import Foundation

class ContentModel: ObservableObject {
    @Published var modules = [Module]()
    var styleData: Data?
    
    // Current module
    @Published var currentModule: Module?
    var currentModuleIndex = 0
    
    init() {
        getLocalData()
    }
    
    // MARK: - Data methods
    func getLocalData(){
        // Get a url
        let url = Bundle.main.url(forResource: "data", withExtension: "json")
        
        // Read the file into a data object
        guard url != nil else {
            return
        }
        
        // Try to decode the json into an array of module
        do {
            let jsonData = try Data(contentsOf: url!)
            let parsedData = try JSONDecoder().decode([Module].self, from: jsonData)
            // Assign parsed modules to modules property
            self.modules = parsedData
          
        } catch {
            // TODO: log error
            print("Couldn't parse local data")
        }
        
        // Parse the style data
        let styleUrl = Bundle.main.url(forResource: "style", withExtension: "html")
        guard styleUrl != nil else {
            return
        }
        do {
            let styleData = try Data(contentsOf: styleUrl!)
            self.styleData = styleData
        }
        catch {
            print("Couldn't parse style data")
        }
    }
    
    // MARK: - Module navigation methods
    func beginModule(moduleId:Int) {
        // Find the index for passed module id
        for index in 0..<modules.count {
            if modules[index].id == moduleId {
                // Find the matching module
                currentModuleIndex = index
                break
            }
        }
        // Set the current module
        currentModule = modules[currentModuleIndex]
    }
}

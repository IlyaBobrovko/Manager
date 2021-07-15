import Foundation

/**
 Settings storage.
 */
class SettingsStorage {
        
    private let settingsKey = "settings"

    /**
     Returns application settings stored in storage,
     
     - Returns: Settings.
     */
    func getSettings() throws -> Settings?  {
        if let settings = UserDefaults.standard.data(forKey: settingsKey) {
            
            let decoder = JSONDecoder()
            
            let settings = try decoder.decode(Settings.self, from: settings)
            
            return settings
        }
        else {
            return nil
        }
    }
    
    /**
     Write new settings to storage.
     
     - Parameters:
        - settings: Settings.
     */
    func setSettings(_ settings: Settings) throws {
        let encoder = JSONEncoder()
        
        let data = try encoder.encode(settings)
        
        UserDefaults.standard.setValue(data, forKey: settingsKey)
    }
    
}

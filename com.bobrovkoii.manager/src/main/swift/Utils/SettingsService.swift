import Foundation

/**
 Settings service. Provides work with application settings.
 */
class SettingsService {
    
    private let urlKey = "url"
    
    private let daysCountKey = "daysCount"
    
    private let elementsCountKey = "elementsCount"
        
    private let settingsStorage = SettingsStorage()
    
    private var settings: Settings

    /**
     Load settings from storage or read from file.

     - Throws: Settings Error.
     */
    init() throws {
        if let settings = try settingsStorage.getSettings() {
            self.settings = settings
        }
        else {
            let reader = FileReader()
            
            let file = try reader.read(file: "application", ofType: "properties")
            let map = try reader.parseFile(file)

            guard let url = map[urlKey] else {
                throw SettingsError(message: "Ошибка чтения поля `URL`")
            }
            
            guard let daysCountString = map[daysCountKey],
                let daysCount = Int(daysCountString) else {
                throw SettingsError(message: "Ошибка чтения поля `Количество дней`")
            }
            
            guard let elementsCountString = map[elementsCountKey],
                let elementsCount = Int(elementsCountString) else {
                throw SettingsError(message: "Ошибка чтения поля `Максимальное количество элементов`")
            }
            
            self.settings = Settings(url: url, elementCount: elementsCount, daysCount: daysCount)
        }
    }
    
    /**
     Get current application settings.
     
     - Returns: Settings.
     */
    func getSettings() -> Settings {
        return settings
    }
    
    /**
     App settings setter. Set new settings for application.
     
     - Parameters:
        - settings: New settings.
     */
    func setSettings(_ settings: Settings) throws {
        self.settings = settings
        
        try settingsStorage.setSettings(settings)
    }
}

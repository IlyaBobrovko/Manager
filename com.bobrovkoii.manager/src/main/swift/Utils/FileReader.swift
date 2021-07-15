import Foundation

/**
 File reader. Executes reading file. Used for reading application settings file.
 */
class FileReader {
    
    private let propertySeparator = "="
    
    private let elementsInLine = 2
    
    /**
     Read and return file.
     
     - Parameters:
        - name: File name.
        - type: File type.
     - Throws: Settings error.
     - Returns: Text from file.
     */
    func read(file name: String, ofType type: String) throws -> String {
        guard let file = Bundle.main.path(forResource: name, ofType: type) else {
            throw FileReaderError(message: "Не удалось прочитать файл \(name).\(type).")
        }
        return file
    }
    
    /**
     Parse file to map.
     
     - Parameters:
        - file: File.
     - Throws: Settings Error.
     - Returns: map with properties.
     */
    func parseFile(_ file: String) throws -> [String : String] {
        let unwrapper = Unwrapper()
        var map = [String : String]()
        
        let text = try String(contentsOfFile: file)
        
        let lines = text.components(separatedBy: .newlines)
        for line in lines {
            
            if line.isEmpty {
                // Skip empty lines if file.
                continue
            }
            
            let components = line.components(separatedBy: propertySeparator)
            if components.count != elementsInLine {
                throw FileReaderError(message: "Неверный формат файла.")
            }
            
            let key = try unwrapper.unwrap(components.first)
            let value = try unwrapper.unwrap(components.last)
            map[key] = value
        }
        return map
    }
}

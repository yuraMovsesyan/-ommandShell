import Foundation

class Task{
    var Path: URL
    var Arguments: [String]

    private let PtilityProcess = Process()

    convenience init(line: String){
        let lines = line.components(separatedBy: " ")
        
        if lines.count == 1{
            self.init(utility: lines[0])
        }
        else{
            self.init(utility: lines[0], args: lines)
        }
    }

    init(utility: String, args: [String] = []){
        Path = URL(fileURLWithPath: "/bin/\(utility)")
        Arguments = args
    }

    func Run(){
        PtilityProcess.executableURL = Path
        PtilityProcess.arguments = Arguments

        let outputPipe = Pipe()

        PtilityProcess.standardOutput = outputPipe

        let outputData = outputPipe.fileHandleForReading.readDataToEndOfFile()

        let output = String(decoding: outputData, as: UTF8.self) 

        print(output)
    }
}
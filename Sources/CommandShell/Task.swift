import Foundation

class Task{
    var Path: URL
    var Arguments: [String]

    private let PtilityProcess = Process()

    convenience init(_ line: String){
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

    func Run() throws{
        
        let outputPipe = Pipe()
        let errorPipe = Pipe()


        PtilityProcess.standardOutput = outputPipe
        PtilityProcess.standardError = errorPipe
        

        PtilityProcess.arguments = Arguments
        PtilityProcess.executableURL = Path

        PtilityProcess.standardInput = nil

        try PtilityProcess.run()
        
        //PtilityProcess.standardError = errorPipe

        let outputData = outputPipe.fileHandleForReading.readDataToEndOfFile()
        let errorData = errorPipe.fileHandleForReading.readDataToEndOfFile()

        let output = String(decoding: outputData, as: UTF8.self) 
        let error = String(decoding: errorData, as: UTF8.self)

        print (output, terminator: " ")
        print (error)
        print(PtilityProcess.terminationStatus)
    }
}
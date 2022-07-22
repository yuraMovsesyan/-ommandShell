import Foundation

class Cshrc{

    private var _Value: String

    var Value: String { _Value }

    init(){
        _Value = ">"
    }

    func ReadLine() -> String{
        print(Value, terminator: " ")
        return readLine()!
    }

}
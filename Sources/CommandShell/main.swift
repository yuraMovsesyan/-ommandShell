let cshrc: Cshrc = Cshrc()
//var task: Task
repeat {
    let task = Task(cshrc.ReadLine())

    do {
        try task.Run()
    }
    catch {
        print("\(error)") //handle or silence the error here
    }
} while true
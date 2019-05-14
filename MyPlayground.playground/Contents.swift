import UIKit

var str = "Hello, playground"

func greeting(){
    print("hello There!")
    
}

greeting()

func greeting2() -> String {
    return "Hello there mr. "
}

print(greeting2())


func greeting3(message: String){
    print(message)

}

greeting3(message: "Dynamic Message")

func greeting4(message: String) -> String{ // to parametre
    return message.uppercased()
}

print(greeting4(message: "Det lille frø som voksede..."))

var closure1 = { (txt: String) in
    print("inside a closure \(txt)")
}

closure1("hello")

let numbers = [3,6,1,241,22,41,12]
 let sorted = numbers.sorted { (n1:Int, n2: Int) in
    return n1 < n2
    
}
print(sorted)

let filteredNumbers = numbers.filter { (number) in
    return number % 3 == 0
    
}
print(filteredNumbers)


let filteredNumbers2 = numbers.filter { $0 % 3 == 0}
print(filteredNumbers2)


var number1 = numbers.map({$0*2})
print(number1)



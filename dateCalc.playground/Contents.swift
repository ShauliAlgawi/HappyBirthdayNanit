import UIKit

var birthDate = "02/12/2023"


let dateFormatter = DateFormatter()
dateFormatter.dateFormat = "dd/MM/yy"
if let date = dateFormatter.date(from: birthDate) {
    let diffs = Calendar.current.dateComponents([.year, .month], from: date, to: Date())
    print(diffs)
} else {
    print("NA")
}

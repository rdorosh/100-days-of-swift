import UIKit
import PlaygroundSupport

let name = "Taylor"

for letter in name {
    print("Give me a \(letter)!")
}

let letter = name[name.index(name.startIndex, offsetBy: 3)]

extension String {
    subscript(i: Int) -> String {
        return String(self[index(startIndex, offsetBy: i)])
    }
}

let letter2 = name[3]


let password = "12345"
password.hasPrefix("123")
password.hasSuffix("456")

extension String {
    func deletingPrefix(_ preffix: String) -> String {
        guard self.hasPrefix(preffix) else {return self}
        return String(self.dropFirst(preffix.count))
    }
}

extension String {
    func deletingSuffix(_ suffix: String) -> String {
        guard self.hasSuffix(suffix) else {return self}
        return String(self.dropFirst(suffix.count))
    }
}

let weather = "it's going to rain"
print(weather.capitalized)

extension String {
    var capitalizedFirst: String {
        guard let firstLetter = self.first else {return ""}
        return firstLetter.uppercased() + self.dropFirst()
    }
}


let input = "Swift is like Objective-C without the C"
input.contains("Swift")

let languages = ["Python", "Ruby", "Swift"]
languages.contains("Swift")

extension String {
    func containsAny(of array: [String]) -> Bool {
        for item in array {
            if self.contains(item) {
                return true
            }
        }
        
        return false
    }
}


input.containsAny(of: languages)

languages.contains(where: input.contains)


//let string = "This is a test string"

let attributes: [NSAttributedString.Key: Any] = [
    .foregroundColor: UIColor.white,
    .backgroundColor: UIColor.red,
    .font: UIFont.boldSystemFont(ofSize: 36)
]

//let attributedString = NSAttributedString(string: string, attributes: attributes)


let string = "This is a test string"
let attributedString = NSMutableAttributedString(string: string)

attributedString.addAttribute(.font, value: UIFont.systemFont(ofSize: 8), range: NSRange(location: 0, length: 4))
attributedString.addAttribute(.font, value: UIFont.systemFont(ofSize: 16), range: NSRange(location: 5, length: 2))
attributedString.addAttribute(.font, value: UIFont.systemFont(ofSize: 24), range: NSRange(location: 8, length: 1))
attributedString.addAttribute(.font, value: UIFont.systemFont(ofSize: 32), range: NSRange(location: 10, length: 4))
attributedString.addAttribute(.font, value: UIFont.systemFont(ofSize: 40), range: NSRange(location: 15, length: 6))


extension String {
    func withPrefix(_ prefix: String) -> String {
        guard !self.hasPrefix(prefix) else { return self }
        return prefix + self
    }
}


assert("test".withPrefix("te") == "test")
assert("pet".withPrefix("car") == "carpet")


extension String {
    var isNumeric: Bool {
        return Double(self) != nil
    }
}

assert("test".isNumeric == false)
assert("123".isNumeric == true)
assert("456.7".isNumeric == true)


extension String {
    var lines: [Substring] {
        return self.split(separator: "\n")
    }
}

assert("this\nis\na\ntest".lines == ["this", "is", "a", "test"])


// Challenges for projects 22-24

// challenge 1
extension UIView {
    func bounceOut(duration: TimeInterval) {
        UIView.animate(withDuration: duration) { [weak self] in
            self?.transform = CGAffineTransform(scaleX: 0.0001, y: 0.0001)
        }
    }
}

// use "View -> Assistant Editor -> Show Assistant Editor" or "CMD-OPT-<enter>" to display the view in the playground
let view = UIView(frame: CGRect(origin: .zero, size: CGSize(width: 350, height: 350)))
view.backgroundColor = .white

let label = UILabel()
label.font = UIFont.systemFont(ofSize: 38)
label.text = "ANIMATION"
label.translatesAutoresizingMaskIntoConstraints = false
label.textAlignment = .center
view.addSubview(label)

NSLayoutConstraint.activate([
    label.leadingAnchor.constraint(equalTo: view.leadingAnchor), label.trailingAnchor.constraint(equalTo: view.trailingAnchor),
    label.topAnchor.constraint(equalTo: view.topAnchor), label.bottomAnchor.constraint(equalTo: view.bottomAnchor)
])

PlaygroundPage.current.liveView = view
label.bounceOut(duration: 3)


// challenge 2
extension Int {
    func times(handler: () -> Void) {
        guard self > 0 else { return }
        for _ in 1...self {
            handler()
        }
    }
}

5.times { print("Hello!") }

var counter = 0
5.times { counter += 1 }
assert(counter == 5)

let count = -5
count.times { print("No crash") }


// challenge 3
extension Array where Element: Comparable {
    mutating func remove(item: Element) {
        if let index = self.firstIndex(of: item) {
            remove(at: index)
        }
    }
}

// nominal case
var test1 = [1, 2, 3]
test1.remove(item: 3)
assert(test1 == [1, 2])

// unknown element
var test2 = [String]()
test2.remove(item: "unknown")
assert(test2 == [String]())

// multiple times the same element
var test3 = [1, 2, 1]
test3.remove(item: 1)
assert(test3 == [2, 1])

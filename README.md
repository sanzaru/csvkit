# CSVKit

CSVKit is a very simple CSV parsing library for Swift programming.
The parser reads in an String or Data object and parses the CSV fields into an array of strings. Every root element corresponds to one line of the data.

**Features:**

* Parse CSV from String and Data


> **NOTE:** There is no CSV encoding functionality implemented, yet. 


## Installation

### Swift Package Manager

Add the following to your Package.swift file:

```
dependencies: [
    .package(url: "https://github.com/sanzaru/csvkit.git", from: "0.0.1")
]
```


## Example usage

```swift
import Foundation
import CSVKit

struct App {
    static func main() {
        let dummyData = "Foo;Bar;Foo2;Bar2\n\"Line2\";\"Line2-1\";\"Line2-2\";\"Line2-3\""
        dump(CSVParser.shared.parse(from: dummyData))
    }
}

App.main()
```

Output:
```
▿ 2 elements
  ▿ 4 elements
    - "Foo"
    - "Bar"
    - "Foo2"
    - "Bar2"
  ▿ 4 elements
    - "Line2"
    - "Line2-1"
    - "Line2-2"
    - "Line2-3"

```

## License

CSVKit is released under the [Apache License 2.0](LICENSE)

# CSVKit

[![Build Status](https://travis-ci.com/sanzaru/csvkit.svg?branch=main)](https://travis-ci.com/sanzaru/csvkit)

CSVKit is a very simple, fast and lightweight CSV parsing and encoding library for Swift programming.

The parser reads in an String or Data object and parses the CSV fields into an array of strings. Every root element corresponds to one line of the data.

**Features:**

* Parse CSV from String and Data
* Encode string arrays to CSV string data  


## Installation

### Swift Package Manager

Add the following to your Package.swift file:

```
dependencies: [
    .package(url: "https://github.com/sanzaru/csvkit.git", from: "0.0.1")
]
```


## Example usage

### Decoding:

### Default decoding
```swift
import Foundation
import CSVKit

struct App {
    static func main() {
        // Decode with semicolon (default) separator
        let csvData = "Foo;Bar;Foo2;Bar2\n\"Line2\";\"Line2-1\";\"Line2-2\";\"Line2-3\""
        let parsed = CSVParser.shared.parse(from: csvData)
        dump(parsed)
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

#### Custom separator
```swift
import Foundation
import CSVKit

struct App {
    static func main() {
        // Decode with custom separator
        let csvDataComma = "Foo,Bar,Foo2,Bar2\n\"Line2\",\"Line2-1\",\"Line2-2\",\"Line2-3\""
        
        var parser = CSVParser()
        parser.separator = ","
        
        let parsedComma = parser.parse(from: csvDataComma)
        dump(parsedComma)
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

### Encoding:

```swift
import Foundation
import CSVKit

struct App {        
    static func main() {
        do {
            let dummyData = "Foo;Bar;Foo2;Bar2\n\"Line2\";\"Line2-1\";\"Line2-2\";\"Line2-3\""
            
            let csvData: [[String]] = CSVParser.shared.parse(from: dummyData) 
            dump(try CSVEncoder.shared.encode(from: csvData))
        } catch {
            fatalError(error.localizedDescription)
        }
    }
}

App.main()
```

Output:
```
    "Foo;Bar;Foo2;Bar2\nLine2;Line2-1;Line2-2;Line2-3"
```


## Changelog

### Version 0.0.3
    - Added encoding functionality
    - New function parameters and separator handling

### Version 0.0.2
    - Bugfixes
    
### Version 0.0.1
    - First release


## License

CSVKit is released under the [Apache License 2.0](LICENSE)

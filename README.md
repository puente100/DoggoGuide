DoggoGuide is an iOS app built with SwiftUI that allows users to explore different dog breeds. The app uses the Dog API to fetch a list of dog breeds and displays random images for each selected breed.

Features
Fetches a list of dog breeds from the Dog API.
Displays random images of the selected breed.
Uses Combine for real-time data updates.
Modern, minimal UI with SwiftUI.
Requirements
Xcode 12.5 or later.
iOS 14.0 or later.
Swift 5.0 or later.
Installation
1. Clone the repository
bash
Copy code
git clone https://github.com/puente100/doggoguide.git
2. Open the project in Xcode
bash
Copy code
cd doggoguide
open DoggoGuide.xcodeproj
3. Install dependencies
The project uses Alamofire for HTTP requests. If Alamofire isn’t set up:

In Xcode, go to File > Swift Packages > Add Package Dependency.
Enter the URL for Alamofire: https://github.com/Alamofire/Alamofire.
Choose the latest version.
4. Build and run the app
Select a simulator or device in Xcode.
Click the Run button (Cmd + R) to build and run the app.
Combine Usage

DoggoGuide uses Combine to handle data flow and update the UI in real time. Here's a simple example:

Fetching the list of dog breeds:


    func fetchBreeds() -> AnyPublisher<[String], Error> {
    let url = "\(baseURL)/breeds/list/all"
    return Future<[String], Error> { promise in
        AF.request(url).responseDecodable(of: DogBreedsResponse.self) { response in
            switch response.result {
            case .success(let breedsResponse):
                let breeds = breedsResponse.message.keys.map { $0 }
                promise(.success(breeds))
            case .failure(let error):
                promise(.failure(error))
            }
        }
    }
    .receive(on: DispatchQueue.main)
    .eraseToAnyPublisher()
    }

Combine is used to manage asynchronous API requests.
The AnyPublisher ensures the data flows back into the app and updates the UI in real-time.
Reactive UI updates with Combine

```
@Published var breeds: [String] = []
@Published var selectedBreedImage: String?
@Published var errorMessage: String?
```
The @Published properties allow SwiftUI to automatically refresh the UI when the data changes.
Technologies Used
SwiftUI: For building the user interface.
Combine: For handling asynchronous data streams.
Alamofire: For networking.
Dog API: For fetching dog breed data and images.
Contributions
Contributions are welcome! Feel free to open an issue or submit a pull request.

Acknowledgements
Thanks to Dog API for providing the API used in this project.


import SwiftUI

@State public var savedWords: [String] = []

struct ContentView: View {
    @State private var addAccountScene = false
    @State private var viewAccountScene = false
    let skyBlue = Color(red: 0.4627, green: 0.8392, blue: 100.0)
    
    var body: some View {
        // Using ZStack as the root view
        ZStack {
            // Setting the background color for the entire screen
            Color.black.edgesIgnoringSafeArea(.all)
            
            // VStack for our main content
            VStack(spacing: 20) { // A vertical stack view with spacing of 20 between elements.
                if addAccountScene {
                    addAccount(addAccountScene: $addAccountScene)
                } else {
                    Button("Add an Account") {
                        addAccountScene.toggle()
                    }
                    .padding()
                    .border(Color.white, width: 1) // Adds a gray border around the text field.
                    .foregroundColor(.white)
                }
                if viewAccountScene {
                    viewAccount(viewAccountScene: $viewAccountScene)
                }
                else {
                    Button("View your Accounts") {
                        viewAccountScene.toggle()
                    }
                    .padding()
                    .border(Color.white, width: 1) // Adds a gray border around the text field.
                    .foregroundColor(.white)
                }
            }
        }
    }
}

//Page to add an account
struct addAccount: View {
    @Binding var addAccountScene: Bool
    // This state variable holds the value of the word the user is currently typing
    // State makes sure that the string changes everytime something new is typed
    @State private var word: String = ""
    // // The @AppStorage property wrapper is a way to interact with UserDefaults directly from SwiftUI.
    // "savedWord" is a key in UserDefaults where the saved word will be stored or fetched from.
    let skyBlue = Color(red: 0.4627, green: 0.8392, blue: 100.0)
    @State private var amount: Int = 0
    var body: some View {
        VStack() {
            TextField("Enter a word", text: $word)
                .padding() // Adds padding around the text field.
                .border(Color.white, width: 1) // Adds a gray border around the text field.
                .foregroundColor(.white)
                //.background(skyBlue)

            // A button that, when pressed, saves the word from the text field into UserDefaults.
            Button("Save Word") {
                savedWords.append(word) // Current word into saved var
            }
            .padding() // Adds padding around the button.
            .border(Color.white, width: 1) // Adds a gray border around the text field.
            .foregroundColor(.white) // Sets the button's text color to white.

            // Display saved words
            List(savedWords.indices, id: \.self) { index in Text("Saved Word \(index): \(savedWords[index])")
            }
            .padding() // Adds padding around the button.
            //.border(Color.white, width: 1) // Adds a gray border around the text field.
            .foregroundColor(.black) // Sets the button's text color to white.
            .cornerRadius(60)

            Button("Go Back") {
                addAccountScene.toggle()
            }
            .padding()
            .background(Color.red)
            .foregroundColor(.white)
            .cornerRadius(8)
        }
    }
}

struct viewAccount: View {
    @Binding var viewAccountScene: Bool
    
    var body: some View {
        VStack() {
            
        }
    }
}

// This struct is used to preview the ContentView design in Xcode's canvas.
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

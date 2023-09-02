import SwiftUI

struct ContentView: View {
    @State private var addAccountScene = false
    @State private var viewAccountScene = false
    @State private var savedWords: [String] = []
    let skyBlue = Color(red: 0.4627, green: 0.8392, blue: 1.0)
    
    var body: some View {
        ZStack {
            Color.black.edgesIgnoringSafeArea(.all)
            VStack(spacing: 20) {
                if addAccountScene {
                    AddAccount(addAccountScene: $addAccountScene, Account: $Account, Username: $Username, Password: $Password)
                } else if viewAccountScene {
                    ViewAccount(viewAccountScene: $viewAccountScene,savedWords:  $savedWords)
                } else {
                    Button("Add an Account") {
                        addAccountScene.toggle()
                        viewAccountScene = false
                    }
                    .padding()
                    .border(Color.white, width: 1)
                    .foregroundColor(.white)

                    Button("View your Accounts") {
                        viewAccountScene.toggle()
                        addAccountScene = false
                    }
                    .padding()
                    .border(Color.white, width: 1)
                    .foregroundColor(.white)
                }
            }
        }
    }
}

struct AddAccount: View {
    @Binding var addAccountScene: Bool
    @Binding var Account: [String]
    @Binding var Username: [String]
    @Binding var Password: [String]
    @State private var accountWord: String = ""
    @State private var usernameWord: String = ""
    @State private var passwordWord: String = ""
    let skyBlue = Color(red: 0.4627, green: 0.8392, blue: 1.0)
    @State private var amount: Int = 0
    
    var body: some View {
        VStack() {
            TextField("Enter an Account", text: $accountWord)
                .padding()
                .border(Color.white, width: 1)
                .foregroundColor(.white)
            
            TextField("Enter a Username", text: $usernameWord)
                .padding()
                .border(Color.white, width: 1)
                .foregroundColor(.white)
            
            TextField("Enter a Password", text: $passwordWord)
                .padding()
                .border(Color.white, width: 1)
                .foregroundColor(.white)
            
            Button("Save Info") {
                Account.append(accountWord)
                Username.append(usernameWord)
                Password.append(passwordWord)
                addAccountScene.toggle()
            }
            .padding()
            .border(Color.white, width: 1)
            .foregroundColor(.white)
            
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

struct ViewAccount: View {
    @Binding var viewAccountScene: Bool
    @Binding var savedWords: [String]
    
    var body: some View {
        VStack() {
            // Contents for your ViewAccount here
            
            List(savedWords.indices, id: \.self) { index in
                Text("Saved Word \(index): \(savedWords[index])")
            }
            .padding()
            .foregroundColor(.black)
            .cornerRadius(60)
            
            Button("Go Back") {
                viewAccountScene.toggle()
            }
            .padding()
            .background(Color.red)
            .foregroundColor(.white)
            .cornerRadius(8)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

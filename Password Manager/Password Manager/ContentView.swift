import SwiftUI

struct ContentView: View {
    @State private var addAccountScene = false
    @State private var viewAccountScene = false
    @State private var savedWords: [String] = []
    
    @AppStorage("Accounts") var AccountData: Data = Data()
    @AppStorage("Usernames") var UsernameData: Data = Data()
    @AppStorage("Passwords") var PasswordData: Data = Data()
    
    var Account: [String] {
        get {
            (try? JSONDecoder().decode([String].self, from: AccountData)) ?? []
        }
        set {
            AccountData = try! JSONEncoder().encode(newValue)
        }
    }
        
    var Username: [String] {
        get {
            (try? JSONDecoder().decode([String].self, from: UsernameData)) ?? []
        }
        set {
            UsernameData = try! JSONEncoder().encode(newValue)
        }
    }

    var Password: [String] {
        get {
            (try? JSONDecoder().decode([String].self, from: PasswordData)) ?? []
        }
        set {
            PasswordData = try! JSONEncoder().encode(newValue)
        }
    }
    
    let skyBlue = Color(red: 0.4627, green: 0.8392, blue: 1.0)
    
    var body: some View {
        ZStack {
            Color.black.edgesIgnoringSafeArea(.all)
            VStack(spacing: 20) {
                if addAccountScene {
                    AddAccount(addAccountScene: $addAccountScene, accounts: $Account, usernames: $Username, passwords: $Password)

                } else if viewAccountScene {
                    ViewAccount(viewAccountScene: $viewAccountScene, savedWords:  $savedWords)
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
    @Binding var accounts: [String]
    @Binding var usernames: [String]
    @Binding var passwords: [String]

    @State private var accountWord: String = ""
    @State private var usernameWord: String = ""
    @State private var passwordWord: String = ""
    @State private var amount: Int = 0
    @State private var filloutPopup = false
    @State private var accountPopup = false
    
    var body: some View {
        VStack() {
            Text("Enter an Account")
                .padding()
                .foregroundColor(.white)
            TextField("Enter an Account", text: $accountWord)
                .padding()
                .border(Color.white, width: 1)
                .foregroundColor(.white)
            
            Text("Enter a Username")
                .padding()
                .foregroundColor(.white)
            TextField("Enter a Username", text: $usernameWord)
                .padding()
                .border(Color.white, width: 1)
                .foregroundColor(.white)
            
            Text("Enter a Password")
                .padding()
                .foregroundColor(.white)
            TextField("Enter a Password", text: $passwordWord)
                .padding()
                .border(Color.white, width: 1)
                .foregroundColor(.white)
            
            Button("Save Info") {
                if accountWord.isEmpty || usernameWord.isEmpty || passwordWord.isEmpty {
                    filloutPopup = true
                } else if accounts.contains(accountWord) {
                    accountPopup = true
                } else {
                    accounts.append(accountWord)
                    usernames.append(usernameWord)
                    passwords.append(passwordWord)
                    amount+=1
                    addAccountScene.toggle()
                }
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
        if filloutPopup || accountPopup {
            Color.black.opacity(0.4)
                .edgesIgnoringSafeArea(.all)
                .onTapGesture {
                    // Close popup when background is tapped
                    filloutPopup = false
                    accountPopup = false
                }

            VStack(spacing: 20) {
                if accountPopup {
                    Text("You already have this account")
                } else {
                    Text("You did not fill out all of the requirements")
                }
                Button("Close") {
                    filloutPopup = false
                    accountPopup = false
                }
                .padding()
                .background(Color.black)
                .foregroundColor(.white)
                .cornerRadius(10)
            }
            .frame(width: 300, height: 200)
            .background(Color.red)
            .cornerRadius(20)
            .shadow(radius: 20)
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
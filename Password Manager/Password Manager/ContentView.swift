import SwiftUI

struct ContentView: View {
    @State private var addAccountScene = false
    @State private var viewAccountScene = false
    @State private var viewInfoScene: Bool = false
    @State private var savedWords: [String] = []
    
    @AppStorage("Accounts") var AccountData: Data = Data()
    @AppStorage("Usernames") var UsernameData: Data = Data()
    @AppStorage("Passwords") var PasswordData: Data = Data()
    
    @State private var Account: [String] = []
    @State private var Username: [String] = []
    @State private var Password: [String] = []
    
    let skyBlue = Color(red: 0.4627, green: 0.8392, blue: 1.0)
    
    var body: some View {
        ZStack {
            Color.black.edgesIgnoringSafeArea(.all)
            VStack(spacing: 20) {
                if addAccountScene {
                    AddAccount(addAccountScene: $addAccountScene, accounts: $Account, usernames: $Username, passwords: $Password)
                } else if viewAccountScene {
                    ViewAccount(viewAccountScene: $viewAccountScene, viewInfoScene: $viewInfoScene, accounts: $Account)
                } else if viewInfoScene {
                    
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
        .onChange(of: AccountData) { newValue in
                    Account = (try? JSONDecoder().decode([String].self, from: newValue)) ?? []
                }
                .onChange(of: UsernameData) { newValue in
                    Username = (try? JSONDecoder().decode([String].self, from: newValue)) ?? []
                }
                .onChange(of: PasswordData) { newValue in
                    Password = (try? JSONDecoder().decode([String].self, from: newValue)) ?? []
                }
                .onChange(of: Account) { newValue in
                    AccountData = try! JSONEncoder().encode(newValue)
                }
                .onChange(of: Username) { newValue in
                    UsernameData = try! JSONEncoder().encode(newValue)
                }
                .onChange(of: Password) { newValue in
                    PasswordData = try! JSONEncoder().encode(newValue)
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
    @Binding var viewInfoScene: Bool
    @Binding var accounts: [String]
    
    var body: some View {
        VStack() {
            // Contents for your ViewAccount here
            
            List(accounts.indices, id: \.self) { index in
                Button(action: {
                    viewInfoScene = true  // Toggle to show the ViewInfo scene
                    viewAccountScene = false  // Close the ViewAccount scene
                }) {
                    Text(accounts[index])
                        .foregroundColor(.white)  // set the text color to white
                        .frame(maxWidth: .infinity, minHeight: 44)  // taking the full width and a minimum height
                        .border(Color.black)
                        .background(Color.black)  // set the row background to black
                }
            }
            .listStyle(PlainListStyle())  // Removes default list styling
            .background(Color.black)  // set the list background to black
            
            Button("Go Back") {
                viewAccountScene.toggle()
            }
            .padding()
            .background(Color.red)
            .foregroundColor(.white)
            .cornerRadius(8)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)  // Make the VStack occupy the entire space
        .background(Color.black)
    }
}

struct ViewInfo: View {
    @Binding var viewInfoScene: Bool
    
    var body: some View {
        VStack() {
            Text("Username")
            
            Button("Go Back") {
                viewInfoScene.toggle()
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

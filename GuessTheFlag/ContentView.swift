import SwiftUI

struct ContentView: View {
    @State private var countryNameIndex = Int.random(in: 0...2)
    @State private var shouldShowAlert = false
    @State private var isAnswerCorrect = true
    
    @State var countries = ["Estonia", "France", "Germany", "Ireland", "Italy", "Nigeria", "Poland", "Russia", "Spain", "UK", "US"].shuffled()
    
    var body: some View {
        ZStack {
            LinearGradient(gradient: Gradient(
                            colors: [Color.white, Color.black]),
                           startPoint: .top,
                           endPoint: .bottom)
                .edgesIgnoringSafeArea(.all)
            
            VStack(alignment: .center, spacing: 80) {
                VStack(alignment: .center, spacing: 10) {
                    Text("Select the flag of name...")
                    Text(countries[countryNameIndex])
                        .font(.largeTitle)
                        .bold()
                }
                
                VStack (alignment: .center, spacing: 30) {
                    ForEach(0..<3) { index in
                        Button(action: {
                            onFlagClick(imageName: countries[index])
                        }, label: {
                            Image(countries[index])
                                .renderingMode(.original)
                                .clipShape(Capsule())
                                .overlay(Capsule().stroke(Color.black, lineWidth: 2))
                                .shadow(radius: 20)
                        })
                        .alert(isPresented: $shouldShowAlert, content: {
                            Alert(
                                title: Text("Result"),
                                message: Text("The answer is \(isAnswerCorrect.description)"),
                                primaryButton: Alert.Button.cancel(),
                                secondaryButton: Alert.Button.default(
                                    Text(isAnswerCorrect ? "Continue" : "Retry")
                                )
                                {
                                    self.countries.shuffle()
                                    self.countryNameIndex = Int.random(in: 0...2)
                                })
                        })
                    }
                }
                
                Spacer()
            }
            
        }
    }
    
    private func onFlagClick(imageName: String) {
        shouldShowAlert = true
        isAnswerCorrect = imageName == countries[countryNameIndex]
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

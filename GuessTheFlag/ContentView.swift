import SwiftUI


// Usage of custom View for image for a cleaner approach
struct FlagImage: View {
    var imageName: String
    var body: some View {
        Image(imageName)
            .renderingMode(.original)
            .clipShape(Capsule())
            .overlay(Capsule().stroke(Color.black, lineWidth: 2))
            .shadow(radius: 20)
    }
}

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
                    Text("select_flag".customLocalization)
                    Text(countries[countryNameIndex].customLocalization)
                        .font(.largeTitle)
                        .bold()
                }
                
                VStack (alignment: .center, spacing: 30) {
                    ForEach(0..<3) { index in
                        Button(action: {
                            onFlagClick(imageName: countries[index])
                        }, label: {
                            FlagImage(imageName: countries[index])
                        })
                        .alert(isPresented: $shouldShowAlert, content: {
                            Alert(
                                title: Text("result".customLocalization),
                                message: Text("the_answer".customLocalization + "\(isAnswerCorrect.description)"),
                                primaryButton: Alert.Button.cancel(),
                                secondaryButton: Alert.Button.default(
                                    Text(isAnswerCorrect ? "continue".customLocalization : "retry".customLocalization)
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

extension String {
    var customLocalization: String {
        return NSLocalizedString(self, comment: "").isEmpty ? self : NSLocalizedString(self, comment: "")
    }
}

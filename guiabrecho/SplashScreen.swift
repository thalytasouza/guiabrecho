import SwiftUI

struct SplashScreen: View {
    let minhaCorAmarela = Color(red: 0.90, green: 0.66, blue: 0.00)
    
    var body: some View {
        ZStack {
            minhaCorAmarela
            
            Image("logo sem fundo")
                .resizable()
                .scaledToFit()
                .frame(width: 400, height: 400)
            
            Text("")
                .font(.largeTitle.bold())
                .foregroundColor(minhaCor)
                .padding(.bottom, 8)

        }
        .edgesIgnoringSafeArea(.all)
    }
}

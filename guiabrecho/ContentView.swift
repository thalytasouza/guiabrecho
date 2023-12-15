import SwiftUI
import MapKit

struct guiabrecho: Identifiable {
    var id = UUID()
    var title: String
    var subtitle: String
    var coordinate: CLLocationCoordinate2D
    var description: String?
    var phoneNumber: String?
}

struct ContentView: View {
    let brechos: [guiabrecho] = [
        guiabrecho(title: "Brechó do Casarão", subtitle: "R. Haddock Lobo, 239", coordinate: CLLocationCoordinate2D(latitude: -22.91935124265578, longitude: -43.21418054556612), description: "Instagram: @brechodocasaraorj", phoneNumber: "21 3197-6864"),
        
        guiabrecho(title: "Brechó Farrah", subtitle: "EST. JACAREPAGUÁ N° 7655 - SALA 711", coordinate: CLLocationCoordinate2D(latitude: -22.942252035605136, longitude: -43.341557960907544), description: "Instagram: @brechofarrah_", phoneNumber: "21 98435-6130"),
        
        guiabrecho(title: "Refúgio hippie", subtitle: "Avenida das Americas, 11889, Sala 219", coordinate: CLLocationCoordinate2D(latitude: -23.005693308574855, longitude: -43.43069083301632), description: "Instagram: @refugiohippierj   🌸Encontre seu estilo, qualquer estilo aqui! Vista e use VOCÊ.   Não trocamos peças do brechó  ✨ Seg á sex das 10h às 18h", phoneNumber: ""),
       
        guiabrecho(title: "A.Z Sustentabilidade", subtitle: "Av. N. Sra. de Copacabana, 828/sobreloja", coordinate: CLLocationCoordinate2D(latitude:  -22.973168676983626, longitude: -43.18884414556493), description: "Instagram: @azsustentabilidade", phoneNumber: "21 98081-6089"),
        
        guiabrecho(title: "Santa Tênis", subtitle: "Rua Felicio dos Santos 9", coordinate: CLLocationCoordinate2D(latitude:  -22.921097390288725, longitude: -43.18756826090815), description: "Instagram: @santatenisoficial", phoneNumber: ""),
        
        guiabrecho(title: "Atelier Mon et Ton", subtitle: "Rua do Senado, 47 - Centro do Rio", coordinate: CLLocationCoordinate2D(latitude:  -22.921097390288725, longitude: -43.18756826090815), description: "Instagram: @ateliermoneton", phoneNumber: ""),
        
        guiabrecho(title: "123 Outra Vez", subtitle: "Shopping Downtown - bloco 16, loja: 101", coordinate: CLLocationCoordinate2D(latitude:  -23.003261648516464, longitude: -43.31641332971912), description: "Instagram: @123outravezbrecho", phoneNumber: "21 96494-1829"),
        
        guiabrecho(title: "Peça Rara Brechó", subtitle: "Downtown - Bloco 11 - Loja 107", coordinate: CLLocationCoordinate2D(latitude:  -22.915393137421106, longitude: -43.302047399144904), description: "Instagram: @pecarara.barradatijuca", phoneNumber: "21 96728-1818"),
        
        guiabrecho(title: "Veio da Mala Brechó", subtitle: "Rua Dias da Cruz, 638. Box 02", coordinate: CLLocationCoordinate2D(latitude:  -22.904837692740028, longitude: -43.29275499528818), description: "Instagram: @veiodamala", phoneNumber: "21 99241-4895"),

        guiabrecho(title: "O Cacareco", subtitle: "Rua São Clemente 245", coordinate: CLLocationCoordinate2D(latitude:  -22.94975168899068, longitude: -43.19030034741363), description: "Instagram: @pecarara.barradatijuca", phoneNumber: "21 96728-1818"),
        
        guiabrecho(title: "Três Graças Brechó", subtitle: "Vendas através do instagram", coordinate: CLLocationCoordinate2D(latitude: 0, longitude: 0), description: "Instagram: @tresgracasbrecho 🌀🍃 Circulando roupas e semeando ideias. https://www.tresgracas.eco.br/", phoneNumber: "21 99553-2220"),

        guiabrecho(title: "21 Brechó Arte", subtitle: "R. Gen. Roca, 514 ", coordinate: CLLocationCoordinate2D(latitude: -22.925783914741512, longitude: -43.23153170323724), description: "Instagram: @21_brechoarte", phoneNumber: "21 997065-6974"),

        guiabrecho(title: "Nilda's Brecho", subtitle: "Rua Carvalho Alvim, 333 - loja D", coordinate: CLLocationCoordinate2D(latitude: -22.927271566750463, longitude: -43.24455491857882), description: "Instagram: @nilda_nildasbrecho", phoneNumber: "21 2268-9448")
    ]
    
    var body: some View {
        NavigationView {
            VStack {
                Text("GUIA BRECHÓ")
                    .font(.largeTitle)
                    .foregroundColor(minhaCor)
                    .frame(maxWidth: .infinity, alignment: .center)
                BrechoListView(brechos: brechos)
            }
            .navigationBarTitle("")
            .navigationBarHidden(true)
        }
    }
    
    struct BrechoListView: View {
        var brechos: [guiabrecho]
        
        var body: some View {
            List(brechos) { guiabrecho in
                NavigationLink(destination: BrechoDetailView(guiabrecho: guiabrecho)) {
                    BrechoRow(guiabrecho: guiabrecho)
                }
            }
        }
    }
    
    struct BrechoRow: View {
        var guiabrecho: guiabrecho
        
        var body: some View {
            HStack {
                VStack(alignment: .leading) {
                    Text(guiabrecho.title)
                        .font(.headline)
                    Text(guiabrecho.subtitle)
                        .foregroundColor(.gray)
                }
                Spacer()
                Image(systemName: "chevron.right")
                    .foregroundColor(.blue)
            }
            .padding(10)
        }
    }
    
    struct BrechoDetailView: View {
        var guiabrecho: guiabrecho
        
        var body: some View {
            VStack {
                MapView(coordinate: guiabrecho.coordinate, title: guiabrecho.title, subtitle: guiabrecho.subtitle)
                    .frame(height: 300)
                
                VStack(alignment: .leading, spacing: 16) {
                    Text(guiabrecho.title)
                        .font(.title)
                        .foregroundColor(minhaCor)
                    Text(guiabrecho.subtitle)
                        .font(.subheadline)
                    Text(guiabrecho.description ?? "")
                        .foregroundColor(.gray)
                        .multilineTextAlignment(.leading)
                    Text(guiabrecho.phoneNumber ?? "")
                        .foregroundColor(minhaCor)
                }
                .padding()
                .frame(maxWidth: .infinity, alignment: .leading)
                
                Spacer()
            }
            .navigationBarTitle(Text(guiabrecho.title), displayMode: .inline)
        }
    }
    
    struct MapView: UIViewRepresentable {
        var coordinate: CLLocationCoordinate2D
        var title: String
        var subtitle: String
        
        func makeUIView(context: Context) -> MKMapView {
            MKMapView(frame: .zero)
        }
        
        func updateUIView(_ uiView: MKMapView, context: Context) {
            let annotation = MKPointAnnotation()
            annotation.title = title
            annotation.subtitle = subtitle
            annotation.coordinate = coordinate
            
            uiView.addAnnotation(annotation)
            uiView.setRegion(MKCoordinateRegion(center: coordinate, span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)), animated: true)
        }
    }
    
    @main
    struct BrechoApp: App {
        let minhaCor = Color(red: 0.7098, green: 0.3647, blue: 0.0196)
        let minhaCorAmarela = Color(red: 0.90, green: 0.66, blue: 0.00)
        
        var body: some Scene {
            WindowGroup {
                NavigationView {
                    ZStack {
                        if showSplash {
                            SplashScreen()
                                .onAppear {
                                    DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                                        withAnimation {
                                            self.showSplash = false
                                        }
                                    }
                                }
                        } else {
                            ContentView()
                        }
                    }
                    .background(minhaCorAmarela)
                    .navigationBarHidden(true)
                }
            }
        }
        
        @State private var showSplash = true
    }
    
    struct SplashScreen: View {
        var body: some View {
            ZStack {
                minhaCorAmarela
                
                Image("logo sem fundo")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 400, height: 400)
                
                Text("")
                    .font(.largeTitle)
                    .foregroundColor(minhaCor)
            }
            .edgesIgnoringSafeArea(.all)
        }
    }
}

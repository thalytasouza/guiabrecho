import SwiftUI
import MapKit

struct ContentView: View {
    @EnvironmentObject var contentViewModel: ContentViewModel
    
    var body: some View {
        NavigationView {
            VStack(spacing: 8) {
                if !contentViewModel.showSplash {
                    Text("GUIA BRECHÓ")
                        .font(.title)
                        .frame(maxWidth: .infinity, alignment: .center)
                }
                
                ZStack {
                    if contentViewModel.showSplash {
                        SplashScreen()
                            .onAppear {
                                DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                                    withAnimation {
                                        contentViewModel.showSplash = false
                                    }
                                }
                            }
                    } else if contentViewModel.showFavorites {
                        BrechoListView(brechos: BrechoData.all)
                            .environmentObject(contentViewModel)
                            .navigationBarItems(trailing:
                                NavigationLink(destination: FavoritesView()) {
                                    Image(systemName: "heart.fill")
                                        .foregroundColor(minhaCor)
                                }
                            )

                    } else {
                        BrechoListView(brechos: BrechoData.all)
                            .environmentObject(contentViewModel)
                            .navigationBarItems(trailing:
                                Button(action: {
                                    print("Botão de favoritos clicado")
                                    contentViewModel.showFavorites.toggle()
                                }) {
                                    Image(systemName: "heart.fill")
                                        .foregroundColor(minhaCor)
                                }
                            )
                    }
                }
                .background(Color.white)
                .navigationBarHidden(false)
                .navigationBarTitle("")
            }
            .navigationBarTitle("", displayMode: .inline)
        }
    }
    
    struct BrechoListView: View {
        @EnvironmentObject var contentViewModel: ContentViewModel
        var brechos: [guiabrecho]

        var body: some View {
            List {
                ForEach(brechos) { guiabrecho in
                    NavigationLink(destination: BrechoDetailView(guiabrecho: guiabrecho)) {
                        BrechoRow(guiabrecho: guiabrecho)
                            .environmentObject(contentViewModel)
                    }
                }
            }
        }
    }
    
    struct BrechoRow: View {
        @EnvironmentObject var contentViewModel: ContentViewModel
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
                Image(systemName: contentViewModel.isFavorite(id: guiabrecho.id) ? "heart.fill" : "heart")
                    .foregroundColor(minhaCor)
                    .onTapGesture {
                        contentViewModel.toggleFavorite(for: guiabrecho.id)
                    }
                    .padding(10)
            }
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
    
    struct FavoritesView: View {
        @EnvironmentObject var contentViewModel: ContentViewModel

        var body: some View {
            List(contentViewModel.favoriteItems) { item in
                NavigationLink(destination: BrechoDetailView(guiabrecho: item)) {
                    BrechoRow(guiabrecho: item)
                        .environmentObject(contentViewModel)
                }
            }
            .navigationTitle("Meus Favoritos")
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
}

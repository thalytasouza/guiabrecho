import SwiftUI
import MapKit

struct ContentView: View {
    @EnvironmentObject var contentViewModel: ContentViewModel

    var body: some View {
        NavigationView {
            VStack(spacing: 8) {
                if !contentViewModel.showSplash {
                    Text("GUIA BRECHÓ")
                        .font(.largeTitle.bold())
                        .foregroundColor(minhaCor)
                        .padding(.bottom, 8)
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
                    } else {
                        VStack {
                            BrechoListView(brechos: contentViewModel.brechos)
                                .environmentObject(contentViewModel)

                            NavigationLink(destination: FavoritesView()) {
                                HStack {
                                    Image(systemName: "heart.fill")
                                    Text("Ver favoritos")
                                }
                                .padding()
                                .foregroundColor(.white)
                                .background(minhaCor)
                                .cornerRadius(12)
                                .padding(.top, 16)
                            }
                        }
                    }
                }
                .background(Color.white)
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
            HStack(spacing: 12) {
                VStack(alignment: .leading, spacing: 4) {
                    Text(guiabrecho.title)
                        .font(.headline)
                        .foregroundColor(minhaCor)
                    Text(guiabrecho.subtitle)
                        .font(.subheadline)
                        .foregroundColor(lightGray)
                }

                Spacer()

                Image(systemName: contentViewModel.isFavorite(id: guiabrecho.id) ? "heart.fill" : "heart")
                    .foregroundColor(pink)
                    .padding(8)
                    .background(Color.white)
                    .clipShape(Circle())
                    .shadow(color: Color.black.opacity(0.15), radius: 2, x: 0, y: 1)
                    .onTapGesture {
                        withAnimation(.easeInOut(duration: 0.2)) {
                            contentViewModel.toggleFavorite(for: guiabrecho.id)
                        }
                    }
            }
            .padding()
            .background(
                RoundedRectangle(cornerRadius: 14)
                    .fill(Color.white)
                    .shadow(color: Color.black.opacity(0.05), radius: 4, x: 0, y: 2)
            )
            .padding(.horizontal)
        }
    }

    struct BrechoDetailView: View {
        var guiabrecho: guiabrecho
        @Environment(\.presentationMode) var presentationMode

        var body: some View {
            ScrollView {
                VStack(spacing: 0) {
                    MapView(coordinate: guiabrecho.coordinate, title: guiabrecho.title, subtitle: guiabrecho.subtitle)
                        .frame(height: 250)
                        .clipShape(RoundedRectangle(cornerRadius: 16))
                        .padding([.top, .horizontal])

                    VStack(alignment: .leading, spacing: 16) {
                        Text(guiabrecho.title)
                            .font(.title)
                            .foregroundColor(minhaCor)

                        Text(guiabrecho.subtitle)
                            .font(.subheadline)
                            .foregroundColor(lightGray)

                        if let description = guiabrecho.description, !description.isEmpty {
                            Text(description)
                                .font(.body)
                                .foregroundColor(darkGray)
                        }

                        if let phone = guiabrecho.phoneNumber, !phone.isEmpty {
                            HStack(spacing: 8) {
                                Image(systemName: "phone.fill")
                                    .foregroundColor(minhaCor)
                                Text(phone)
                                    .foregroundColor(minhaCor)
                            }
                            .padding(10)
                            .background(minhaCor.opacity(0.1))
                            .clipShape(RoundedRectangle(cornerRadius: 10))
                        }
                    }
                    .padding()
                    .background(
                        RoundedRectangle(cornerRadius: 24)
                            .fill(Color.white)
                            .shadow(color: Color.black.opacity(0.05), radius: 6, x: 0, y: -2)
                    )
                    .padding(.horizontal)
                    .offset(y: -16)
                }
            }
            .transition(.opacity.combined(with: .move(edge: .trailing)))
            .animation(.easeInOut(duration: 0.3), value: guiabrecho.id)
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        presentationMode.wrappedValue.dismiss()
                    }) {
                        Image(systemName: "xmark")
                            .foregroundColor(darkGray)
                    }
                }
            }
            .background(Color(.systemGroupedBackground))
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

            uiView.removeAnnotations(uiView.annotations)
            uiView.addAnnotation(annotation)
            uiView.setRegion(MKCoordinateRegion(center: coordinate, span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)), animated: true)
        }
    }
}

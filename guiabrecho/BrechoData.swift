import SwiftUI
import Foundation
import CoreLocation

struct BrechoData {
    static let all: [guiabrecho] = [
        guiabrecho(id: 1, title: "Brechó do Casarão", subtitle: "R. Haddock Lobo, 239", coordinate: CLLocationCoordinate2D(latitude: -22.91935124265578, longitude: -43.21418054556612), description: "Instagram: @brechodocasaraorj", phoneNumber: "21 3197-6864"),
        
        guiabrecho(id: 2, title: "Brechó Farrah", subtitle: "EST. JACAREPAGUÁ N° 7655 - SALA 711", coordinate: CLLocationCoordinate2D(latitude: -22.942252035605136, longitude: -43.341557960907544), description: "Instagram: @brechofarrah_", phoneNumber: "21 98435-6130"),
        
        guiabrecho(id: 3, title: "Refúgio hippie", subtitle: "Avenida das Americas, 11889, Sala 219", coordinate: CLLocationCoordinate2D(latitude: -23.005693308574855, longitude: -43.43069083301632), description: "Instagram: @refugiohippierj   🌸Encontre seu estilo, qualquer estilo aqui! Vista e use VOCÊ.   Não trocamos peças do brechó  ✨ Seg á sex das 10h às 18h", phoneNumber: ""),
        
        guiabrecho(id: 4, title: "A.Z Sustentabilidade", subtitle: "Av. N. Sra. de Copacabana, 828/sobreloja", coordinate: CLLocationCoordinate2D(latitude:  -22.973168676983626, longitude: -43.18884414556493), description: "Instagram: @azsustentabilidade", phoneNumber: "21 98081-6089"),
        
        guiabrecho(id: 5, title: "Santa Tênis", subtitle: "Rua Felicio dos Santos 9", coordinate: CLLocationCoordinate2D(latitude:  -22.921097390288725, longitude: -43.18756826090815), description: "Instagram: @santatenisoficial", phoneNumber: ""),
        
        guiabrecho(id: 6, title: "Atelier Mon et Ton", subtitle: "Rua do Senado, 47 - Centro do Rio", coordinate: CLLocationCoordinate2D(latitude:  -22.921097390288725, longitude: -43.18756826090815), description: "Instagram: @ateliermoneton", phoneNumber: ""),
        
        guiabrecho(id: 7, title: "123 Outra Vez", subtitle: "Shopping Downtown - bloco 16, loja: 101", coordinate: CLLocationCoordinate2D(latitude:  -23.003261648516464, longitude: -43.31641332971912), description: "Instagram: @123outravezbrecho", phoneNumber: "21 96494-1829"),
        
        guiabrecho(id: 8, title: "Peça Rara Brechó", subtitle: "Downtown - Bloco 11 - Loja 107", coordinate: CLLocationCoordinate2D(latitude:  -22.915393137421106, longitude: -43.302047399144904), description: "Instagram: @pecarara.barradatijuca", phoneNumber: "21 96728-1818"),
        
        guiabrecho(id: 9, title: "Veio da Mala Brechó", subtitle: "Rua Dias da Cruz, 638. Box 02", coordinate: CLLocationCoordinate2D(latitude:  -22.904837692740028, longitude: -43.29275499528818), description: "Instagram: @veiodamala", phoneNumber: "21 99241-4895"),
        
        guiabrecho(id: 10, title: "O Cacareco", subtitle: "Rua São Clemente 245", coordinate: CLLocationCoordinate2D(latitude:  -22.94975168899068, longitude: -43.19030034741363), description: "Instagram: @pecarara.barradatijuca", phoneNumber: "21 96728-1818"),
        
        guiabrecho(id: 11, title: "Três Graças Brechó", subtitle: "Vendas através do instagram", coordinate: CLLocationCoordinate2D(latitude: 0, longitude: 0), description: "Instagram: @tresgracasbrecho 🌀🍃 Circulando roupas e semeando ideias. https://www.tresgracas.eco.br/", phoneNumber: "21 99553-2220"),
        
        guiabrecho(id: 12, title: "21 Brechó Arte", subtitle: "R. Gen. Roca, 514 ", coordinate: CLLocationCoordinate2D(latitude: -22.925783914741512, longitude: -43.23153170323724), description: "Instagram: @21_brechoarte", phoneNumber: "21 997065-6974"),
        
        guiabrecho(id: 13, title: "Nilda's Brecho", subtitle: "Rua Carvalho Alvim, 333 - loja D", coordinate: CLLocationCoordinate2D(latitude: -22.927271566750463, longitude: -43.24455491857882), description: "Instagram: @nilda_nildasbrecho", phoneNumber: "21 2268-9448")
    ]
}

struct guiabrecho: Identifiable {
    let id: Int
    let title: String
    let subtitle: String
    let coordinate: CLLocationCoordinate2D
    let description: String?
    let phoneNumber: String?
}

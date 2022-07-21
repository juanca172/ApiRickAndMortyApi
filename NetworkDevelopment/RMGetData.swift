//
//  RMGetData.swift
//  ApiRickAndMortyNetworking
//
//  Created by Juan Camilo Fonseca Gomez on 28/06/22.
//

import Foundation

struct DatosAppi: Decodable{
    var characters: String
    var locations: String
    var episodes: String
}

struct ApiResponseCharacter: Decodable {
    var info: DatosInfo
    var results: [DatosCharacter]
}
struct ApiResponseLocation: Decodable {
    var info: DatosInfo
    var results: [DatosLocation]
}
struct ApiResponseEpisode: Decodable {
    var info: DatosInfo
    var results: [DatosEpisodios]
}
struct DatosInfo: Codable {
    var count: Int
    var pages: Int
    var next: String?
    var prev: String?
}
struct DatosCharacter: Decodable {
    var id : Int
    var name: String
    var status: String
    var species: String
    var type: String
    var gender : String
    var image: String
}
struct DatosLocation : Decodable {
    var id: Int
    var name: String
    var type: String
    var dimension: String
    var residents: [String]
    var url: String
    var created: String
}
struct DatosEpisodios: Decodable {
    var id: Int
    var name: String
    var air_date: String
    var episode: String
    var characters: [String]
    var url: String
    var created: String
}


enum RMError: Error,Equatable  {
    static func == (lhs: RMError, rhs: RMError) -> Bool {
        switch (lhs, rhs) {
        case (datosNotFound,datosNotFound):
            return true
        case(imposibleDecodiar, imposibleDecodiar):
            return true
        case (networkError(let error1), networkError(let error2)):
            return "\(error1)" == "\(error2)"
        default:
            return false
        }
    }
    case datosNotFound
    case networkError(Error)
    case imposibleDecodiar
}
protocol RMGetDataProtocol {
    func getData<T: Decodable>(urlRequest: URLRequest,_ datos: @escaping (Result<T, RMError>) -> Void)
}
struct ApiRickAndMortyGeneric: RMGetDataProtocol {
    var urlSession: URLSession
    var jsonDecoder: JSONDecoder
    init (urlSession: URLSession = .shared, jsonDecoder: JSONDecoder = JSONDecoder()) {
        self.urlSession = urlSession
        self.jsonDecoder = jsonDecoder
    }
    func getData<T: Decodable>(urlRequest: URLRequest,_ completion: @escaping (Result<T, RMError>) -> Void) {
        urlSession.dataTask(with: urlRequest) { data, response, error in
            guard let data = data else {
                completion(.failure(RMError.datosNotFound))
                return
            }
            if let error = error {
                let resultError = RMError.networkError(error)
                completion(.failure(resultError))
                return
            }
            do {
                let valor = try jsonDecoder.decode(T.self, from: data)
                completion(.success(valor))
            } catch {
                completion(.failure(.imposibleDecodiar))
            }
        
        }.resume()
    }
}

//URLComponents
func tryEvents() {
    let statusRM = RMStatusCharacter(status: TypesOfStatus.alive.rawValue)
    let name = RMNameCharacter(name: "Rick Sanchez")
    let genreRM = RMGeneroCharacter(genre: TypesOfGenres.male.rawValue)
    let RMCharacterRequest = RMCharacterRoute.filterCharacter(filterProtocol: [name, statusRM, genreRM]).URLRequestComplete
    let linkEpisodes = ApiRickAndMortyGeneric()
    linkEpisodes.getData(urlRequest: RMCharacterRequest) { (result: Result<ApiResponseCharacter, RMError> )in
        switch result {
            case .success(let valor):
                print(valor)
            case .failure(let error):
                print(error)
        }
    }
}



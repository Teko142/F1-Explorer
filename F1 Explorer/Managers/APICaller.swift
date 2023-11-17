//
//  APICaller.swift
//  F1 Explorer
//
//  Created by Артур Олехно on 26/10/2023.
//

import Foundation

struct Constants {
    static let API_KEY = "371648ddf66da22b1395ba5151d75cff"
    static let baseURL = "https://v1.formula-1.api-sports.io"
    static let YouTubeAPI_KEY = "AIzaSyB6yW_gpKPrQQDhO5GLTdSxBWTgwop4TIo"
    static let YouTubeBaseURL = "https://youtube.googleapis.com/youtube/v3/search?"
}

enum APIError: Error {
    case failedToGetData
}

class APICaller {
    
    static let shared = APICaller()
    
    func getStatus(completion: @escaping (Result<Status, Error>) -> Void) {
        guard let url = URL(string: "\(Constants.baseURL)/status") else { return }
        var request = URLRequest(url: url, cachePolicy: .reloadIgnoringLocalAndRemoteCacheData, timeoutInterval: 10.0)
        request.httpMethod = "GET"
        request.addValue(Constants.API_KEY, forHTTPHeaderField: "x-rapidapi-key")
        request.addValue("v1.formula-1.api-sports.io", forHTTPHeaderField: "x-rapidapi-host")
        let task = URLSession.shared.dataTask(with: request) { data, _, error in
            guard let data = data, error == nil else { return }
            do {
                let result = try JSONDecoder().decode(Status.self, from: data)
                completion(.success(result))
            } catch {
                completion(.failure(APIError.failedToGetData))
            }
        }
        task.resume()
    }
    
    func getCircuits(completion: @escaping (Result<[Circuits], Error>) -> Void) {
        guard let url = URL(string: "\(Constants.baseURL)/circuits") else { return }
        var request = URLRequest(url: url, cachePolicy: .reloadIgnoringLocalAndRemoteCacheData, timeoutInterval: 10.0)
        request.httpMethod = "GET"
        request.addValue(Constants.API_KEY, forHTTPHeaderField: "x-rapidapi-key")
        request.addValue("v1.formula-1.api-sports.io", forHTTPHeaderField: "x-rapidapi-host")
        let task = URLSession.shared.dataTask(with: request) { data, _, error in
            guard let data = data, error == nil else { return }
            do {
                let results = try JSONDecoder().decode(CircuitsResponse.self, from: data)
                completion(.success(results.response))
            } catch {
                completion(.failure(APIError.failedToGetData))
            }
        }
        task.resume()
    }
    
    func getTeams(completion: @escaping (Result<[Team], Error>) -> Void) {
        guard let url = URL(string: "\(Constants.baseURL)/teams") else { return }
        var request = URLRequest(url: url, cachePolicy: .reloadIgnoringLocalAndRemoteCacheData, timeoutInterval: 10.0)
        request.httpMethod = "GET"
        request.addValue(Constants.API_KEY, forHTTPHeaderField: "x-rapidapi-key")
        request.addValue("v1.formula-1.api-sports.io", forHTTPHeaderField: "x-rapidapi-host")
        let task = URLSession.shared.dataTask(with: request) { data, _, error in
            guard let data = data, error == nil else { return }
            do {
                let results = try JSONDecoder().decode(TeamsResponse.self, from: data)
                completion(.success(results.response))
            } catch {
                completion(.failure(APIError.failedToGetData))
            }
        }
        task.resume()
    }
    
    func searchDrivers(with query: String, completion: @escaping (Result<[Driver], Error>) -> Void) {
        guard let query = query.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) else {return}
        guard let url = URL(string: "\(Constants.baseURL)/drivers?search=\(query)") else { return }
        var request = URLRequest(url: url, cachePolicy: .reloadIgnoringLocalAndRemoteCacheData, timeoutInterval: 10.0)
        request.httpMethod = "GET"
        request.addValue(Constants.API_KEY, forHTTPHeaderField: "x-rapidapi-key")
        request.addValue("v1.formula-1.api-sports.io", forHTTPHeaderField: "x-rapidapi-host")
        let task = URLSession.shared.dataTask(with: request) { data, _, error in
            guard let data = data, error == nil else { return }
            do {
                let results = try JSONDecoder().decode(DriversResponse.self, from: data)
                completion(.success(results.response))
            } catch {
                completion(.failure(APIError.failedToGetData))
            }
        }
        task.resume()
    }
    
    func getVideo(with query: String, completion: @escaping (Result<VideoElement, Error>) -> Void) {
        guard let query = query.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) else {return}
        guard let url = URL(string: "\(Constants.YouTubeBaseURL)q=\(query)&key=\(Constants.YouTubeAPI_KEY)") else { return }
        let request = URLRequest(url: url, cachePolicy: .reloadIgnoringLocalAndRemoteCacheData, timeoutInterval: 10.0)
        let task = URLSession.shared.dataTask(with: request) { data, _, error in
            guard let data = data, error == nil else { return }
            do {
                let results = try JSONDecoder().decode(YouTubeSearchResponse.self, from: data)
                completion(.success(results.items[0]))
            } catch {
                completion(.failure(error))
                print(error.localizedDescription)
            }
        }
        task.resume()
    }
}

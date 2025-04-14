//
//  APIClient.swift
//  sofascoreAcademy
//
//  Created by Tina Jureško on 04.04.2025..
//

import Foundation
import Network

enum APIError: Error {
    case invalidURL
    case requestFailed
    case decodingFailed
    case invalidResponse
}

enum APIClient {
    private static let baseURL = "https://sofa-ios-academy-43194eec0621.herokuapp.com"

    static func fetch<T: Decodable>(
        path: String,
        queryItems: [URLQueryItem] = [],
        method: String = "GET"
    ) async throws -> T {
        let url = try buildURL(path: path, queryItems: queryItems)
        let request = buildRequest(url: url, method: method)
        let data = try await sendRequest(request)
        return try decode(data: data)
    }
    
    private static func buildURL(path: String, queryItems: [URLQueryItem]) throws -> URL {
        var components = URLComponents(string: baseURL + path)
        components?.queryItems = queryItems
        guard let url = components?.url else {
            throw APIError.invalidURL
        }
        return url
    }
    
    private static func buildRequest(url: URL, method: String) -> URLRequest {
        var request = URLRequest(url: url)
        request.httpMethod = method
        return request
    }
    
    private static func sendRequest(_ request: URLRequest) async throws -> Data {
        let (data, response) = try await URLSession.shared.data(for: request)
        guard let httpResponse = response as? HTTPURLResponse, (200..<300).contains(httpResponse.statusCode) else {
            throw APIError.invalidResponse
        }
        return data
    }
    
    private static func decode<T: Decodable>(data: Data) throws -> T {
        do {
            return try JSONDecoder().decode(T.self, from: data)
        } catch {
            throw APIError.decodingFailed
        }
    }
}


//
//  ContentView.swift
//  Fortnite API
//
//  Created by Alex Anderson on 3/6/23.
//

import SwiftUI
import Foundation

struct ContentView: View {
    @State var eventList: Dictionary<String, String>
    @State var TourneyData = ""
    var body: some View {
        NavigationView{
                    VStack{
                        
                        Text(TourneyData).font(.system(size: 5))
                        
                        
                    }
                  }
        .task{
                await GetData()
                
            }
              }
            
    func GetData() async{
        let apiUrl = "https://fortniteapi.io/v1/events/list?lang=en&region=All&showArena=false"

        // Create a URL object from the string =
        let url = URL(string: apiUrl)

        // Create a URL request object
        var request = URLRequest(url: url!)

        // Set the HTTP method to GET
        request.httpMethod = "GET"

        // Add the API key as an HTTP header
        let apiKey = "30492435-463fceb0-62064001-574ba7d3"
        request.addValue(apiKey, forHTTPHeaderField: "Authorization")

        // Create a URL session object
        let session = URLSession.shared

        // Create a data task to retrieve data from the API
        let task = session.dataTask(with: request) { data, response, error in
            // Check for errors
            guard error == nil else {
                print("Error: \(error!)")
                return
            }
            
            // Check for response status code
            guard let httpResponse = response as? HTTPURLResponse,
                  (200...299).contains(httpResponse.statusCode) else {
                print("Invalid response")
                return
            }
            
            // Check for data
            guard let jsonData = data else {
                print("No data returned")
                return
            }
            
            // Parse the JSON data using JSONDecoder
            let decoder = JSONDecoder()
            
            do {
                let decodedData = try decoder.decode(Events.self, from: jsonData)
                print("Data: \(decodedData)")
                TourneyData = "Data: \(decodedData)"
            } catch {
                print("Error decoding JSON data: \(error)")
            }
        }
        task.resume()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(eventList: ["" : ""])
    }
}
struct Events: Codable {
    var events: [Data]
    
    enum CodingKeys : String, CodingKey{
        case events = "events"
       
    }
}
struct Data: Identifiable, Codable{
    var id = UUID()
    var name: String
    var mode: String
    
    enum CodingKeys : String, CodingKey{
        case name = "name_line1"
        case mode = "name_line2"
        
    }
}




//
//  RegionView.swift
//  Fortnite API
//
//  Created by Alex Anderson on 3/14/23.
//

import SwiftUI

struct RegionView: View {
    @State var eventList: Dictionary<String, String>
    @State var TourneyData = ""
    @State private var data = [Data]()
    var Regions: String
    @State private var showingAlert = false
    var body: some View {
            List{
               
                    ForEach(data) { event in
                        NavigationLink{
                        Text("\(event.desc1)")
                            Text("\(event.desc2)")
                            AsyncImage(url: URL(string: "\(event.image)")) { image in
                                image
                                    .resizable()
                                    .frame(width: 350, height: 500)
                            } placeholder: {
                                // placeholder view
                            }
                        } label: {
                            Text("\(event.name) - \(event.mode)")
                        }
                }
            } .navigationTitle("\(Regions)")
        
        .task{
            await GetData()
            
        }
        .alert(isPresented: $showingAlert){
            Alert(title: Text ("Loading Error"),
                  message:Text("There was a problem loading the API Categories"),
                  dismissButton: .default(Text("OK"))
            )
        }
        
        }
    func GetData() async{
        let apiUrl = "https://fortniteapi.io/v1/events/list/active?lang=en&region=\(Regions)&showArena=false"
        
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
        let task = session.dataTask(with: request) { data1, response, error in
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
            guard let jsonData = data1 else {
                print("No data returned")
                return
            }
            
            // Parse the JSON data using JSONDecoder
            let decoder = JSONDecoder()
            
            do {
                let decodedData = try decoder.decode(Events.self, from: jsonData)
                print("Data: \(decodedData)")
                data = decodedData.events
            } catch {
                print("Error decoding JSON data: \(error)")
            }
        }
        task.resume()
    }
}

    struct Region_View_Previews: PreviewProvider {
        static var previews: some View {
            RegionView(eventList: ["" : ""], Regions: String())
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
    var desc1: String
    var desc2: String
    var image: String
    enum CodingKeys : String, CodingKey{
        case name = "name_line1"
        case mode = "name_line2"
        case desc1 = "short_description"
        case desc2 = "long_description"
        case image = "poster"
    }
}

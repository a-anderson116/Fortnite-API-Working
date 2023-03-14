//
//  ContentView.swift
//  Fortnite API
//
//  Created by Alex Anderson on 3/6/23.
//

import SwiftUI
import Foundation

struct ContentView: View {
    // @State var Regions = []
   // let Regions = [String("NAC"), String("ME"), String("EU"), String("ASIA"), String("OCE"), String("BR")]
    
    var body: some View {
        NavigationView{
            VStack{
                Text("Please Choose a Region").font(.system(size:30)).fontWeight(.heavy).bold()
                    .padding()
                Spacer()
                HStack{
                    NavigationLink(
                        destination: Region_View(eventList: ["" : ""], Regions: "NAC"),
                                       label: {
                                           Text("NAC")
                                       }).buttonStyle(CustomButtonStyle())
                    NavigationLink(
                        destination: Region_View(eventList: ["" : ""], Regions: "OCE"),
                                       label: {
                                           Text("OCE")
                                       }).buttonStyle(CustomButtonStyle())
                    NavigationLink(
                        destination: Region_View(eventList: ["" : ""], Regions: "ME"),
                                       label: {
                                           Text("ME")
                                       }).buttonStyle(CustomButtonStyle())
                    NavigationLink(
                        destination: Region_View(eventList: ["" : ""], Regions: "EU"),
                                       label: {
                                           Text("EU")
                                       }).buttonStyle(CustomButtonStyle())
                }
                HStack{
                    NavigationLink(
                        destination: Region_View(eventList: ["" : ""], Regions: "BR"),
                                       label: {
                                           Text("BR")
                                       }).buttonStyle(CustomButtonStyle())
                    NavigationLink(
                        destination: Region_View(eventList: ["" : ""], Regions: "ASIA"),
                                       label: {
                                           Text("ASIA")
                                       }).buttonStyle(CustomButtonStyle())
                }
                Spacer()
                }
            
            }
        }
    }
    
    struct ContentView_Previews: PreviewProvider {
        static var previews: some View {
            ContentView()
        }
    }
struct CustomButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .frame(width:55)
            .font(Font.custom("Coolvetica", size: 24))
            .padding()
            .background(.blue).opacity(configuration.isPressed ? 0.0 : 1.0)
            .foregroundColor(.white)
            .clipShape(RoundedRectangle(cornerRadius: 10))
    }
}

    
    
    


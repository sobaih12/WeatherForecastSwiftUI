//
//  HourlyDetails.swift
//  WeatherForecast-SwiftUI
//
//  Created by Mostfa Sobaih on 12/05/2024.
//

import SwiftUI

struct HourlyDetails: View {
    @State private var hourlyForecast : [Hours] = []
    var isDay : Bool
    var index: Int32
    var dayName : String
    var body: some View {
        ZStack{
            if isDay {
                Image(uiImage: UIImage(named: "dayBackground1") ?? UIImage()).resizable().scaledToFill()
                    .edgesIgnoringSafeArea(.all)
            }else{
                Image(uiImage: UIImage(named: "nightBackground") ?? UIImage()).resizable().scaledToFill()
                    .edgesIgnoringSafeArea(.all)
            }
            VStack{
                HStack{
                    Text("\(dayName) hourly forecast ").padding(.leading,30).padding(.top,20).font(.title).foregroundColor(isDay ? .black : .white)
                    Spacer()
                }
                ScrollView {
                    VStack {
                        ForEach(hourlyForecast.indices, id: \.self) { index in
                            HoursForecastCell(hour: hourlyForecast[index],isDay: isDay)
                        }.padding(.leading)
                    }
                }.padding(.leading).background(Color.clear)
            }
            
        }
        .onAppear() {
            fetchData()
        }
    }
    
    func fetchData(){
        Network.fetchHourly(lat: "30.5965", lon: "32.2715", completion: { result in
            if let weather = result {
                self.hourlyForecast = weather.forecast?.forecastday?[Int(index)].hour ?? []
            }else{
                print("aaaaaaaaa")
            }
        })
    }
}

#Preview {
    HourlyDetails(isDay:true,index: 1,dayName: "sat")
}


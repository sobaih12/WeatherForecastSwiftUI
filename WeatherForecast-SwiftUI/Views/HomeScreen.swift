//
//  HomeScreen.swift
//  WeatherForecast-SwiftUI
//
//  Created by Mostfa Sobaih on 12/05/2024.
//

import SwiftUI

struct HomeScreen: View {
    @State private var weatherResponse: WeatherResponse?
    @State private var locationAddress: String = ""
    @State private var isDay : Bool = true
    @State private var textColor : Color = Color(.white)
    var body: some View {
        NavigationView {
            ZStack{
                if isDay {
                    Image(uiImage: UIImage(named: "dayBackground1") ?? UIImage()).resizable().scaledToFill()
                        .edgesIgnoringSafeArea(.all)
                }else{
                    Image(uiImage: UIImage(named: "nightBackground") ?? UIImage()).resizable().scaledToFill()
                        .edgesIgnoringSafeArea(.all)
                }
                
                VStack{
                    Text(locationAddress).font(.largeTitle).foregroundColor(isDay ? .black : .white)
                    Text("\(Int(weatherResponse?.current?.temp ?? 24))°").font(.title).foregroundColor(isDay ? .black : .white)
                    Text("\(weatherResponse?.current?.weather?[0].main ?? "")").font(.title2).foregroundColor(isDay ? .black : .white)
                    HStack{
                        Text("H:\(Int(weatherResponse?.daily?[0].temp?.max ?? 22))").font(.title2).foregroundColor(isDay ? .black : .white)
                        Text("L:\(Int(weatherResponse?.daily?[0].temp?.min ?? 22))").font(.title2).foregroundColor(isDay ? .black : .white)
                    }
                    Image(uiImage: Utils.getImage(imageCode: weatherResponse?.current?.weather?[0].icon ?? "sun") ?? UIImage()).resizable()
                        .frame(width: 80,height: 80)
                    ScrollView {
                        VStack {
                            DailyForecastCell(daily: weatherResponse?.daily?[0] ?? Daily(),isDay: isDay,index: 0)
                            DailyForecastCell(daily: weatherResponse?.daily?[1] ?? Daily(),isDay: isDay,index: 1)
                            DailyForecastCell(daily: weatherResponse?.daily?[2] ?? Daily(),isDay: isDay,index: 2)
                        }
                    }.frame(height: 200).padding().background(Color.clear)
                    HStack{
                        Spacer()
                        VStack{
                            Text("Visibility").font(.footnote).padding(.bottom , 5).foregroundColor(isDay ? .black : .white)
                            Text("\(weatherResponse?.current?.visibility ?? 12) m").font(.title2).foregroundColor(isDay ? .black : .white)
                        }
                        Spacer()
                        VStack{
                            Text("Humidity").font(.footnote).padding(.bottom , 5).foregroundColor(isDay ? .black : .white)
                            Text("\(weatherResponse?.current?.humidity ?? 12) %").font(.title2).foregroundColor(isDay ? .black : .white)
                        }
                        Spacer()
                    }.padding()
                    HStack{
                        Spacer()
                        VStack{
                            Text("Feels Like").font(.footnote).padding(.bottom , 5).foregroundColor(isDay ? .black : .white)
                            Text("\(Int(weatherResponse?.current?.feels_like ?? 12))°").font(.title2).foregroundColor(isDay ? .black : .white)
                        }
                        Spacer()
                        VStack{
                            Text("Pressure").font(.footnote).padding(.bottom , 5).foregroundColor(isDay ? .black : .white)
                            Text("\(weatherResponse?.current?.pressure ?? 12)").font(.title2).foregroundColor(isDay ? .black : .white)
                        }
                        Spacer()
                    }.padding()
                        .onAppear() {
                            fetchData()
                        }
                }
            }
        }
    }
    
    func fetchData() {
        let locationViewModel = LocationViewModel()
        Network.fetchWeather(lat: "\(locationViewModel.latitude)", lon: "\(locationViewModel.longitude)", completion: { result in
            if let weather = result {
                self.weatherResponse = weather
            }
            Utils.getAddressEnglish(lat:locationViewModel.latitude, lon: locationViewModel.longitude) { address in
                if let address = address {
                    self.locationAddress = address
                }
            }
            self.isDay = Utils.timeAndIsDay(fromTimestamp: weatherResponse?.current?.dt ?? 1)
        })
    }
}

#Preview {
    HomeScreen()
}

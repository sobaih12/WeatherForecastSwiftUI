//
//  DailyForecastCell.swift
//  WeatherForecast-SwiftUI
//
//  Created by Mostfa Sobaih on 12/05/2024.
//

import SwiftUI

struct DailyForecastCell: View {
    var daily : Daily
    var isDay : Bool
    var index : Int32
    var body: some View {
        NavigationLink(destination: HourlyDetails(isDay: isDay, index: index,dayName: Utils.dayOfWeek(fromTimestamp: daily.dt ?? 1) ?? "1")) {
            HStack {
                Spacer()
                Text(Utils.dayOfWeek(fromTimestamp: daily.dt ?? 1) ?? "1").foregroundColor(isDay ? .black : .white).font(.title2)
                Image(uiImage: Utils.getImage(imageCode: daily.weather?[0].icon ?? "sun") ?? UIImage()).resizable().frame(width: 50,height: 50)
                Text("H: \(Int(daily.temp?.max ?? 55))°  L: \(Int(daily.temp?.min ?? 55))°").foregroundColor(isDay ? .black : .white).font(.title2)
                Spacer()
            }.background(Color.clear)
        }
        .buttonStyle(PlainButtonStyle())
        
    }
}

#Preview {
    DailyForecastCell(daily: Daily(),isDay: true,index: 0)
}

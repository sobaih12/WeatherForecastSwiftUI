//
//  HoursForecastCell.swift
//  WeatherForecast-SwiftUI
//
//  Created by Mostfa Sobaih on 12/05/2024.
//

import SwiftUI

struct HoursForecastCell: View {
    var hour : Hours
    var isDay : Bool
    var body: some View {
        HStack {
            Text(Utils.extractTime(from: hour.time ?? "") ?? "sssssssssss").foregroundColor(isDay ? .black : .white).font(.title2).padding(.leading,8)
            Image(uiImage: Utils.getImageFromUrl(imageCode: hour.condition?.code ?? 1) ?? UIImage()).resizable().frame(width: 50,height: 50).padding(.leading,8)
            Text("\(Int(hour.temp_c ?? 1))°").foregroundColor(isDay ? .black : .white).font(.title2).padding(.leading,8)
            Text(hour.condition?.text ?? "aaa").foregroundColor(isDay ? .black : .white).font(.title2).padding(.leading,8)
            Spacer()
        }.background(Color.clear)
    }
}

#Preview {
    HoursForecastCell(hour: Hours(),isDay: true)
}

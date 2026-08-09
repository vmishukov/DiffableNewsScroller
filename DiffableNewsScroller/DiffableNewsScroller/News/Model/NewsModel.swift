//
//  NewsModel.swift
//  DiffableNewsScroller
//
//  Created by Vladislav Mishukov on 09.08.2026.
//

import Foundation

struct NewsModel: Decodable {
    
    let id: String
    let title: String
    let description: String
    let fullUrl: String
    let titleImageUrl: String
    let categoryType: String
    
    
    static func makeMockData() -> [NewsModel] {
        return [
            NewsModel(id: UUID().uuidString,
                      title: "Jensen Interceptor GTX: громкое возвращение",
                      description: "Jensen Interceptor GTX оказался экспериментальным трековым прототипом",
                      fullUrl: "https://www.autodoc.ru/company/news/avto-novosti/denza_z",
                      titleImageUrl: "https://file.autodoc.ru/news/avto-novosti/693680015_1.jpg",
                      categoryType: "Автомобильные новости"),
            NewsModel(id: UUID().uuidString,
                      title: "Denza Z: будущее наступило",
                      description: "Denza официально представил электрический суперкар Z",
                      fullUrl: "https://www.autodoc.ru/company/news/avto-novosti/denza_z",
                      titleImageUrl: "https://file.autodoc.ru/news/avto-novosti/693680015_1.jpg",
                      categoryType: "Автомобильные новости"),
            NewsModel(id: UUID().uuidString,
                      title: "Открытие магазина в г. Псков",
                      description: "г. Псков, ул. Советская, д.41",
                      fullUrl: "https://www.autodoc.ru/company/news/novosti-kompanii/20274",
                      titleImageUrl: "https://file.autodoc.ru/news/foto_magazinov/magazin_pskov_sov.jpg",
                      categoryType: "Новости компании")
        ]
    }
}

//
//  NewsModel.swift
//  DiffableNewsScroller
//
//  Created by Vladislav Mishukov on 09.08.2026.
//

import Foundation

nonisolated struct NewsResponseModel: Decodable {
    
    let news: [NewsModel]
    let totalCount: Int
}

struct NewsModel: Decodable {
    
    let id: Int
    let title: String?
    let description: String?
    let fullUrl: String?
    let titleImageUrl: String?
    let categoryType: String?
    let publishedDate: String?
    
    static func makeMockData() -> [NewsModel] {
        return [
            NewsModel(id: 9039,
                      title: "Jensen Interceptor GTX: громкое возвращение",
                      description: "Jensen Interceptor GTX оказался экспериментальным трековым прототипом",
                      fullUrl: "https://www.autodoc.ru/company/news/avto-novosti/denza_z",
                      titleImageUrl: "https://file.autodoc.ru/news/avto-novosti/693680015_1.jpg",
                      categoryType: "Автомобильные новости",
                      publishedDate: "2026-07-10T00:00:00"),
            NewsModel(id: 9033,
                      title: "Denza Z: будущее наступило",
                      description: "Denza официально представил электрический суперкар Z",
                      fullUrl: "https://www.autodoc.ru/company/news/avto-novosti/denza_z",
                      titleImageUrl: "https://file.autodoc.ru/news/avto-novosti/693680015_1.jpg",
                      categoryType: "Автомобильные новости",
                      publishedDate: "2026-07-18T00:00:00"),
            NewsModel(id: 9031,
                      title: "Открытие магазина в г. Псков",
                      description: "г. Псков, ул. Советская, д.41",
                      fullUrl: "https://www.autodoc.ru/company/news/novosti-kompanii/20274",
                      titleImageUrl: "https://file.autodoc.ru/news/foto_magazinov/magazin_pskov_sov.jpg",
                      categoryType: "Новости компании",
                      publishedDate: "2026-08-05T00:00:00")
        ]
    }
}

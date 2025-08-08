//
//  WeatherInformationTranslator.swift
//  LumiCloud
//
//  Created by Isam El Mourabet on 7/8/25.
//

import Foundation

import Foundation

extension String {
    
    /// Traduce descripciones meteorológicas como "clear sky" a "cielo despejado", usando localización automática o personalizada
    func localizedWeatherDescription(for locale: Locale = Locale.current) -> String {
        // Diccionario de traducciones por idioma (extensible)
        let translations: [String: [String: String]] = [
            "es": [
                "clear sky": "Cielo Despejado",
                "few clouds": "Pocas Nubes",
                "scattered clouds": "Nubes Dispersas",
                "broken clouds": "Nubes Rotas",
                "shower rain": "Chubascos",
                "rain": "Lluvia",
                "thunderstorm": "Tormenta",
                "snow": "Nieve",
                "mist": "Niebla",
                "overcast clouds": "Nublado"
            ],
            "fr": [
                "clear sky": "ciel dégagé",
                "few clouds": "quelques nuages",
                "scattered clouds": "nuages épars",
                "broken clouds": "nuages fragmentés",
                "rain": "pluie",
                "snow": "neige",
                "mist": "brume",
                "overcast clouds": "ciel couvert"
            ]
            // Puedes añadir más idiomas si lo deseas
        ]
        
        let lowercasedSelf = self.lowercased()
        let languageCode = locale.language.languageCode?.identifier ?? "en"
        
        // Si existe traducción en el idioma actual, la usamos
        if let localized = translations[languageCode]?[lowercasedSelf] {
            return localized
        }
        
        // Si no, devolvemos el original
        return self
    }
}

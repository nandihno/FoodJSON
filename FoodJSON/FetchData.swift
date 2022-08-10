//
//  FetchData.swift
//  FoodJSON
//
//  Created by Fernando De Leon on 7/8/2022.
//

import Foundation

struct FetchData {
    
    private var API_KEY: String = "f3bffed439f54a53a33ad449d2130ae4";
    
    var ingredient:String = "";
    
    func fetchWithAsync(ingredient:String) async throws -> FoodSubstitute {
        var foodSubstitue: FoodSubstitute = FoodSubstitute();
        let urlString:String = "https://api.spoonacular.com/food/ingredients/substitutes?apiKey=\(API_KEY)&ingredientName=\(ingredient)";
        
        
        var components:URLComponents = URLComponents();
        components.scheme = "https";
        components.host = "api.spoonacular.com";
        components.path = "/food/ingredients/substitutes";
        components.queryItems = [
            URLQueryItem(name:"apiKey",value: API_KEY),
            URLQueryItem(name:"ingredientName",value: ingredient)
        ];
        print("Here we go --> \(components.string)");
        
       
        

        guard
            let url = components.url
        
        else {
            print("This URL does not work!");
            return foodSubstitue;
            
        }

        // Use the async variant of URLSession to fetch data
        // Code might suspend here
        let (data, httpResponse) = try await URLSession.shared.data(from: url);
       

        // Parse the JSON data
        foodSubstitue = try JSONDecoder().decode(FoodSubstitute.self, from: data);
        print("the foodSub from the fetch is \(foodSubstitue)");
        return foodSubstitue
    }
    
    
}



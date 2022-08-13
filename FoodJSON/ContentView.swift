//
//  ContentView.swift
//  FoodJSON
//
//  Created by Fernando De Leon on 6/8/2022.
//

import SwiftUI

struct ContentView: View {
    
    @State var subsitute:String = "";
    @State var foodSub: FoodSubstitute = FoodSubstitute();
    @State var results:String = "";
    var fetch:FetchData = FetchData();
    @State var myResults:[String] = [];
    @FocusState private var nameIsFocused: Bool;
    
    init() {
       UITableView.appearance().separatorStyle = .none
       UITableViewCell.appearance().backgroundColor = .clear
       UITableView.appearance().backgroundColor = .clear
    }
    
    var body: some View {
        ZStack {
            LinearGradient(gradient: Gradient(colors:[.green,.yellow]), startPoint: .topTrailing, endPoint: .trailing)
                .edgesIgnoringSafeArea(.all)
            VStack {
                Image("FoodIcon")
                    .aspectRatio(contentMode: .fit)
                    .shadow(radius: 40)
                Text("Substitue Food")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                Spacer()
                Form {
                    Section(header: Text("Food Substitute")){
                        TextField("Enter Ingredient Substitute", text: $subsitute)
                            .focused($nameIsFocused);
                    }
                    
                }
                .background(Color.clear);
                
                List(myResults,id: \.self) {
                    Text($0);
                }
               
                Spacer()
                Button {
                    print("fetching data "+subsitute);
                    nameIsFocused = false;
                    Task {
                        do {
                            foodSub = try await fetch.fetchWithAsync(ingredient: subsitute);
                            if(foodSub.substitutes == nil) {
                                myResults = [];
                                myResults.append("Not Found");
                            }
                            if let myArr = foodSub.substitutes {
                                print("myArr is -->   \(myArr)");
                                if(!myArr.isEmpty) {
                                    results = "";
                                    myResults = [];
                                    for aSub in myArr {
                                        results += aSub + " ";
                                        myResults.append(aSub);
                                        
                                    }
                                    
                                }
                                else {
                                    myResults = [];
                                    myResults.append("Not Found");
                                }
                                
                                
                            }
                                
                           
                            
                        } catch {
                            print("Error "+error.localizedDescription);
                        }
                    }
                    
                    
                } label: {
                    FetchDataButton()
                }
               
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct FetchDataButton: View {
    
    var body: some View {
        Text("Check It OUT")
            .bold()
            .frame(width: 200, height: 58)
            .background(Color.green)
            .cornerRadius(23)
    }
}

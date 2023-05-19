//
//  DetailView.swift
//  Bajaj Test
//
//  Created by Prakhar Parakh on 19/05/23.
//

import SwiftUI

struct DetailView: View {
    var empdetail = [Employee]()
    
    var body: some View {
        ZStack{
            Color.blue
                .opacity(0.8)
                .ignoresSafeArea()
            
            ScrollView{
                
                VStack{
                    HStack{
                        Text("Skills: ")
                            .fontWeight(.bold)
                        ForEach(0..<empdetail[0].skills.count) { i in
                            Text("\(empdetail[0].skills[i])")
                        }
                    }
                        .padding(.bottom)
                    
                    VStack{
                        ForEach(0..<empdetail[0].projects!.count,id:\.self) { i in
                            VStack(alignment:.leading,spacing: 10){
                                Text("\(empdetail[0].projects![i].name)")
                                    .fontWeight(.bold)
                                Text("\(empdetail[0].projects![i].description?.rawValue ?? "Nil")")
                                Text("Team")
                                    .fontWeight(.bold)
                                ForEach(0..<empdetail[0].projects![i].team.count) { j in
                                    HStack{
                                        Text("Name: \(empdetail[0].projects![i].team[j].name ?? "Nil"),")
                                        Text("Role: \(empdetail[0].projects![i].team[j].role.rawValue)")
                                    }
                                    
                                }
                                Text("Task")
                                    .fontWeight(.bold)
                                ForEach(0..<empdetail[0].projects![i].tasks!.count) { k in
                                    HStack{
                                        Text("Id: \(empdetail[0].projects![i].tasks![k].id),".replacingOccurrences(of: "integer", with: "") as String)
                                        Text("Name: \(empdetail[0].projects![i].tasks![k].name?.rawValue ?? "Nil")," )
                                        Text("Status: \(empdetail[0].projects![i].tasks![k].status?.rawValue ?? "Nil")" )


                                    }
                                }
                                Divider()
                                    .frame(height: 2)
                                    .overlay(.black)
                                
                            }.padding(.leading)
                            
                        }
                    }
                    
                    
                }
                
                
                
            }
            
        }
    }
}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        DetailView()
    }
}

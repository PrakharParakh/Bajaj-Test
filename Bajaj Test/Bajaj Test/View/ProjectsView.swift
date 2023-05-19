//
//  ProjectsView.swift
//  Bajaj Test
//
//  Created by Prakhar Parakh on 19/05/23.
//

import SwiftUI

extension UIScreen{
   static let screenWidth = UIScreen.main.bounds.size.width
   static let screenHeight = UIScreen.main.bounds.size.height
   static let screenSize = UIScreen.main.bounds.size
}



struct ProjectsView: View {
    @StateObject var projectVM = ProjectsViewModel()
    @State var search: String = ""
    var body: some View {
        
        NavigationView{
            ZStack{
                    Color.blue
                        .ignoresSafeArea()
                    ScrollView{
                        
                        
                        VStack{
                            
                            if projectVM.procede {
                                
                                ForEach(0..<projectVM.results[0].employees.count){i in
                                    
                                    NavigationLink(destination: DetailView(empdetail: [projectVM.results[0].employees[i]])) {
                                        HStack {
                                            VStack(alignment: .leading,spacing: 15){
                                                Text("Id: \(projectVM.results[0].employees[i].id)".replacingOccurrences(of: "integer", with: "") as String)
                                                    .padding(.top)
                                                Text("Name: \(projectVM.results[0].employees[i].name ?? "Nil")")
                                                Text("Designation: \(projectVM.results[0].employees[i].designation?.rawValue ?? "Nil")")
                                                    .padding(.bottom)
                                                
                                            }
                                            .padding(.leading)
                                            .foregroundColor(.black)
                                            Spacer()
                                            Image(systemName: "chevron.right")
                                                .padding(.trailing)
                                            
                                        }.frame(maxWidth: UIScreen.screenWidth - 32)

                                            .background{
                                                RoundedRectangle(cornerRadius: 10)
                                                    .foregroundColor(.white)
                                                    .opacity(0.6)
                                            }
                                            .padding()
                                    }
                                    
                                    
                                }
                            }
                            
                        }
                        
                    }.task {
                        await projectVM.getData()
                        
                    }
            }
                
            
        }
    }
  
}

struct ProjectsView_Previews: PreviewProvider {
    static var previews: some View {
        ProjectsView()
    }
}

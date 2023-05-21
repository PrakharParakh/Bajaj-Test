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

struct iOSCheckboxToggleStyle: ToggleStyle {
    func makeBody(configuration: Configuration) -> some View {
        // 1
        Button(action: {

            // 2
            configuration.isOn.toggle()

        }, label: {
            HStack {
                // 3
                Image(systemName: configuration.isOn ? "checkmark.square" : "square")
                    .foregroundColor(.white)

                configuration.label
            }
        })
    }
}



struct ProjectsView: View {
    @StateObject var projectVM = ProjectsViewModel()
    @State var listOfFilters = ["SQL", "Javascript", "Python", "HTML", "CSS",
                                "Photoshop", "Manual Testing","Java"]
    @State var search: String = ""
    @State var showFilters: Bool = false
    @State var isON:[Bool] = [false,false,false,false,false,false,false,false]
    @State var finalList = []
    @State var initi: Bool = true
    
    var body: some View {
        
        NavigationView{
            ZStack{
                    Color.blue
                        .ignoresSafeArea()
                    ScrollView{
                        
                        Button{
                            showFilters.toggle()
                        }label: {
                            Text("Filters")
                                .foregroundColor(.white)
                        }
                        
                        if showFilters{
                            VStack{
                                ForEach(0..<listOfFilters.count,id:\.self) { i in
                                    Toggle(isOn: $isON[i]) {
                                        Text("\(listOfFilters[i])")
                                            .foregroundColor(.white)
                                    }
                                    .toggleStyle(iOSCheckboxToggleStyle())
                                    .onChange(of: isON[i]) { newValue in
                                        if newValue{
                                            makeFilteredList(filter: listOfFilters[i])
                                        }
                                        else{
                                            removeFromFilteredList(filter: listOfFilters[i])

                                        }
                                    }
                                }
                                
                                
                            }
                        }
                       
                        
                        VStack{
                            
                            if projectVM.procede && initi {
                                
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
                            
                            if projectVM.procede && !initi && projectVM.filteredList.count > 0{
                                ForEach(0..<projectVM.filteredList.count){i in
                                    
                                    NavigationLink(destination: DetailView(empdetail: [projectVM.filteredList[i]])) {
                                        HStack {
                                            VStack(alignment: .leading,spacing: 15){
                                                Text("Id: \(projectVM.filteredList[i].id)".replacingOccurrences(of: "integer", with: "") as String)
                                                    .padding(.top)
                                                Text("Name: \(projectVM.filteredList[i].name ?? "Nil")")
                                                Text("Designation: \(projectVM.filteredList[i].designation?.rawValue ?? "Nil")")
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
                
            
        }.searchable(text: $search)
    }
    
    var searchResults: [Projects] {
        if search.isEmpty {
            return projectVM.results
        } else {
            return projectVM.results.filter{$0.employees[0].name!.contains(search) }
        }
        
    }
    
    func makeFilteredList(filter: String){
        for i in (0..<projectVM.results[0].employees.count) {
            if projectVM.results[0].employees[i].skills.contains(filter){
                print(projectVM.results[0].employees[i].skills)
                projectVM.filteredList.append(projectVM.results[0].employees[i])
            }
        }
        //print(projectVM.filteredList.count)
        initi = false
    }
    func removeFromFilteredList(filter: String){
        
        projectVM.filteredList.removeAll(where: {$0.skills.contains(filter)})
    }
  
}

struct ProjectsView_Previews: PreviewProvider {
    static var previews: some View {
        ProjectsView()
    }
}

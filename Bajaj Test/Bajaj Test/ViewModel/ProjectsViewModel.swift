//
//  ProjectsViewModel.swift
//  Bajaj Test
//
//  Created by Prakhar Parakh on 19/05/23.
//

import Foundation

class ProjectsViewModel: ObservableObject{
    @Published var results = [Projects]()
    @Published var procede: Bool = false
    func getData() async{
        guard let url = URL(string:"https://raw.githubusercontent.com/dixitsoham7/dixitsoham7.github.io/main/index.json") else{
            print("e1")
            return
        }
        do{
            let (data, _) = try await URLSession.shared.data(from: url)
            print("data = \(data)")
            guard let dr = try? JSONDecoder().decode(Projects.self, from: data) else{
                print("e3")
                return
            }
            self.results.append(dr)
            print(self.results)
            self.procede.toggle()
        }catch{
            print("e2")

        }
    }

}

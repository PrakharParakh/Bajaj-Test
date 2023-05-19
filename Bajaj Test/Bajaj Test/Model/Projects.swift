//
//  Projects.swift
//  Bajaj Test
//
//  Created by Prakhar Parakh on 19/05/23.
//

import Foundation

// MARK: - Projects
struct Projects: Codable {
    let employees: [Employee]
}

// MARK: - Employee
struct Employee: Codable {
    var id: IDUnion
    let name: String?
    let designation: Designation?
    let skills: [String]
    let projects: [Project]?
}

enum Designation: String, Codable {
    case projectManager = "Project Manager"
    case qaEngineer = "QA Engineer"
    case seniorDeveloper = "Senior Developer"
}

enum IDUnion: Codable {
    case enumeration(IDEnum)
    case integer(Int)

    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let x = try? container.decode(Int.self) {
            self = .integer(x)
            return
        }
        if let x = try? container.decode(IDEnum.self) {
            self = .enumeration(x)
            return
        }
        throw DecodingError.typeMismatch(IDUnion.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for IDUnion"))
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .enumeration(let x):
            try container.encode(x)
        case .integer(let x):
            try container.encode(x)
        }
    }
}

enum IDEnum: String, Codable {
    case completed = "Completed"
    case inProgress = "In Progress"
    case pending = "Pending"
    case undefined = "undefined"
}

// MARK: - Project
struct Project: Codable {
    let name: String
    let description: Description?
    let team: [Team]
    let tasks: [Task]?
}

enum Description: String, Codable {
    case loremIpsumDolorSitAmetConsecteturAdipiscingElit = "Lorem ipsum dolor sit amet, consectetur adipiscing elit."
}

// MARK: - Task
struct Task: Codable {
    let id: IDUnion
    let name: Name?
    let status: IDEnum?
}

enum Name: String, Codable {
    case task1 = "Task 1"
    case task2 = "Task 2"
    case task3 = "Task 3"
}

// MARK: - Team
struct Team: Codable {
    let name: String?
    let role: Role
}

enum Role: String, Codable {
    case designer = "Designer"
    case developer = "Developer"
    case tester = "Tester"
}


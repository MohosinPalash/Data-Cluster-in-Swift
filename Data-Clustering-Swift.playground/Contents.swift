import UIKit

var thesisData = """
[
    {
        "id": 1,
        "supervisor_name": "Professor Hayley Henington",
        "student_name": "Marta Murray",
        "group_no": 1,
        "research_title": "Securing Machine Learning in the Cloud: A Systematic Review of Cloud Machine Learning Security"
    },
    {
        "id": 2,
        "supervisor_name": "Professor Edward Degregorio",
        "student_name": "Leonardo Grimes",
        "group_no": 3,
        "research_title": "Computational Learning Theory and Statistical Learning Theory in Machine Learning"
    },
    {
        "id": 3,
        "supervisor_name": "Professor Hayley Henington",
        "student_name": "Dena Vance",
        "group_no": 2,
        "research_title": "Systematic Review of Deep Learning and Machine Learning for Building Energy"
    },
    {
        "id": 4,
        "supervisor_name": "Professor Hayley Henington",
        "student_name": "Kasey Strickland",
        "group_no": 1,
        "research_title": "Optimal Taxation and Insurance Using Machine Learning: Learning Sufficient Statistics and Beyond"
    },
    {
        "id": 5,
        "supervisor_name": "Professor Edward Degregorio",
        "student_name": "Fabian Carroll",
        "group_no": 3,
        "research_title": "Incremental and Parallel Machine Learning Algorithms With Automated Learning Rate Adjustments"
    },
    {
        "id": 6,
        "supervisor_name": "Professor Jake Joe",
        "student_name": "Davis Melton",
        "group_no": 5,
        "research_title": "Machine Learning Approaches for Motor Learning: A Short Review"
    },
    {
        "id": 7,
        "supervisor_name": "Professor Edward Degregorio",
        "student_name": "Stacy Dillon",
        "group_no": 4,
        "research_title": "Editorial: Machine Learning and Deep Learning for Physiological Signal Analysis"
    },
    {
        "id": 8,
        "supervisor_name": "Professor Hayley Henington",
        "student_name": "Kristofer Phelps",
        "group_no": 2,
        "research_title": "Deep Learning for Deep Chemistry: Optimizing the Prediction of Chemical Patterns"
    },
    {
        "id": 9,
        "supervisor_name": "Professor Jake Joe",
        "student_name": "Ronald Mcdonald",
        "group_no": 5,
        "research_title": "Deep Plant Phenomics: A Deep Learning Platform for Complex Plant Phenotyping Tasks"
    },
    {
        "id": 10,
        "supervisor_name": "Professor Edward Degregorio",
        "student_name": "Benny Mays",
        "group_no": 4,
        "research_title": "Deep Learning-Based Deep Brain Stimulation Targeting and Clinical Applications"
    }
]
"""

//MODEL
struct ThesisGroup: Codable, Identifiable {
    var id: Int
    var supervisorName: String
    var studentName: String
    var groupNo: Int
    var researchTitle: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case supervisorName = "supervisor_name"
        case studentName = "student_name"
        case groupNo = "group_no"
        case researchTitle = "research_title"
    }
}

//Parse JSON data
var thesisDataList: [ThesisGroup] = []
func parseData() {
    if let data = thesisData.data(using: .utf8) {
        do {
            thesisDataList =  try JSONDecoder().decode([ThesisGroup].self, from: data)
        } catch {
            debugPrint("Error in parsing data")
        }
    }
}
parseData()

//Cluster data based on Supervisor Name
var GroupBySupervisorName: Dictionary<String, [ThesisGroup]> = [:]
func clusterBySupervisor() {
    for i in thesisDataList.indices {
        GroupBySupervisorName[thesisDataList[i].supervisorName, default: []].append(thesisDataList[i])
    }
    print("***** Clustered by Supervisor Name *****\n")
    for (supervisor,students) in GroupBySupervisorName.sorted(by: { $0.key < $1.key }) {
        print("\nSupervisor Name: \(supervisor)")
        for student in students {
            print("ID: \(student.id)\t Student Name: \(student.studentName)")
        }
    }
}
clusterBySupervisor()

//Cluster data based on Group No
var GroupByGroupNo: Dictionary<Int, [ThesisGroup]> = [:]
func clusterByGroupNo() {
    for i in thesisDataList.indices {
        GroupByGroupNo[thesisDataList[i].groupNo, default: []].append(thesisDataList[i])
    }
    print("\n\n***** Clustered by Group No *****\n")
    for (groupNo,students) in GroupByGroupNo.sorted(by: { $0.key < $1.key }) {
        print("\nGroup No: \(groupNo)")
        for student in students {
            print("ID: \(student.id)\t Student Name: \(student.studentName)\t Supervisor Name: \(student.supervisorName)")
        }
    }
}
clusterByGroupNo()

/*
 Output of the code:
 
 ***** Clustered by Supervisor Name *****


 Supervisor Name: Professor Edward Degregorio
 ID: 2     Student Name: Leonardo Grimes
 ID: 5     Student Name: Fabian Carroll
 ID: 7     Student Name: Stacy Dillon
 ID: 10     Student Name: Benny Mays

 Supervisor Name: Professor Hayley Henington
 ID: 1     Student Name: Marta Murray
 ID: 3     Student Name: Dena Vance
 ID: 4     Student Name: Kasey Strickland
 ID: 8     Student Name: Kristofer Phelps

 Supervisor Name: Professor Jake Joe
 ID: 6     Student Name: Davis Melton
 ID: 9     Student Name: Ronald Mcdonald


 ***** Clustered by Group No *****


 Group No: 1
 ID: 1     Student Name: Marta Murray     Supervisor Name: Professor Hayley Henington
 ID: 4     Student Name: Kasey Strickland     Supervisor Name: Professor Hayley Henington

 Group No: 2
 ID: 3     Student Name: Dena Vance     Supervisor Name: Professor Hayley Henington
 ID: 8     Student Name: Kristofer Phelps     Supervisor Name: Professor Hayley Henington

 Group No: 3
 ID: 2     Student Name: Leonardo Grimes     Supervisor Name: Professor Edward Degregorio
 ID: 5     Student Name: Fabian Carroll     Supervisor Name: Professor Edward Degregorio

 Group No: 4
 ID: 7     Student Name: Stacy Dillon     Supervisor Name: Professor Edward Degregorio
 ID: 10     Student Name: Benny Mays     Supervisor Name: Professor Edward Degregorio

 Group No: 5
 ID: 6     Student Name: Davis Melton     Supervisor Name: Professor Jake Joe
 ID: 9     Student Name: Ronald Mcdonald     Supervisor Name: Professor Jake Joe

 */

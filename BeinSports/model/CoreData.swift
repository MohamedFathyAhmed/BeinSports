
import CoreData
import UIKit

class CoreData {
    var db: OpaquePointer?
    static let shared = CoreData()
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
   private init() {
       
    }
    

    
    func insertTeam( key: Int,name: String, logo: String, sport: String) {
        let obj = DBTeam(context: context)
        obj.key = Int64((key))
        obj.name = name
        obj.logo = logo
        obj.sport = sport
        //commit data
        do{
        try context.save()
            print("done")
        }catch{
            
        }
    }
    
    func readTeams() -> [DBTeam] {
        var friends = [DBTeam]()
        let request :NSFetchRequest<DBTeam> = DBTeam.fetchRequest()
        do{
            friends = try context.fetch(request)
        }catch{
            print("error fetch\(error)")
        }
        return friends
    }
    
    func deleteTeam(Team:DBTeam){
      
        context.delete(Team)
        do{
            try context.save()
        }catch let error as NSError {
            print(error.localizedDescription)
        }
        
    }
    
    func insertPlayer( key: Int,name: String, logo: String, sport: String) {
        let obj = DBPlayer(context: context)
        obj.key = Int64((key))
        obj.name = name
        obj.logo = logo
        obj.sport = sport
        //commit data
        do{
        try context.save()
            print("done")
        }catch{
            
        }
    }
    
    func readPlayers() -> [DBPlayer] {
        var friends = [DBPlayer]()
        let request :NSFetchRequest<DBPlayer> = DBPlayer.fetchRequest()
        do{
            friends = try context.fetch(request)
        }catch{
            print("error fetch\(error)")
        }
        return friends
    }
    
    func deletePlayer(Team:DBPlayer){
      
        context.delete(Team)
        do{
            try context.save()
        }catch let error as NSError {
            print(error.localizedDescription)
        }
        
    }
    
}


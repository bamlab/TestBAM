import Foundation
import UIKit
import CoreData

class FavoritesProvider {

  //----------------------------------------------------------------------------
  // MARK: - Properties
  //----------------------------------------------------------------------------

  static var shared = FavoritesProvider()

  /******************** Parameters ********************/

  private lazy var context: NSManagedObjectContext = {
    let delegate = UIApplication.shared.delegate as! AppDelegate
    let context = delegate.persistentContainer.viewContext
    return context
  }()

  //----------------------------------------------------------------------------
  // MARK: - Initialization
  //----------------------------------------------------------------------------

  private init() {}

  //----------------------------------------------------------------------------
  // MARK: - Methods
  //----------------------------------------------------------------------------

  func addFavorite(_ name: String) {
    let favorite = createFavoriteObject(name)

    do {
      try context.save()
    } catch let error as NSError {
      print("Could not save. \(error), \(error.userInfo)")
    }
  }

  func removeFavorite(_ name: String) {
    let request = NSFetchRequest<NSManagedObject>(entityName: "Favorite")
    request.predicate = NSPredicate(format: "name == %@", name)

    do {
      guard let fav = try context.fetch(request).first else { return }
      context.delete(fav)
    } catch let error as NSError {
      print("Could not fetch. \(error), \(error.userInfo)")
      return
    }


  }

  func getFavorites() -> [String] {
    let request = NSFetchRequest<NSManagedObject>(entityName: "Favorite")

    do {
      let favorites = try context.fetch(request)
      return favorites.compactMap() { $0.value(forKey: "name") as? String }
    } catch let error as NSError {
      print("Could not fetch. \(error), \(error.userInfo)")
      return []
    }
  }


  @discardableResult
  private func createFavoriteObject(_ name: String) -> NSManagedObject {
    let entity = NSEntityDescription.entity(forEntityName: "Favorite",
                                            in: context)!
    let favorite = NSManagedObject(entity: entity, insertInto: context)
    favorite.setValue(name, forKey: "name")

    return favorite
  }
}

//
//  DataPersistenceManager.swift
//  AnimeHub
//
//  Created by Tobi on 12/10/2023.
//

import CoreData
import RxSwift

final class CoreDataManager {

    private let fetchRequest = NSFetchRequest<AnimeEntity>(entityName: "AnimeEntity")
    static let shared = CoreDataManager()

    private init() {}

    private lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "AnimeModel")
        container.loadPersistentStores(completionHandler: { (_, error) in
            if let error = error as NSError? {
                fatalError("Load Core Data failed: \(error), \(error.userInfo)")
            }
        })
        return container
    }()

    func checkEntityExist(id: Int) -> Observable<Bool> {
        let context = persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "AnimeEntity")
        fetchRequest.fetchLimit =  1
        fetchRequest.predicate = NSPredicate(format: "id == %d", id)
        var entitiesCount = 0

        return Observable.create { observer in
            do {
                entitiesCount = try context.count(for: fetchRequest)
                observer.onNext(entitiesCount > 0)
                observer.onCompleted()
            } catch {
                observer.onError(DatabaseError.saveDataFailed)
            }
            return Disposables.create()
        }
    }

    func getAllFavourites() -> Observable<[AnimeEntity]> {
        let context = persistentContainer.viewContext
        return Observable.create { observer in
            do {
                let entity = try context.fetch(self.fetchRequest)
                observer.onNext(entity)
                observer.onCompleted()
            } catch {
                observer.onError(DatabaseError.fetchDataFailed)
            }
            return Disposables.create()
        }
    }

    func saveToDatabase(anime: Anime) -> Observable<Void> {
        let context = persistentContainer.viewContext
        
        return Observable.create { observer in
            do {
                AnimeEntity(context: context).do {
                    $0.id = Int64(anime.malId)
                    $0.imageURL = anime.images.jpg.imageURL
                    $0.score = Int64(anime.score ?? 0)
                    $0.status = anime.status
                    $0.title = anime.title
                }
                try context.save()
                observer.onNext(())
                observer.onCompleted()
            } catch {
                observer.onError(DatabaseError.saveDataFailed)
            }
            return Disposables.create()
        }
    }

    func deleteFavourite(id: Int) -> Observable<Void> {
        let context = persistentContainer.viewContext
        return Observable.create { observer in
            do {
                if let favourites = try? context.fetch(self.fetchRequest) {
                    for favourite in favourites where favourite.id == id {
                        context.delete(favourite)
                        try context.save()
                        observer.onNext(())
                        observer.onCompleted()
                    }
                }
            } catch {
                observer.onError(DatabaseError.deleteDataFailed)
            }
            return Disposables.create()
        }
    }
}

//
//  SceneDelegate.swift
//  ToDoList
//
//  Created by Артур Миннушин on 03.09.2024.


import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    var networkManger = NetworkManager.shared
    var coreDataManager = CoreDataManager.shared
    var userDefauits = UserDefaults.standard

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        print(userDefauits.bool(forKey: "first_start"))
        if !userDefauits.bool(forKey: "first_start") {
            networkManger.obtainStartTasks()
            userDefauits.setValue(true, forKey: "first_start")
        }
        guard let windowScene = (scene as? UIWindowScene) else { return }
        let viewModel = TaskScreenViewModel()
        let viewController = TaskScreenViewController(viewModel: viewModel)
        window = UIWindow(windowScene: windowScene)
        window?.rootViewController = viewController
        window?.makeKeyAndVisible()
    }

    func sceneDidDisconnect(_ scene: UIScene) {
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
    }

    func sceneWillResignActive(_ scene: UIScene) {
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
    }
    func sceneDidEnterBackground(_ scene: UIScene) {
        coreDataManager.saveContext()
    }
}


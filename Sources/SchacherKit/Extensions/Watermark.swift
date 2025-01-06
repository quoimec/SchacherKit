//
//  Watermark.swift
//
//
//  Created by Charlie on 16/8/2024.
//

// @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate

import UIKit
import SwiftUI

class AppDelegate: NSObject, UIApplicationDelegate {
  func application(_ application: UIApplication,
                   didFinishLaunchingWithOptions launchOptions:
                   [UIApplication.LaunchOptionsKey : Any]? = nil)
  -> Bool { return true }

  func application(_ application: UIApplication,
                   configurationForConnecting connectingSceneSession: UISceneSession,
                  options: UIScene.ConnectionOptions) -> UISceneConfiguration {
      let configuration = UISceneConfiguration(name: nil, sessionRole: connectingSceneSession.role)
      if connectingSceneSession.role == .windowApplication {
          configuration.delegateClass = SceneDelegate.self
      }
      return configuration
  }
}

final class SceneDelegate: NSObject, UIWindowSceneDelegate {

  var secondaryWindow: UIWindow?

  func scene(_ scene: UIScene,
             willConnectTo session: UISceneSession,
             options connectionOptions: UIScene.ConnectionOptions) {
      if let windowScene = scene as? UIWindowScene {
          setupSecondaryOverlayWindow(in: windowScene)
      }
  }

  func setupSecondaryOverlayWindow(in scene: UIWindowScene) {
      let secondaryViewController = UIHostingController(
          rootView:
              EmptyView()
                  .frame(maxWidth: .infinity, maxHeight: .infinity)
                  .modifier(Watermark())
      )
    secondaryViewController.view.backgroundColor = .clear
    let secondaryWindow = PassThroughWindow(windowScene: scene)
    secondaryWindow.rootViewController = secondaryViewController
    secondaryWindow.isHidden = false
    self.secondaryWindow = secondaryWindow
  }
}

class PassThroughWindow: UIWindow {
  override func hitTest(_ point: CGPoint,
                        with event: UIEvent?) -> UIView? {
    guard let hitView = super.hitTest(point, with: event)
    else { return nil }

    return rootViewController?.view == hitView ? nil : hitView
  }
}

struct Watermark: ViewModifier {
    
    func body(content: Content) -> some View {
      
        content
            .overlay(content: {
                
                VStack(content: {
                    
                    Spacer()
                    
                    Text("Pre-payment watermark - App by Charles Schacher")
                        .font(Font.system(size: 30, weight: .bold, design: .rounded))
                        .padding(20)
                        .background(.background)
                        .clipShape(
                          RoundedRectangle(cornerRadius: 25, style: .continuous)
                        )
                        .overlay(
                          RoundedRectangle(cornerRadius: 25)
                            .strokeBorder(.tertiary, lineWidth: 1)
                        )
                        .shadow(color: .black.opacity(0.15), radius: 10, y: 3)
                        .padding(.horizontal)
                        .opacity(0.5)
                    
                })
                .padding(.bottom, 20)
                .allowsHitTesting(false)
                
            })
        
      }
    
}

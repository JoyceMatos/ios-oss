@testable import Kickstarter_Framework
@testable import KsApi
import Library
import Prelude
import Prelude_UIKit
import UIKit
import PlaygroundSupport

//: __Thanks Page__

let projects = [
  .anomalisa |> Project.lens.photo.med .~ "http://lorempixel.com/460/345/",
  .template
    |> Project.lens.id .~ 2
    |> Project.lens.name .~ "A Nice Title"
    |> Project.lens.photo.med .~ "http://lorempixel.com/460/345/",
  .template
    |> Project.lens.id .~ 3
    |> Project.lens.name .~ "Another Nice Title"
    |> Project.lens.photo.med .~ "http://lorempixel.com/460/345/"
]

let projectsResponse = .template |> DiscoveryEnvelope.lens.projects .~ projects

AppEnvironment.replaceCurrentEnvironment(
    apiService: MockService(
        oauthToken: OauthToken(token: "deadbeef"),
        fetchDiscoveryResponse: projectsResponse
    ),
    language: .en, locale: Locale(identifier: "en"),
    mainBundle: Bundle.framework
)

initialize()
let controller = ThanksViewController.configuredWith(project: Project.cosmicSurgery)
let nav = UINavigationController(rootViewController: controller)

let (parent, _) = playgroundControllers(device: .phone4_7inch, orientation: .portrait, child: nav)
let frame = parent.view.frame
PlaygroundPage.current.liveView = parent
parent.view.frame = frame

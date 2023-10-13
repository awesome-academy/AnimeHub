//
//  DetailViewController.swift
//  AnimeHub
//
//  Created by Tobi on 12/10/2023.
//

import UIKit
import RxSwift
import RxCocoa

final class DetailViewController: UIViewController, Bindable {

    var viewModel: DetailViewModel!
    var anime: Anime?

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    func bindViewModel() {
        // TODO: Implements later
    }
}

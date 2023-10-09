//
//  HomeViewController.swift
//  AnimeHub
//
//  Created by Tobi on 05/10/2023.
//

import UIKit
import RxSwift
import RxCocoa

final class HomeViewController: UIViewController, Bindable {

    @IBOutlet private weak var animeTableView: UITableView!

    var viewModel: HomeViewModel!
    private let disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()

        configView()
    }

    private func configView() {
        self.navigationItem.title = StringGen.homeTitle
        self.animeTableView.register(cellType: HomeTableViewCell.self)
        self.animeTableView.rowHeight = Constant.Size.rowHeight
    }

    func bindViewModel() {
        let loadTrigger = Driver.just(())

        let input = HomeViewModel.Input(load: loadTrigger)

        let output = viewModel.transform(input, disposeBag: disposeBag)

        output.animeList
            .drive(animeTableView.rx.items) { table, row, element in
                let indexPath = IndexPath(row: row, section: 0)
                let cell: HomeTableViewCell = table.dequeueReusableCell(for: indexPath)
                cell.configCell(anime: element)
                return cell
            }
            .disposed(by: disposeBag)

        output.isLoading
            .drive(rx.isLoading)
            .disposed(by: disposeBag)
    }
}

//
//  FavoriteViewController.swift
//  AnimeHub
//
//  Created by Tobi on 05/10/2023.
//

import UIKit
import RxSwift
import RxCocoa

final class FavoriteViewController: UIViewController, Bindable {

    @IBOutlet private weak var favoriteTableView: UITableView!

    var viewModel: FavoriteViewModel!
    private let disposeBag = DisposeBag()
    private let loadTrigger = PublishSubject<Void>()
    private let deleteTrigger = PublishSubject<IndexPath>()
    private let selectTrigger = PublishSubject<IndexPath>()

    override func viewDidLoad() {
        super.viewDidLoad()

        configView()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        loadTrigger.onNext(())
    }

    private func configView() {
        self.navigationItem.title = StringGen.favoriteTitle
        self.favoriteTableView.do {
            $0.register(cellType: FavoriteTableViewCell.self)
            $0.rowHeight = Constant.Size.favoriteCellHeight
        }
    }

    func bindViewModel() {
        let input = FavoriteViewModel.Input(
            loadTrigger: loadTrigger.asDriver(onErrorJustReturn: ()),
            deleteTrigger: deleteTrigger.asDriver(onErrorDriveWith: .empty()),
            selectTrigger: selectTrigger.asDriver(onErrorDriveWith: .empty())
        )

        let output = viewModel.transform(input, disposeBag: disposeBag)

        output.animeList
            .drive(favoriteTableView.rx.items) { table, row, element in
                let indexPath = IndexPath(row: row, section: 0)
                let cell: FavoriteTableViewCell = table.dequeueReusableCell(for: indexPath)
                cell.configCell(anime: element)

                return cell
            }
            .disposed(by: disposeBag)

        output.isLoading
            .drive(rx.isLoading)
            .disposed(by: disposeBag)

        favoriteTableView.rx.itemDeleted
            .subscribe(onNext: { [weak self] indexPath in
                self?.deleteTrigger.onNext(indexPath)
                self?.loadTrigger.onNext(())
            })
            .disposed(by: disposeBag)
    }
}

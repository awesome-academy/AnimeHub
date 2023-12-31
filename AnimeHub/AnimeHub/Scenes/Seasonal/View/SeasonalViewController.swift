//
//  SeasonalViewController.swift
//  AnimeHub
//
//  Created by Tobi on 05/10/2023.
//

import UIKit
import RxSwift
import RxCocoa

final class SeasonalViewController: UIViewController, Bindable {

    @IBOutlet private weak var categoryButton: UIButton!
    @IBOutlet private weak var animeCollectionView: UICollectionView!

    var viewModel: SeasonalViewModel!
    private let disposeBag = DisposeBag()
    private var selectTrigger = PublishSubject<IndexPath>()
    private var filterTrigger = BehaviorSubject(value: Constant.Object.defaultFilter.rawValue)

    override func viewDidLoad() {
        super.viewDidLoad()

        configView()
        animeCollectionView.delegate = self

        changeFilter(filter: Constant.Object.defaultFilter)
    }

    private func configView() {
        self.navigationItem.title = StringGen.seasonalTitle
        self.animeCollectionView.register(cellType: AnimeCollectionViewCell.self)
        setupMenuButton()
    }

    private func changeFilter(filter: Filter) {
        self.categoryButton.setTitle("\(filter.rawValue.capitalizeFirstLetter()) ▾", for: .normal)
    }

    private func setupMenuButton() {
        let filterMenu = Filter.allCases.map { item in
            return UIAction(title: item.rawValue.capitalized) { [unowned self] _ in
                self.changeFilter(filter: item)
                self.filterTrigger.onNext(item.rawValue)
            }
        }

        categoryButton.do {
            $0.menu = UIMenu(children: filterMenu)
            $0.showsMenuAsPrimaryAction = true
        }
    }

    func bindViewModel() {
        let input = SeasonalViewModel.Input(
            filter: filterTrigger.asDriver(onErrorJustReturn: Constant.String.empty),
            selectTrigger: selectTrigger.asDriver(onErrorJustReturn: IndexPath())
        )

        let output = viewModel.transform(input, disposeBag: disposeBag)

        output.animeList
            .drive(animeCollectionView.rx.items) { table, row, element in
                let indexPath = IndexPath(row: row, section: 0)
                let cell: AnimeCollectionViewCell = table.dequeueReusableCell(for: indexPath)
                cell.configCell(anime: element)
                cell.goDetail = {
                    self.selectTrigger.onNext(IndexPath(row: row, section: 0))
                }
                return cell
            }
            .disposed(by: disposeBag)

        output.isLoading
            .drive(rx.isLoading)
            .disposed(by: disposeBag)
    }
}

extension SeasonalViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {

        let width = (animeCollectionView.frame.width - Constant.Size.paddingHorizontal * 2) / Constant.Number.cellInRow
        let height = Constant.Size.animeCellHeight

        return CGSize(width: width, height: height)
    }
}

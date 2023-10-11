//
//  SearchViewController.swift
//  AnimeHub
//
//  Created by Tobi on 05/10/2023.
//

import UIKit
import RxSwift
import RxCocoa

final class SearchViewController: UIViewController, Bindable {

    @IBOutlet private weak var searchBar: UISearchBar!
    @IBOutlet private weak var searchCollectionView: UICollectionView!

    private let disposeBag = DisposeBag()
    var viewModel: SearchViewModel!

    override func viewDidLoad() {
        super.viewDidLoad()
        configView()
        hideKeyboardWhenTappedAround()
        
        searchCollectionView.delegate = self
    }

    private func configView() {
        self.navigationItem.title = StringGen.searchTitle
        searchBar.customizeView()
        self.searchCollectionView.register(cellType: AnimeCollectionViewCell.self)
    }

    func bindViewModel() {
        let loadTrigger = Driver.just(())

        let input = SearchViewModel.Input(
            load: loadTrigger,
            keyword: searchBar.searchTextField.rx.text.orEmpty.asDriver(),
            searchTrigger: searchBar.rx.searchButtonClicked.asDriver()
        )

        let output = viewModel.transform(input, disposeBag: disposeBag)

        output.searchResult
            .drive(searchCollectionView.rx.items) { collection, row, element in
                let indexPath = IndexPath(row: row, section: 0)
                let cell: AnimeCollectionViewCell = collection.dequeueReusableCell(for: indexPath)
                cell.configCell(anime: element)
                return cell
            }
            .disposed(by: disposeBag)

        output.isSearching
            .drive(rx.isLoading)
            .disposed(by: disposeBag)
    }
}

extension SearchViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

        return CGSize(width: (searchCollectionView.frame.width - Constant.Size.paddingHorizontal * 2) / Constant.Number.cellInRow, height: Constant.Size.animeCellHeight)
    }
}

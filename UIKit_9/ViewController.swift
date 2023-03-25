//
//  ViewController.swift
//  UIKit_9
//
//  Created by Roman Korobskoy on 25.03.2023.
//

import UIKit

class ViewController: UIViewController {
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 20
        layout.sectionInset = .init(
            top: .zero,
            left: 20,
            bottom: .zero,
            right: 20
        )
        let collectionView = UICollectionView(
            frame: .zero,
            collectionViewLayout: layout
        )
        collectionView.backgroundColor = .clear

        collectionView.showsVerticalScrollIndicator = false
        collectionView.showsHorizontalScrollIndicator = false

        collectionView.delegate = self
        collectionView.dataSource = self

        collectionView.register(
            UICollectionViewCell.self,
            forCellWithReuseIdentifier: "Cell"
        )
        return collectionView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
}

private extension ViewController {
    func setupView() {
        navigationController?.navigationBar.prefersLargeTitles = true
        view.backgroundColor = .white
        navigationItem.title = "Collection"
//        collectionView.frame = .init(x: 0, y: view.center.y / 2,
//                                     width: view.frame.width, height: 400)
        collectionView.frame = view.bounds
        view.addSubview(collectionView)
    }
}

extension ViewController: UICollectionViewDataSource {
    func collectionView(
        _ collectionView: UICollectionView,
        numberOfItemsInSection section: Int
    ) -> Int {
        10
    }

    func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: "Cell",
            for: indexPath
        )
        cell.backgroundColor = .systemBlue.withAlphaComponent(0.1)
        cell.layer.cornerRadius = 10
        return cell
    }
}

extension ViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath
    ) -> CGSize {
        let widthSize: CGFloat = view.frame.width - 50
        let heightSize: CGFloat = collectionView.frame.height / 2
        return CGSize(width: widthSize, height: heightSize)
    }

    func scrollViewWillEndDragging(
        _ scrollView: UIScrollView,
        withVelocity velocity: CGPoint,
        targetContentOffset: UnsafeMutablePointer<CGPoint>
    ) {
        let itemWidth: CGFloat = view.frame.width - 50

        let cellWidth = itemWidth + 20 // 20 = layout.minimumLineSpacing
        let targetXContentOffset = targetContentOffset.pointee.x / cellWidth

        // -20 для отображения прошлой ячейки
        targetContentOffset.pointee.x = round(targetXContentOffset) * cellWidth - 20
    }
}

// MARK: - Previews
#if canImport(SwiftUI) && DEBUG
import SwiftUI

struct UIViewControllerPreview<ViewController: UIViewController>: UIViewControllerRepresentable {


    let viewController: ViewController

    init(_ builder: @escaping () -> ViewController) {
        viewController = builder()
    }

    // MARK: - UIViewControllerRepresentable
    func makeUIViewController(context: Context) -> ViewController {
        viewController
    }

    func updateUIViewController(_ uiViewController: ViewController, context: Context) {}
}
#endif

struct BestInClassPreviews_Previews: PreviewProvider {
    static var previews: some View {
        UIViewControllerPreview {
            // Return whatever controller you want to preview
            let vc = ViewController()
            let nav = UINavigationController(rootViewController: vc)
            return nav
        }
    }
}

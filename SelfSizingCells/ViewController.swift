//
//  ViewController.swift
//  SelfSizingCells
//
//  Created by Leafly on 9/7/21.
//

import UIKit

class ViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    @IBOutlet private var collectionView: UICollectionView!

    private var data: [String] = [
        "1. Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.",
        "2. Arcu cursus vitae congue mauris. Aenean sed adipiscing diam donec adipiscing. Lectus sit amet est placerat in egestas erat imperdiet. Tortor vitae purus faucibus ornare. Nulla at volutpat diam ut venenatis. Tristique sollicitudin nibh sit amet commodo nulla facilisi nullam. Lacus vel facilisis volutpat est velit egestas. Platea dictumst vestibulum rhoncus est pellentesque. Dignissim convallis aenean et tortor at risus viverra adipiscing at. Elementum sagittis vitae et leo.",
        "3. Adipiscing elit ut aliquam purus sit amet luctus venenatis. Gravida cum sociis natoque penatibus et magnis. Urna duis convallis convallis tellus id interdum velit laoreet id. Sed viverra tellus in hac habitasse platea dictumst vestibulum",
        "4. Elementum nisi quis eleifend quam",
        "5. Elementum nibh tellus molestie nunc non. Diam phasellus vestibulum lorem sed risus ultricies tristique nulla. Magna sit amet purus gravida quis blandit turpis cursus in. Arcu bibendum at varius vel pharetra vel turpis nunc. Sit amet commodo nulla facilisi. Nisl rhoncus mattis rhoncus urna. Commodo nulla facilisi nullam vehicula ipsum a arcu cursus vitae. Vitae nunc sed velit dignissim sodales ut eu. Et malesuada fames ac turpis egestas maecenas pharetra. Proin sagittis nisl rhoncus mattis rhoncus urna neque viverra justo. Maecenas accumsan lacus vel facilisis volutpat est velit egestas. Aliquam ut porttitor leo a diam sollicitudin tempor. Vulputate mi sit amet mauris commodo quis imperdiet. Feugiat sed lectus vestibulum mattis ullamcorper velit sed ullamcorper. Interdum consectetur libero id faucibus nisl tincidunt eget. Nunc eget lorem dolor sed. Pretium quam vulputate dignissim suspendisse in est.",
        "6. Sollicitudin ac orci phasellus egestas tellus rutrum tellus. Vitae congue mauris rhoncus aenean vel elit scelerisque mauris pellentesque. Donec et odio pellentesque diam volutpat. Sed blandit libero volutpat sed cras ornare arcu. Consectetur libero id faucibus nisl. Nunc mi ipsum faucibus vitae aliquet nec ullamcorper sit amet. Nulla pellentesque dignissim enim sit amet venenatis. Ut morbi tincidunt augue interdum. Ullamcorper sit amet risus nullam eget felis. Nec ultrices dui sapien eget mi proin sed libero enim. Lacus vel facilisis volutpat est velit egestas dui id. Vulputate ut pharetra sit amet aliquam id. Blandit cursus risus at ultrices mi tempus imperdiet nulla malesuada. Tellus at urna condimentum mattis pellentesque id nibh.",
        "7. Egestas purus viverra accumsan in nisl nisi scelerisque. Morbi tincidunt ornare massa eget egestas. Enim neque volutpat ac tincidunt vitae semper quis lectus nulla. Faucibus ornare suspendisse sed nisi. Velit laoreet id donec ultrices tincidunt"
    ]

    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.dataSource = self
        collectionView.delegate = self
    }

    // MARK: - Data source

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return data.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CustomCell", for: indexPath)
        if let cell = cell as? CustomCell {
            cell.layer.borderWidth = 1
            cell.layer.borderColor = UIColor.red.cgColor
            cell.backgroundColor = UIColor.random().withAlphaComponent(0.2)
            cell.label.text = data[indexPath.item]
        }
        return cell
    }

    // MARK: - Delegate

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.reloadItems(at: [indexPath])
    }
}

class CustomCell: UICollectionViewCell {
    @IBOutlet var label: UILabel!

    override func preferredLayoutAttributesFitting(_ layoutAttributes: UICollectionViewLayoutAttributes) -> UICollectionViewLayoutAttributes {
        guard let collectionView = superview as? UICollectionView, let layout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout else {
            return super.preferredLayoutAttributesFitting(layoutAttributes)
        }
        let width = collectionView.frame.width - (layout.sectionInset.left + layout.sectionInset.right)
        let size = contentView.systemLayoutSizeFitting(CGSize(width: width, height: 0), withHorizontalFittingPriority: .required, verticalFittingPriority: .defaultLow)
        layoutAttributes.size = size
        return layoutAttributes
    }
}

extension CGFloat {
    static func random() -> CGFloat {
        return CGFloat(arc4random()) / CGFloat(UInt32.max)
    }
}

extension UIColor {
    static func random() -> UIColor {
        return UIColor(
           red:   .random(),
           green: .random(),
           blue:  .random(),
           alpha: 1.0
        )
    }
}

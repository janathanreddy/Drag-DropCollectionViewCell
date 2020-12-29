//
//  ViewController.swift
//  Drag&DropCollectionViewCell
//
//  Created by Janarthan Subburaj on 29/12/20.
//

import UIKit

class ViewController: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,UICollectionViewDropDelegate,UICollectionViewDragDelegate {
    
   
    @IBOutlet weak var collectionView: UICollectionView!

    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.dragInteractionEnabled = true
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let DragDropCell = collectionView.dequeueReusableCell(withReuseIdentifier: "DragDropCell", for: indexPath)
        if indexPath.row % 2 == 0{
            DragDropCell.backgroundColor = UIColor.systemPink
        }else{
            DragDropCell.backgroundColor = UIColor.systemOrange
        }
        return DragDropCell
    }
    
    func collectionView(_ collectionView: UICollectionView, performDropWith coordinator: UICollectionViewDropCoordinator) {
        if let indexPath = coordinator.destinationIndexPath{
            let items = coordinator.items
            if items.count == 1{
                let item = items.first
                let SourceIndexPath = item?.sourceIndexPath
                collectionView.performBatchUpdates({
                    collectionView.deleteItems(at: [SourceIndexPath!])
                    collectionView.insertItems(at: [indexPath])
                    
                }, completion: nil)
                coordinator.drop(items.first!.dragItem,toItemAt: indexPath)
            }
        }
    }
    func collectionView(_ collectionView: UICollectionView, dropSessionDidUpdate session: UIDropSession, withDestinationIndexPath destinationIndexPath: IndexPath?) -> UICollectionViewDropProposal {
        let ProPosal = UICollectionViewDropProposal(operation: UIDropOperation.move, intent: UICollectionViewDropProposal.Intent.insertAtDestinationIndexPath)
        return ProPosal
    }
    func collectionView(_ collectionView: UICollectionView, itemsForBeginning session: UIDragSession, at indexPath: IndexPath) -> [UIDragItem] {
        let MyItemProvider = NSItemProvider(object: "\(indexPath.row)" as NSString)
        let DragItem = UIDragItem(itemProvider: MyItemProvider)
        DragItem.localObject = indexPath.row
        return [DragItem]
    }
    
    
}


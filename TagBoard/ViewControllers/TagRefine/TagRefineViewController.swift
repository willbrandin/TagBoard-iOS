//
//  TagRefineViewController.swift
//  TagBoard
//
//  Created by Will Brandin on 4/1/20.
//  Copyright © 2020 Will Brandin. All rights reserved.
//

import UIKit

class TagRefineViewController: UIViewController {
    
    // MARK: - Properties
    
    private(set) var viewModel: TagRefineViewModel
    
    private let copyButton = UIButton(type: .system)
    
    private lazy var collectionView = UICollectionView(frame: .zero, collectionViewLayout: collectionLayout)
    
    private lazy var collectionLayout: AlignedCollectionViewFlowLayout = {
        let layout = AlignedCollectionViewFlowLayout(horizontalAlignment: .left, verticalAlignment: .top)
        layout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
        layout.sectionInset = UIEdgeInsets(top: 0, left: Style.Layout.margin, bottom: 0, right: Style.Layout.margin)
        return layout
    }()
    
    // MARK: - Initializer
    
    init(viewModel: TagRefineViewModel) {
        self.viewModel = viewModel
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    deinit {
        print("DEINIT - \(String(describing: self))")
    }
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = viewModel.title
        view.backgroundColor = .background
        navigationController?.navigationBar.prefersLargeTitles = true
        addCloseButton(image: .close)
        
        view.setMargins(top: Style.Layout.margin,
                        leading: Style.Layout.margin,
                        bottom: Style.Layout.marginXL,
                        trailing: Style.Layout.margin)

        setupCollectionView()
        setupCopyButton()
        subscribeToViewModel()
    }
    
    // MARK: - Private Methods
    
    private func subscribeToViewModel() {
        viewModel.onUpdateCount = { [weak self] count in
            self?.copyButton.setTitle("Copy \(count) Hashtags!", for: .normal)
        }
    }
    
    private func setupCollectionView() {
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.allowsMultipleSelection = true
        collectionView.backgroundColor = .background
        
        collectionView.register(ChipCollectionViewCell.self)
        
        view.addSubview(collectionView)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.pinToSuperview()
    }
    
    private func setupCopyButton() {
        view.addSubview(copyButton)
        copyButton.translatesAutoresizingMaskIntoConstraints = false
        copyButton.pinToBottomMargin()
        copyButton.pinToLeadingAndTrailingMargins()
        copyButton.heightAnchor.constraint(equalToConstant: Style.Layout.buttonHeight).isActive = true
        
        copyButton.layer.cornerRadius = 8.0
        copyButton.titleLabel?.font = Style.Font.headline
        copyButton.titleLabel?.textAlignment = .center
        copyButton.setTitleColor(.white, for: .normal)
        copyButton.backgroundColor = .primary
        copyButton.setTitle("Copy \(viewModel.selectedTags.count) Hashtags!", for: .normal)
        copyButton.addTarget(self, action: #selector(didTapCopy), for: .touchUpInside)
    }
    
    // MARK: - Actions
    
    @objc private func didTapCopy() {
        
    }
}

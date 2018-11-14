//
//  ViewController.swift
//  PageGuide
//
//  Created by Robin He on 11/10/18.
//  Copyright © 2018 Robin He. All rights reserved.
//

import LBTAComponents

class HomeController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout  {

    lazy var collectionView : UICollectionView = {
        
        let layout = UICollectionViewFlowLayout()
                layout.scrollDirection = .horizontal
                layout.minimumLineSpacing = 0
                let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
       
                cv.backgroundColor = .white
                cv.dataSource = self
                cv.delegate = self
                cv.isPagingEnabled = true
                return cv
        
    }()
    

    
    let pages : [PageModel] = {
        
        let page = PageModel(title:"Nike SB Dunk Diamond" ,message:"In 1998, Diamond Supply Co, was born as a skateboarding hardware line that would become one of the most revered skate and lifestyle brands two decades later. Led by founder Nicholas Tershay, Diamond Supply Co. has since stretched into multiple subcultures, including the sneaker world, with their 2005 take on the Nike SB Dunk Low, known as the “Diamond Dunk.” Now in 2018, the brand celebrates its 20th anniversary with three new iterations of the famed sneaker. " ,imageUrl: "diamond")
        
        let page1 = PageModel(title:"Behind the Story" ,message:"The idea behind the new designs was born last year during an appearance at ComplexCon where Diamond Supply Co. paid homage to the Diamond Dunk that started it all. “We built a mini ramp, a plexiglass mini ramp, and actually put shoes inside to pay homage to Nike SB and our original Diamond Dunk from 2005, and the Diamond Dunk 2013 high top” Tershay explained." ,imageUrl: "behind")
        return [page,page1]
    }()
    
    override func willTransition(to newCollection: UITraitCollection, with coordinator: UIViewControllerTransitionCoordinator) {
     collectionView.collectionViewLayout.invalidateLayout()
        
        let indexPath = IndexPath(item: pc.currentPage, section: 0)
        DispatchQueue.main.async {
            self.collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
        }
    }
    
    
    lazy var pc : UIPageControl = {
        
        let page = UIPageControl()
        page.pageIndicatorTintColor = .gray
        page.currentPageIndicatorTintColor = .orange
        page.numberOfPages = 3
        return page
    }()
    
    lazy var skipButton : UIButton = {
        let skip = UIButton(type: .system)
        skip.setTitle("Skip", for: .normal)
        skip.setTitleColor(UIColor.orange, for: .normal)
        skip.addTarget(self, action: #selector(clickSkip), for: .touchUpInside)
        return skip
        
        
    }()
    @objc func clickSkip(){
        loginSomeButtonDisappear()
        let lastIndexPath = IndexPath(item: pages.count, section: 0)
        collectionView.scrollToItem(at: lastIndexPath, at: .centeredHorizontally, animated: true)
        
    }
    
    lazy var nextButton : UIButton = {
        let next = UIButton(type: .system)
        next.setTitle("Next", for: .normal)
        next.setTitleColor(UIColor.orange, for: .normal)
        next.addTarget(self, action: #selector(clickSelect), for: .touchUpInside)
        return next
        
        
    }()
    
    @objc func clickSelect(){
        
        if pc.currentPage == pages.count {
            
            return
        }
        if pc.currentPage == pages.count-1 {
            loginSomeButtonDisappear()
        }
        let indexPath = IndexPath(item: pc.currentPage+1, section: 0)
        collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
        pc.currentPage += 1
        
    }
    
    func loginSomeButtonDisappear(){
        
        skipAnchor?.constant = -50
        nextAnchor?.constant = -50
        pc.currentPageIndicatorTintColor = .white
        pc.pageIndicatorTintColor = .white
        UIView.animate(withDuration: 0.5, delay: 0, options: .curveEaseOut, animations: {
            
            self.view.layoutIfNeeded()
        }, completion: nil)
    }
    
     func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        let pageNumber = targetContentOffset.pointee.x/view.frame.width
        pc.currentPage = Int(pageNumber)
        if pc.currentPage == pages.count {
            loginSomeButtonDisappear()
           
        }else {
            skipAnchor?.constant = 50
            nextAnchor?.constant = 50
            pc.pageIndicatorTintColor = .gray
            pc.currentPageIndicatorTintColor = .orange
            
        }
        
        
    }
    var pcAnchor : NSLayoutConstraint?
    var skipAnchor :NSLayoutConstraint?
    var nextAnchor :NSLayoutConstraint?

    override func viewDidLoad() {
        super.viewDidLoad()
        observeKeyBoardNotification()
        //Tap screen to observe
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(keyBoardEnd))
        collectionView.addGestureRecognizer(tapGesture)
        
        collectionView.backgroundColor = .white
        
        view.addSubview(collectionView)
        view.addSubview(pc)
        view.addSubview(skipButton)
        view.addSubview(nextButton)
     
       pc.anchor(nil, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 30)
        skipButton.anchor(view.topAnchor, left: view.leftAnchor, bottom: nil, right: nil, topConstant: 30, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 60, heightConstant: 50)
        skipAnchor = skipButton.anchorWithReturnAnchors(view.topAnchor, left: view.leftAnchor, bottom: nil, right: nil, topConstant: 30, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 60, heightConstant: 50)[0]

        nextButton.anchor(view.topAnchor, left: nil, bottom: nil, right: view.rightAnchor, topConstant: 30, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 60, heightConstant: 50)
        nextAnchor = nextButton.anchorWithReturnAnchors(view.topAnchor, left: nil, bottom: nil, right: view.rightAnchor, topConstant: 30, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 60, heightConstant: 50)[0]

       
          collectionView.anchor(view.topAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 0)
        
        collectionView.register(PageCell.self, forCellWithReuseIdentifier: "cellId")
        collectionView.register(LoginCell.self, forCellWithReuseIdentifier: "loginId")
        collectionView.isPagingEnabled = true
       
       
    }
    
     func observeKeyBoardNotification(){
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyBoardAppear), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyBoardEnd), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
   
    @objc func keyBoardAppear(){
        
        UIView.animate(withDuration: 0.5, delay: 0, options: .curveEaseOut, animations: {
            self.view.frame = CGRect(x: 0, y: -110, width: self.view.frame.width, height: self.view.frame.height)
        }, completion: nil)
        
    }
    
    @objc func keyBoardEnd(){
        
        view.endEditing(true)
        
        UIView.animate(withDuration: 0.5, delay: 0, options: .curveEaseOut, animations: {
            self.view.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height)
        }, completion: nil)
        
    }
     func scrollViewDidScroll(_ scrollView: UIScrollView) {
        view.endEditing(true)
        UIView.animate(withDuration: 0.5, delay: 0, options: .curveEaseOut, animations: {
            self.view.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height)
        }, completion: nil)
    }
    
     func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return pages.count+1
    }
    
    
     func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if indexPath.item == pages.count {
            let loginCell = collectionView.dequeueReusableCell(withReuseIdentifier: "loginId", for: indexPath)
            return loginCell
        }
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellId", for: indexPath) as! PageCell
        let indexPage = pages[indexPath.item]
        cell.page = indexPage
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: view.frame.height)
    }
}


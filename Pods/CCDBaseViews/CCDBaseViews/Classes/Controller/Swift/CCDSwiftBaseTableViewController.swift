//
//  CCDSwiftBaseTableViewController.swift
//  CCDOrder
//
//  Created by 谢添才 on 2018/1/20.
//

import Foundation
import CCDSwiftCore
import SnapKit
//次类用于查找资源 没有其他用处
internal let sourceRoot:SourceRoot = SourceRoot()
internal class SourceRoot:NSObject{}

open class CCDSwiftBaseTableViewController<T>: UIViewController, UITableViewDelegate, UITableViewDataSource {
    //如无分页不需处理 如有分页需要传递给请求
    open var pageIndex:Int = 1
    
    //tableview数据变化回调函数
    open func tableViewDataChange() {
        
    }
    
    //MARK: 网络请求接口 必须重载
    open func sendRequest() {
        
    }
    
    //MARK: 网络错误页面重试
    open func errorViewActionButtonTapped(){
        self.pageErrorView.isHidden = true
        self.sendFirstPageRequest()
    }
    
    
    open override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.clear
        self.tableView.backgroundColor = UIColor.clear
        
        view.addSubview(tableView)
        view.addSubview(customEmpty)
        view.addSubview(pageErrorView)
        self.tableView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        customEmpty.snp.makeConstraints { (make) in
            make.edges.equalTo(self.tableView)
        }
        pageErrorView.snp.makeConstraints { (make) in
            make.edges.equalTo(self.tableView)
        }
        customEmpty.isHidden = true
        
        if !needRrefreshWhenViewDidAppear {
            sendFirstPageRequest()
        }
    }
    
    open var needRrefreshWhenViewDidAppear:Bool = true
    open override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if needRrefreshWhenViewDidAppear {
            sendFirstPageRequest()
        }
    }
    
    
    open func addRefreshHeader() {
        self.tableView.ccd_AddRefreshHeader(withRefreshingTarget:self, selector:  #selector(sendFirstPageRequest))
    }
    open func addRefreshFooter() {
        self.tableView.ccd_AddRefreshFooter(withRefreshingTarget:self, selector:  #selector(sendNextPageRequest))
    }
    open func removeRefreshFooter() {
        self.tableView.ccd_RemoveRefreshFooter()
    }
    open func removeRefreshHeader() {
        self.tableView.ccd_RemoveRefreshFooter()
    }
    
    
    
    //处理新数据 接口调用后处理数据接口
    open func cheatNewData(_ newDataArr:[T]) {
        if pageIndex == 1{
            self.dataArr = newDataArr
            self.tableView.reloadData()
            self.endRefreshWithNoMoreData(newDataArr.count == 0)
        }
        else{
            let oldIndex = self.dataArr.count
            self.dataArr += newDataArr
            let addIndexArr:[IndexPath] = (0..<newDataArr.count).map{$0 + oldIndex}.map{IndexPath.init(row: $0, section: 0)}
            self.tableView.beginUpdates()
            self.tableView.insertRows(at: addIndexArr, with: .automatic)
            self.tableView.endUpdates()
            self.endRefreshWithNoMoreData(newDataArr.count == 0)

        }
    }
    
    //处理新数据 接口调用后处理错误接口
    open func cheatErrorMessage(_ errorMessage:String?) {
        if self.pageIndex == 1{
            self.dataArr.removeAll()
            self.tableView.reloadData()
            self.endRefreshWithNoMoreData(true)
            self.pageErrorView.isHidden = false
            self.customEmpty.isHidden = true
        }else{
            CCDSimpleTip.showSimpleToast(errorMessage ?? "")
            self.pageErrorView.isHidden = true
        }
    }
    
    @objc func sendFirstPageRequest() {
        self.pageIndex = 1
        sendRequest()
    }
    @objc func sendNextPageRequest() {
        self.pageIndex += 1
        sendRequest()
    }
    
    
    open func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    open func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.dataArr.count
    }
    
    open func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    }
    
    //必须重载
    open func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        return UITableViewCell()
    }
    
    
    open lazy var pageErrorView:UIView! = {
        let v = UIView()
        let errorView = CCDPageRequestErrorView.init(frame: CGRect.init(x: 0, y: 0, width: 0, height: 0))
        errorView.iconImageView.image = sourceRoot.findImageFromResourcesBundle(name: "serverError")
        v.isHidden = true
        v.addSubview(errorView)
        errorView.actionButtonTappedBlock = { [unowned self]  in
            self.errorViewActionButtonTapped()
        }
        errorView.snp.makeConstraints({ (make) in
            make.center.equalToSuperview()
        })
        return v
    }()
    
    open lazy var customEmpty:UIView! = {
        let v = UIView()
        var iv:UIImageView = UIImageView()
        iv.image = sourceRoot.findImageFromResourcesBundle(name: "empty_e_collection")
        var lb:UILabel = UILabel()
        lb.numberOfLines = 0
        lb.text = sourceRoot.LocalizedString("noDate", comment: "暂无数据")
        lb.textAlignment = .left
        lb.textColor =  UIColor.white
        lb.font =  UIFont.CustomFontOfSize(font: 14)
        v.addSubview(iv)
        v.addSubview(lb)
        iv.snp.makeConstraints({ (make) in
            make.centerX.equalToSuperview()
            make.top.equalTo(UIScreen.main.bounds.height * 0.2)
        })
        lb.snp.makeConstraints({ (make) in
            make.centerX.equalToSuperview()
            make.top.equalTo(iv.snp.bottom).offset(10)
            make.width.equalTo(UIScreen.main.bounds.width - 28*2)
        })
        return v
    }()
    
    open lazy var tableView:UITableView = {
        let tv = UITableView()
        tv.delegate = self
        tv.dataSource = self
        if #available(iOS 11.0, *) {
            tv.contentInsetAdjustmentBehavior = .never
        }
        tv.estimatedSectionHeaderHeight = 0
        tv.estimatedSectionFooterHeight = 0
        tv.estimatedRowHeight = 0
        return tv
    }()
    
    open var dataArr:[T] = []{
        didSet{
            self.customEmpty.isHidden = dataArr.count != 0
            self.pageErrorView.isHidden = true
            self.tableViewDataChange()
        }
    }
    
    
    
    open override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    open func endRefreshWithNoMoreData(_ noMore:Bool) {
        self.tableView.ccd_EndRefreshWithNoMoreData(noMore)
    }
    
}

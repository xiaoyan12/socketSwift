//
//  ViewController.swift
//  01socket套接字
//
//  Created by qingyun on 16/7/1.
//  Copyright © 2016年 河南青云信息技术有限公司. All rights reserved.
//

import UIKit
import CocoaAsyncSocket
class ViewController: UIViewController,GCDAsyncSocketDelegate{
    @IBOutlet weak var ipTf:UITextField!
    @IBOutlet weak var portTf:UITextField!
    @IBOutlet weak var contentTf:UITextField!
    
    var syncSocket:GCDAsyncSocket!=nil
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        //初始化套接字对象
        syncSocket=GCDAsyncSocket(delegate: self,delegateQueue: dispatch_get_main_queue())
        
    }
    //连接到服务器
    @IBAction func connectBtn(sender:AnyObject){
        let strIp:String!=ipTf.text
        let strPort=portTf.text
        let nPort:UInt16!=UInt16(strPort!)
        //建立链接
        do{
            try syncSocket.connectToHost(strIp, onPort: nPort)
        } catch let error as NSError{
            print("连接出现错误\(error)")
        }
    }
    //链接到主机响应的方法
    func socket(sock: GCDAsyncSocket!, didConnectToUrl url: NSURL!) {
        print("连接到主机成功")
    }
    //向服务器发送数据成功响应的方法
    func socket(sock: GCDAsyncSocket!, didWriteDataWithTag tag: Int) {
        print("向服务器发送数据成功 \(tag)")
    }
    //读取从服务器发来的数据响应的方法
    func socket(sock: GCDAsyncSocket!, didReadData data: NSData!, withTag tag: Int) {
        print("读取从服务器发来的数据")
        
    }
    //发送
    @IBAction func sendBtn(sender:AnyObject){
        let dData=contentTf.text?.dataUsingEncoding(NSUTF8StringEncoding)!
        syncSocket.writeData(dData, withTimeout: -1, tag: 1)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}


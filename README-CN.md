# WXCycleScrollView

### 类似百度外卖首页带有波纹的自动轮播
### [English Doc](https://github.com/WelkinXie/WXCycleScrollView/blob/master/README.md)

![()](http://7xneqd.com1.z0.glb.clouddn.com/cycleScroll2.gif)

## 使用方法
1. 复制 **WXCycleScrollView** 文件夹到你的工程目录。
2. 初始化并添加到视图中。

		// 显示网络图片:
		init(frame: CGRect, imageURLs: Array<String>, placeHolder: UIImage?)
		
		// 显示本地图片:
		init(frame: CGRect, imageNames: Array<String>)
		
3. 如果你想在用户点击图片时得到回调，遵从 **WXCycleScrollViewDelegate** , 设置 **delegate** , 并实现以下方法。

		func cycleScrollViewDidTapped(cycleScrollView: WXCycleScrollView, index: Int)
		
## 个性化
* 设置自动轮播时间:

		self.cycleScrollView?.autoScrollTimeInterval = 4;
		
* 设置波纹的颜色:

        self.cycleScrollView?.waveColor = UIColor.lightGrayColor()
       
* 如果不需要波纹的话，也行:

        self.cycleScrollView?.needWave = false
        
## 想单独使用其中的波纹?
波纹已封装好，可以从这里获取。 [WXWaveView](https://github.com/WelkinXie/WXWaveView).

## 许可协议
**WXCycleScrollView** 在 [**MIT License**](https://github.com/WelkinXie/WXCycleScrollView/blob/master/LICENSE) 许可协议下发布。
# WXCycleScrollView

### Auto Scroll View with silk wave on it!
### [中文说明](https://github.com/WelkinXie/WXCycleScrollView/blob/master/README-CN.md)

![()](http://7xneqd.com1.z0.glb.clouddn.com/cycleScroll.gif)

## Usage
1. Copy the **WXCycleScrollView** folder and the files in it to your project.
2. Initialize it and add it to where you want. There are two ways:

		// Show Web Images:
		init(frame: CGRect, imageURLs: Array<String>, placeHolder: UIImage?)
		
		// Show Local Images:
		init(frame: CGRect, imageNames: Array<String>)
		
3. Confrom to **WXCycleScrollViewDelegate** , set the **delegate** , and implement the method below if you want callback when user tap on the image.

		func cycleScrollViewDidTapped(cycleScrollView: WXCycleScrollView, index: Int)
		
## Customization
* Set the auto scroll time interval:

		self.cycleScrollView?.autoScrollTimeInterval = 4;
		
* Set the wave's color:

        self.cycleScrollView?.waveColor = UIColor.lightGrayColor()
       
* If you **do not** want the wave:

        self.cycleScrollView?.needWave = false
        
## Want the Silk Wave?
The wave is seperated as a tool kit. Get it here. [WXWaveView](https://github.com/WelkinXie/WXWaveView).

## Thanks
**WXCycleScrollView** is inspired by [KYWaterWaveView](https://github.com/KittenYang/KYWaterWaveView). Thanks KittenYang and his contributions.

## License
**WXCycleScrollView** is released under [**MIT License**](https://github.com/WelkinXie/WXCycleScrollView/blob/master/LICENSE).
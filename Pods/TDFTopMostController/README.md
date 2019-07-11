# TDFTopMostController



### 使用方式

一行命令调用 `[UIViewController tdf_topMostController]`

如果遇到有些情况下没有获取正确的VC，例如一个containerVC包含若干个子VC，这种情况下topMostController只会获得containerVC

这个时候只需要让containerVC实现`TDFTopMostControllerProtocol`,返回期望的VC就行了

```objc
//ContainerVC.h
@interface ContainerVC <TDFTopMostControllerProtocol>
@end

//ContainerVC
@implementation ContainerVC (TDFTopMostController)

- (UIViewController *)tdf_visibleViewController {
    return self.selectedViewController;
}

@end
```

## Author

huanghou, huanghou@2dfire.com

## License

TDFTopMostController is available under the MIT license. See the LICENSE file for more info.

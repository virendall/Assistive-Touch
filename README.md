# Assistive-Touch
You can create your own Assistive Touch

* Xcode 8
* Swift 3.0

#### Manually

Simply drag **AssistiveTouch** in your project file & add below code in your didlaunchwithoptions method

```swift
DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + Double(Int64(3 * Double(NSEC_PER_SEC))) / Double(NSEC_PER_SEC), execute: {() -> Void in
            AssistiveTouch.instance.canDrag = true
            AssistiveTouch.instance.showAssistiveTouch()
        })
```
<p align="center">
  <img src="https://github.com/virendall/Assistive-Touch/blob/master/images/Simulator%20Screen%20Shot%2030-Dec-2016%2C%2010.38.03%20AM.png" width="150"/>
  <img src="https://github.com/virendall/Assistive-Touch/blob/master/images/Simulator%20Screen%20Shot%2030-Dec-2016%2C%2010.38.07%20AM.png" width="150"/>
</p>

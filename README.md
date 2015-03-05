# TZkeyboardPop

TZKeyboardPop allow user to pop a keyboard with a UITextField dynamically attached to it.

### Version
0.0.1

### Installation

- If you are using Cocoapods, insert the line below into your podfile
- ```sh
    pod 'TZKeyboardPop', '~> 0.0.1'
```
OR manually import TZKeyboardPop.h, TZKeyboardPop.m into your project

- You need to import wherever you wan't to pop the keyboard

- ```objective-c 
#import <TZKeyboardPop.h>
```
- Declare
- ```objective-c
@property (weak, nonatomic) TZKeyboard *customKeyboard;
```
- Don't forget to add TZKeyboardDelegate in your viewController
- Then you init in your viewdidload
- ```objective-c
_customKeyboard = [[TZKeyboard alloc] initWithView:self.view];
    customKeyboard.delegate = self;
```
- And then finally :
- ```objective-c
[_customKeyboard showKeyboard];
```

### Delegates
```objective-c
- (void) didShowKeyboard;
- (void) didCancelKeyboard;
- (void) didReturnKeyPressedWithText:(NSString *)str;
```

### Development

Want to contribute? Great! Do not hesitate to comment my code ! I will try my best to answer your questions !


### Todo's

 - ~~Put in cocoapods~~
 - Optimizing the code
 - Add new method to customize keyboard + textfield

License
----
MIT


**Free Software, Hell Yeah!**

[john gruber]:http://daringfireball.net/
[@thomasfuchs]:http://twitter.com/thomasfuchs
[1]:http://daringfireball.net/projects/markdown/
[marked]:https://github.com/chjj/marked
[Ace Editor]:http://ace.ajax.org
[node.js]:http://nodejs.org
[Twitter Bootstrap]:http://twitter.github.com/bootstrap/
[keymaster.js]:https://github.com/madrobby/keymaster
[jQuery]:http://jquery.com
[@tjholowaychuk]:http://twitter.com/tjholowaychuk
[express]:http://expressjs.com
[AngularJS]:http://angularjs.org
[Gulp]:http://gulpjs.com

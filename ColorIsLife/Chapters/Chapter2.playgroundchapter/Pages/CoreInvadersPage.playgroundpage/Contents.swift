//#-hidden-code
//
//  See LICENSE folder for this template’s licensing information.
//
//  Abstract:
//  The Swift file containing the source code edited by the user of this playground book.
import PlaygroundSupport
let page = PlaygroundPage.current
let proxy = page.liveView as! PlaygroundRemoteLiveViewProxy
func coreInvaders() {
    proxy.send(.string(colorQuark))
}
//#-end-hidden-code
/*:
 # Core Invaders
 Oh no! now things get tough. **Hordes of gluons** are attacking our quark.
 They want to make them change color by **shooting them charges of color**.
 Our hero will not last long, he has been fighting alone for a long time, you are the only one that can save him from this situation.
 * Experiment:
 Here you can set how much **difficult** must to be the game (you need to write a number),
 and you need to call the function to setup the scene, write: **coreInvaders()**  When you are ready **Tap "Run My Code" to start!**
 */
//#-code-completion(everything, hide)
//#-code-completion(identifier, show, red, green, blue)
var colorQuark: String = /*#-editable-code Choose your color*/" "/*#-end-editable-code*/
//#-code-completion(everything, hide)
//#-code-completion(identifier, show, coreInvaders())
/*#-editable-code Here coreInvaders()*/ /*#-end-editable-code*/

/*:
 - Note:
To have a better experience it is raccomended to use your device in **portrait mode** and in **full screen**.
 */

//: Another game is waiting for you in the [nextPage](@next).

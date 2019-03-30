//#-hidden-code
//
//  See LICENSE folder for this template’s licensing information.
//
//  Abstract:
//  The Swift file containing the source code edited by the user of this playground book.
import PlaygroundSupport
let page = PlaygroundPage.current
let proxy = page.liveView as! PlaygroundRemoteLiveViewProxy
func saveBQuark() {
    proxy.send(.integer(difficultValue))
}
//#-end-hidden-code
/*:
 # Save the Blue Quark
 Here we go again... this time we have a quark in difficulty.
 Now some red-yellow gluons are falling down from the sky and they want to make it red!
 It is a disaster because our Quark likes his beautiful **blue dress** and he don’t want to change it.
 You can help him to escape from the gluons to the right and left trying to avoid the falling gluons.
 * Experiment:
 Here you can set how much **difficult** must to be the game (you need to write a number),
 and you need to call the function to setup the scene, write: **saveBQuark()**
 When you are ready **Tap "Run My Code" to start!**
 */
var difficultValue: Int = /*#-editable-code set difficult*/0/*#-end-editable-code*/
//#-code-completion(everything, hide)
//#-code-completion(identifier, show, saveBQuark())
/*#-editable-code Here saveBQuark()*/ /*#-end-editable-code*/
//: You have almost completed this playground, on the next page you will find the conclusions and a summary. [nextPage](@next).


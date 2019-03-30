//#-hidden-code
//
//  See LICENSE folder for this template’s licensing information.
//
//  Abstract:
//  The Swift file containing the source code edited by the user of this playground book.

import PlaygroundSupport
let page = PlaygroundPage.current

let proxy = page.liveView as! PlaygroundRemoteLiveViewProxy
func setupScene() {
    proxy.send(.boolean(gluonsVisibility))
}
func stopScene() {
    proxy.send(.boolean(gluonsVisibility))
}
//#-end-hidden-code
/*:
 # Strong Friendship
 
 Quarks weren't the only ones with this characteristic, even some friends of the quarks, called **Gluons**,
 possessed this property. In fact the gluons could even have a **charge of color** or, alternatively, an **anti-color charge**.
 One day it was discovered that the gluons managed to keep the quarks **attached to each other**,
 thanks to their **strong strength**. Also the gluons could feel attracted to the quarks as their distance increased.
 In short, they were **inseparable friends**. Unfortunately sometimes it happens that such strong friendships can end,
 and even quarks and gluons can separate.
 Do you know what quarks do when they quarrel with gluons? They **change their color**.
 And do you know what the gluons do instead? They look for **another quark** to get to know and make them change color.
 
 * Experiment:
 Now I will show you the gluons in the Scene. It's very simple, you just need to set **true** the variable below.
 
 */
//#-code-completion(everything, hide)
//#-code-completion(identifier, show, true, false)
var gluonsVisibility: Bool = /*#-editable-code Write here*/false/*#-end-editable-code*/
/*:
 * Experiment:
 Now you need to call the function to setup the scene, write: **setupScene()**
 When you are ready **Tap "Run My Code" to start!**
 */
//#-code-completion(everything, hide)
//#-code-completion(identifier, show, setupScene())
/*#-editable-code Here setupScene()*/ /*#-end-editable-code*/
//: Quarks, Gluons, colors stop with theory. It's ACT Time: [nextPage](AnimationPage).


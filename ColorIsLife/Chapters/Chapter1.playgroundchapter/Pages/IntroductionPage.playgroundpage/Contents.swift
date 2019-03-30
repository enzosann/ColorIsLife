//#-hidden-code
//
//  See LICENSE folder for this template’s licensing information.
//
//  Abstract:
//  The Swift file containing the source code edited by the user of this playground book.


import PlaygroundSupport
let page = PlaygroundPage.current

let proxy = page.liveView as! PlaygroundRemoteLiveViewProxy
var control: Bool = false
func setupQuarks() {
    proxy.send(.boolean(control))
}
func stopQuarks() {
    proxy.send(.boolean(control))
}

//#-end-hidden-code
/*:
 # Introduction
 
 Once upon a time there were very small elementary particles, practically invisible to the human eye,
 these particles were called **Quarks**. The quarks were really special particles: they had a **color charge**!
 This characteristic made them special and distinguishable from other particles.
 They could be: **Red, Green** and **Blue**.

 There were also the **anti-quarks**, that carried three types of **anti-color**:
 * Cyan
 * Magenta
 * Yellow

 * Experiment:
 To start our jorney you need to declare these **three** **quarks** as **red, green** and **blue**.
 
 */
//#-code-completion(everything, hide)
//#-code-completion(identifier, show, red, green, blue)
var quarkRed: String = /*#-editable-code Here red*/" "/*#-end-editable-code*/
var quarkGreen: String = /*#-editable-code Here green*/" "/*#-end-editable-code*/
var quarkBlue: String = /*#-editable-code Here blue*/" "/*#-end-editable-code*/
//#-hidden-code
if quarkRed == "red" && quarkGreen == "green" && quarkBlue == "blue" {
    control = true
}
//#-end-hidden-code
/*:
 * Experiment:
 Now you need to call the function to setup the scene, When you are ready **Tap "Run My Code" to start!**
 */
setupQuarks()
//: Whenever you're ready, let's move to next step of this journey [nextPage](StrongFriendshipPage).


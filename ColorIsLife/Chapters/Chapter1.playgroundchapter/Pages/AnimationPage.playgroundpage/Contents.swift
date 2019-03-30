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
func setupScene() {
    proxy.send(.boolean(control))
}
func stopScene() {
    proxy.send(.boolean(control))
}
//#-end-hidden-code
/*:
 # ACT Time!
 
 Quarks, Gluons, Color charge, anti-color charge and strong strength. These are the keywords we have met in the previous pages.
 Now with a few simple commands I will let you participate in the life of quarks and gluons.
 You can choose a quark and change its color and, consequently, **move the gluons** as you want,
 always trying to **balance** the **charge of color**.
 I am sure you are an expert by now and you will soon be able to rebalance the charges of color.
 
 * Experiment:
 To start our jorney you need to declare these **three** variable as **red, green** and **blue**.
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
 Now you need to call the function to setup the scene, write: **setupScene()**
 When you are ready **Tap "Run My Code" to start!**
 */
//#-code-completion(everything, hide)
//#-code-completion(identifier, show, setupScene())
/*#-editable-code Here setupScene()*/ /*#-end-editable-code*/
//: To enjoy what you have just learned you can go forward and discovery a **big surprise...**

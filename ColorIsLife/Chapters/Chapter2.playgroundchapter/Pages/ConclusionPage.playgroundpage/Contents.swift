//#-hidden-code
//
//  See LICENSE folder for this template’s licensing information.
//
//  Abstract:
//  The Swift file containing the source code edited by the user of this playground book.
import PlaygroundSupport
let page = PlaygroundPage.current
let proxy = page.liveView as! PlaygroundRemoteLiveViewProxy
func greetingsStart() {
    proxy.send(.string(greetings))
}
//#-end-hidden-code
/*:
 # Conclusion
 Summing up in this Playground Book we have read terms such as:
 **Quarks, Gluons, Color Charge, Anti-Color Charge** and **Strong Strength** and we treated them like friends
 who quarrel and change color.
 We have treated the strong force as the will of the gluons to not separate from the quarks
 and the color charge as a way, of the quarks, to externally manifest the fact of having changed state.
 Everything we have talked about so far is actually **Physics**, more precisely **Quantum Physics**.
 Also we have seen, just a little bit, **Quantum Chromodynamics (QCD)**.
 This Playground Book tries to show that with the right words we can **teach children** the subject that are more complicated,
 like Physics, from the first years of their life.
 */
/*:
 * Experiment:
 It's Greetings Time! write a word and call **greetingsStart()**
 When you are ready **Tap "Run My Code" to start!**
 */
//#-code-completion(everything, hide)
//#-code-completion(identifier, show, true, false)
var greetings: String = /*#-editable-code Here greetings*/" "/*#-end-editable-code*/
//#-code-completion(everything, hide)
//#-code-completion(identifier, show, greetingsStart())
/*#-editable-code Here greetingsStart()*/ /*#-end-editable-code*/
//: You completed this Playground Book, I hope that you like this, **Thanks for your attention, VS**.


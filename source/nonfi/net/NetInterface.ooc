import os/Process, structs/ArrayList
import Probe

NetInterface: class {
    
    name: String
    up : Bool
    
    upListeners: ArrayList<Listener>
    downListeners: ArrayList<Listener>
    
    init: func(=name) {
        upListeners = ArrayList<Pointer> new()
        downListeners = ArrayList<Pointer> new()
    }
    
    bringUp: func -> Int {
        result := Process new(["ifconfig", name, "up"] as ArrayList<String>) execute()
        if(result == 0) isUp() // update up state
        result
    }
    
    bringDown: func -> Int {
        result := Process new(["ifconfig", name, "down"] as ArrayList<String>) execute()
        if(result == 0) isUp() // update up state
        result
    }
    
    toggle: func -> Int {
        if(isUp()) {
            bringDown()
        } else {
            bringUp()
        }
    }
    
    isUp: func -> Bool {
        for(upName in Probe getUpIfNames()) {
            if(upName == this name) {
                if(!up) {
                    up = true
                    onUp()
                }
                return up
            }
        }
        if(up) {
            up = false
            onDown()
        }
        return up
    }
    
    onUp: func {
        for(l in upListeners) {
            f: Func = l callback
            f(this, l userData)
        }
    }
    
    onDown: func {
        for(l in downListeners) {
            f: Func = l callback
            f(this, l userData)
        }
    }
    
    addUpListener: func (callback: Func, userData: Pointer) {
        upListeners add(Listener new(callback, userData))
    }
    
    addDownListener: func (callback: Func, userData: Pointer) {
        downListeners add(Listener new(callback, userData))
    }
    
    getName: func -> String { name }
    
}

Listener: class {
    
    callback: Func
    userData: Pointer
    
    init: func (=callback, =userData) {}
    
}

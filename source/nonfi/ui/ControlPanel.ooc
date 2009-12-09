use gtk

import gtk/[Gtk, Window, Button, VBox, HBox, Label]

import os/Process
import structs/[ArrayList, List]
import ../net/[NetInterface]

ControlPanel: class {
    
    win : Window
    ifaces: List<NetInterface>
    
    init: func (=ifaces) {
        
        win = Window new("nonfi")
        win setUSize(400, 200) .connect("delete_event", exit)
        vbox := VBox new(false, 5)
        win add(vbox)
         
        for(iface in ifaces) {
            hbox := HBox new(true, 5)
            vbox packStart(hbox)
            
            button := Button new("toggle")
            button connect("clicked", func (b: Button, iface: NetInterface) {
                if(iface isUp()) {
                    "Trying to bring down %s...\n" format(iface getName()) print()
                    if(iface bringDown() == 0) {
                        printf("Success!\n")
                    } else {
                        printf("Fail!\n")
                    }
                } else {
                    "Trying to bring up %s...\n" format(iface getName()) print()
                    if(iface bringUp() == 0) {
                        printf("Success!\n")
                    } else {
                        printf("Fail!\n")
                    }
                }
            }, iface)
            
            hbox packStart(Label new(iface getName()))
            hbox packStart(button)
            label := Label new(iface isUp() ? "up" : "down")
            hbox packStart(label)
            
            iface addUpListener(func (iface: NetInterface, label: Label) {
                Process new(["notify-send", "nonfi", "%s is now up!" format(iface name)] as ArrayList<String>) execute()
                label setText("up")
            }, label)
            
            iface addDownListener(func (iface: NetInterface, label: Label) {
                Process new(["notify-send", "nonfi", "%s is now down!" format(iface name)] as ArrayList<String>) execute()
                label setText("down")
            }, label)
        }
         
        win showAll()
        Gtk main()
        
    }
    
}
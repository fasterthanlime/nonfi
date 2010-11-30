
use gtk, gdk

import gdk/[Event]
import gtk/[Dialog, Entry, Label, VBox, _GObject]
import net/[Network]
import os/Process

EnterPassphrase: class {
    
    entry: Entry
    dialog: Dialog
    network: Network
    
    init: func (=network) {
        dialog = Dialog new(network essid, null, 0,
            GTK_STOCK_OK, GTK_RESPONSE_ACCEPT, GTK_STOCK_CANCEL, GTK_RESPONSE_REJECT, null)
        
        label := Label new("Enter %s passphrase to connect to %s" format(network encrypt, network essid))
        dialog@ vbox add(label)
        
        entry = Entry new()
        entry setVisibility(false)
        dialog@ vbox add(entry)
        entry connectNaked("key-press-event", this, keyPressed)
        
        dialog connect("response", || connect())
        dialog showAll()
    }
    
    keyPressed: func (kev: EventKey*) -> Bool {
        //"Pressed key '%c', ie. '%d'" printfln(kev@ keyval, kev@ keyval)
        if(kev@ keyval == 65293) {
            connect()
        }
        false
    }
    
    connect: func {
        passphrase := entry getText()
        dialog destroy()

        if(!passphrase) return
        
        "\nOkay, here's the wpa_supplicant config:\n" println()
        Process new(["wpa_passphrase", network essid, passphrase]) getOutput() println()
    }
    
}

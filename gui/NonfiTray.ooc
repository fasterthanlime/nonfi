use gtk

import gtk/[Gtk, StatusIcon]

NonfiTray: class {
    
    icon: StatusIcon
    
    init: func {
        icon = StatusIcon new("resources/nonfi.png")
        icon connectNaked("activate",   this, activate)
        icon connectNaked("popup-menu", this, activate)
        
        Gtk main()
    }
    
    activate: func {
        "Activated!" println()
        
    }
    
}

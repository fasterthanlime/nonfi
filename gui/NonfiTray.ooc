use gtk

import gtk/[Gtk, StatusIcon, Menu]

NonfiTray: class {
    
    icon: StatusIcon
    
    menu: Menu
    menubar: MenuBar
    
    init: func {
        icon = StatusIcon new("resources/nonfi.png")
        icon connectNaked("activate",   this, activate)
        icon connectNaked("popup-menu", this, activate)
        
        menu = Menu new()
        rootMenu := MenuItem new("Root Menu")
        rootMenu setSubMenu(menu)
        rootMenu show()
        
        for(i in 1..6) {
            network := MenuItem new("network %d" format(i))
            network show()
            menu append(network)
        }
        
        quit := MenuItem new("Quit")
        quit connect("activate", || exit(0))
        quit show()
        menu append(quit)
        
        menubar = MenuBar new()
        menubar append(rootMenu)
        menubar show()
        
        Gtk main()
    }
    
    activate: func {
        "Popping up!" println()
        menu popup(null, null, null, null, 3 /* button */, 0 /* activate_time */)
    }
    
}

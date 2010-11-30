use gtk

import gtk/[Gtk, StatusIcon, Menu, Label]
import structs/[List, ArrayList]
import net/Network
import math/Random

NonfiTray: class {
    
    icon: StatusIcon
    
    menu: Menu
    menubar: MenuBar
    
    init: func (networks: List<Network>) {
        icon = StatusIcon new("resources/nonfi.png")
        icon connectNaked("activate", this, activate)
        //icon connectNaked("popup-menu", this, activate)
        
        menu = Menu new()
        rootMenu := MenuItem new("Root Menu")
        rootMenu setSubMenu(menu)
        rootMenu show()
        
        knownNetworks   := ArrayList<Network> new()
        unknownNetworks := ArrayList<Network> new()
        networks each(|network|
            known := (Random randInt(1, 2) == 1)
            if(known || network connected) {
                knownNetworks add(network)
            } else {
                unknownNetworks add(network)
            }
        )
        
        i := 0
        knownNetworks each(|network|
            item := MenuItem new("blah")
            item getChild() as Label setMarkup(
                "%s<small>%d %%</small>\t%s%s%s" format(
                    network connected ? "⇒\t" : "\t",
                    (network quality * 100.0) as Int,
                    network connected ? "<span weight=\"bold\">" : "<span>",
                    network essid,
                    "</span>"))
            item setToolTipText(network toString())
            item connect("activate", || network connect())
            item show()
            menu append(item)
            i += 1
        )
        
        separator := MenuItem new()
        separator show()
        menu append(separator)
        
        unknownNetworks each(|network|
            item := MenuItem new("blah")
            item getChild() as Label setMarkup(
                "\t<small>%d %%</small>\t%s" format(
                    (network quality * 100.0) as Int,
                    network essid
                )
            )
            item setToolTipText(network toString())
            item connect("activate", || network connect())
            item show()
            menu append(item)
        )
        
        separator = MenuItem new()
        separator show()
        menu append(separator)
        
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
        menu popup(null, null, gtk_status_icon_position_menu /* position func */,
            icon /* userData */, 3 /* button */, gtk_get_current_event_time() /* activate_time */)
    }
    
}

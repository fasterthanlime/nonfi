import net/[Probe, NetInterface], ui/[ControlPanel]

main: func {

    ifaces := Probe getInterfaces()    
    for(iface in ifaces) {
        "- %s" format(iface getName()) println()
    }
    
    cp := ControlPanel new(ifaces)
    
}


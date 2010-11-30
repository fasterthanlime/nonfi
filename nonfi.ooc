import gui/NonfiTray
import net/[NetworkFinder, Network]

main: func {

    networks := NetworkFinder new() list()
    
    networks each(|network|
        println()
        " - %s (%.1f %%)" printfln(network essid, network quality * 100.0)
        "     %s %s" printfln(network encrypt, network cipher)
        "     channel %d" printfln(network channel)
        "     bssid: %s" printfln(network bssid)
    )

    NonfiTray new(networks)

}

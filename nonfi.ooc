import gui/NonfiTray
import net/[NetworkFinder, Network]

main: func {

    "Note: for now, nonfi has to be run as root (yeah, sucks eh?). Otherwise it'll just crash." println()

    networks := NetworkFinder new() list()
    
    networks each(|network|
        println()
        network toString() println()
    )

    NonfiTray new(networks)

}

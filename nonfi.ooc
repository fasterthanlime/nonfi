import gui/NonfiTray
import net/[NetworkFinder, Network]

main: func {

    networks := NetworkFinder new() list()
    
    networks each(|network|
        println()
        network toString() println()
    )

    NonfiTray new(networks)

}

import os/Process, text/StringTokenizer
import structs/[List, ArrayList]
import Network

NetworkFinder: class {
    
    init: func {}
    
    list: func -> List<Network> {
        "List of WiFi networks: " println()
        
        networks := ArrayList<Network> new()
        
        output := Process new(["iwlist", "wlan0", "scanning"]) getOutput()
        
        firstCell := true
        output split("Cell ") each(|cell|
            if(firstCell) {
                firstCell = false
                return true
            }
        
            network  := Network new()

            first := true
            cell split('\n') each(|line|
                if(first) {
                    first = false
                    idx := line indexOf("Address: ")
                    network bssid = line substring(idx + "Address: " size)
                    
                } else {
                    line = line trim()
                    if(line startsWith?("ESSID:")) {
                        network essid = line substring("ESSID:" size + 1, line size - 1)
                    } else if(line startsWith?("Channel:")) {
                        network channel = line substring("Channel:" size) toInt()
                    } else if(line startsWith?("Frequency:")) {
                        network frequency = line substring("Frequency:" size, line indexOf(' '))
                    } else if(line startsWith?("Quality=")) {
                        qualityStr := line substring("Quality=" size, line indexOf(' '))
                        parts := qualityStr split('/')
                        if(parts size >= 2) {
                            network quality = parts[0] toDouble() / parts[1] toDouble()
                        }
                    } else if(line startsWith?("Encryption key:on")) {
                        network encrypt = "WEP"
                    } else if(network encrypt == "OPN" || network encrypt == "WEP") {
                        if(line contains?("WPA2")) {
                            network encrypt = "WPA2"
                        } else if(line contains?("WPA")) {
                            network encrypt = "WPA"
                        }
                    } else if(line startsWith?("Group Cipher") && network cipher == "") {
                        if(line endsWith?("CCMP")) {
                            // CCMP uses AES for encryption
                            // it's a mandatory part of the WPA2 standard,
                            // and an optional part of the WPA standard.
                            network cipher = "CCMP"
                        } else if(line endsWith?("TKIP")) {
                            network cipher = "TKIP"
                        }
                    }
                }
            )
            // TODO: maybe, one day, deal with hidden networks?
            if(network essid != "")
                networks add(network)
        )
        
        networks
    }
    
}

import NetInterface
import structs/[ArrayList, List]
import os/[Process, Pipe, PipeReader]
import text/[StringTokenizer]

Probe: class {
    
    getInterfaces: static func -> List<NetInterface> {
        
        al := ArrayList<NetInterface> new()
        
        for(ifname in getIfNames()) {
            al add(NetInterface new(ifname))
        }
        
        return al
        
    }
    
    /**
     * Return a list of interface names
     */
    getIfNames: static func -> List<String> {
        
        output := Process new(["ifconfig", "-a"] as ArrayList<String>) getOutput()
        return getNamesFromText(output)
        
    }
    
    /**
     * Return a list of the names of the interfaces that are up
     */
    getUpIfNames: static func -> List<String> {
        
        output := Process new(["ifconfig"] as ArrayList<String>) getOutput()
        return getNamesFromText(output)
        
    }
    
    /**
     * Retrieve the names of the interface from ifconfig output
     */
    getNamesFromText: static func (output: String) -> List<String> {
        
        ifnames := ArrayList<String> new()
        
        i := 0
        while(i < output length()) {
            index := output indexOf("\n\n", i)
            if(index == -1) break
            
            iftext := output substring(i, index) trim('\n') trim(' ') trim('\t')
            ifnames add(iftext substring(0, iftext indexOf(' ')))
            
            i = index + 1
        }
        
        return ifnames
        
    }
    
}


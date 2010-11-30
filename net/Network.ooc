

Network: class {
    
    essid   := ""
    bssid   := ""
    channel := -1
    frequency := "N/A"
    quality := 0.0 // in [0, 1]
    
    encrypt := "OPN"
    cipher  := ""
    
    connected := false
    
    toString: func -> String {
        "%s (%.1f %%)" format(essid, quality * 100.0) +
        "\n%s %s" format(encrypt, cipher) +
        "\nchannel %d" format(channel) +
        "\nbssid\t %s" format(bssid)
    }
    
    connect: func {
        "Should connect to network %s with auth %s" printfln(essid, encrypt)
    }
    
}

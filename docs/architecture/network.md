graph TD
    subgraph Internet
        ISP[ISP Router]
        Mobile[Mobile Hotspot]
    end
    
    subgraph Management["Management Network (192.168.2.x)"]
        Linksys[Linksys ACM3200\nOpenWrt]
        Laptop[Admin Laptop]
    end
    
    subgraph Cluster["Cluster Network (10.0.x.x)"]
        Switch[8-Port POE Switch]
        Master1[Master Node 1]
        Master2[Master Node 2]
        Master3[Master Node 3]
        Worker1[Worker Node 1]
        Worker2[Worker Node 2]
        Worker3[Worker Node 3]
        Worker4[Worker Node 4]
    end
    
    ISP -- WAN Connection --> Linksys
    Mobile -. Alternative WAN .- Linksys
    Linksys -- Management Network --> Laptop
    Linksys -- NAT --> Switch
    Switch --> Master1 & Master2 & Master3
    Switch --> Worker1 & Worker2 & Worker3 & Worker4
    
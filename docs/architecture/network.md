# Network Architecture

Below is the network diagram for the Raspberry Pi Kubernetes cluster:

```mermaid
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
    end
    
    ISP -- WAN Connection --> Linksys
    Mobile -. Alternative WAN .- Linksys
    Linksys -- Management Network --> Laptop
    Linksys -- NAT --> Switch
    Switch --> Master1 & Master2 & Master3
    Switch --> Worker1 & Worker2 & Worker3
   
    ```

    ## Router Configuration Automation

For convenience, a shell script has been created to automate the OpenWRT router configuration steps described above. This script handles:

- Creating the picluster network bridge and interface
- Assigning lan4 to the correct bridge (removing it from other bridges first)
- Configuring the firewall zones and rules
- Setting up NAT for the cluster network
- Setting global forwarding to accept

The script is located at: [`ansible/scripts/openwrt-config.sh`](../../ansible/scripts/openwrt-config.sh)

To use it:
1. SSH into your OpenWRT router: `ssh root@192.168.2.1`
2. Copy the script to the router
3. Make it executable: `chmod +x openwrt-config.sh`
4. Run it: `./openwrt-config.sh`
5. The router will automatically apply all changes and restart the necessary services

This automation ensures consistent router configuration and makes it easy to reset or recreate the network if needed.

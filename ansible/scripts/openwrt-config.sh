#!/bin/sh

# Remove lan4 from existing bridges
# First, identify which bridge contains lan4 (usually br-lan)
for dev in $(uci show network | grep "device='br-" | cut -d= -f1); do
  # Get the current ports
  ports=$(uci get $dev.ports 2>/dev/null)
  # Remove lan4 from the list
  new_ports=$(echo $ports | sed 's/lan4 //g' | sed 's/ lan4//g' | sed 's/lan4//g')
  # Set the new ports list
  if [ "$ports" != "$new_ports" ]; then
    uci del_list $dev.ports='lan4'
  fi
done

# Create picluster bridge
uci set network.br_picluster=device
uci set network.br_picluster.name='br-picluster'
uci set network.br_picluster.type='bridge'
uci add_list network.br_picluster.ports='lan4'

# Create picluster interface
uci set network.picluster=interface
uci set network.picluster.proto='static'
uci set network.picluster.device='br-picluster'
uci set network.picluster.ipaddr='10.0.0.1'
uci set network.picluster.netmask='255.255.255.0'

# Set global firewall forwarding to accept
uci set firewall.@defaults[0].forward='ACCEPT'

# Create firewall zone for picluster
uci add firewall zone
uci set firewall.@zone[-1].name='picluster'
uci set firewall.@zone[-1].input='ACCEPT'
uci set firewall.@zone[-1].output='ACCEPT'
uci set firewall.@zone[-1].forward='ACCEPT'
uci set firewall.@zone[-1].masq='1'
uci set firewall.@zone[-1].network='picluster'

# Create forwarding rules between zones
uci add firewall forwarding
uci set firewall.@forwarding[-1].src='lan'
uci set firewall.@forwarding[-1].dest='picluster'

uci add firewall forwarding
uci set firewall.@forwarding[-1].src='picluster'
uci set firewall.@forwarding[-1].dest='lan'

uci add firewall forwarding
uci set firewall.@forwarding[-1].src='wan'
uci set firewall.@forwarding[-1].dest='picluster'

# Create NAT rule for picluster network
uci add firewall rule
uci set firewall.@rule[-1].name='picluster_nat'
uci set firewall.@rule[-1].src='picluster'
uci set firewall.@rule[-1].dest='*'
uci set firewall.@rule[-1].target='MASQUERADE'

# Apply changes
uci commit
service network restart
service firewall restart

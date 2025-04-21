# Netplan Configuration Templates

This directory contains templates for Ubuntu's Netplan network configuration system. These templates are processed by the Makefile during image preparation to configure static IP addressing.

## Network Configuration

The network configuration is derived from the templates in the `../common/cloud-init/` directory, as cloud-init is used for the initial network setup.

## Manual Netplan Updates

If you need to manually update the network configuration after initial setup, you can use these templates as a reference. On a running system, netplan files are located in `/etc/netplan/`.

To apply changes:
```bash
sudo netplan apply
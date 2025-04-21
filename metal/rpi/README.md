# Raspberry Pi Configuration

This directory contains configuration and automation specific to Raspberry Pi nodes in the cluster.

## Directory Structure

- **config/**: Hardware configuration files (config.txt, cmdline.txt, etc.)
- **netplan/**: Network configuration templates for Ubuntu Server
- **Makefile**: Automation for Pi image preparation

## Makefile Usage

The Makefile provides automated tasks for preparing Raspberry Pi images:

```bash
# Download the latest Ubuntu Server image for Raspberry Pi
make download

# Prepare an image with custom configuration (partitioning, network, etc.)
make prepare DEVICE=/dev/sdX NODE=node001 IP=10.0.0.101

# Flash the prepared image to storage device
make flash DEVICE=/dev/sdX

# All-in-one: download, prepare, and flash
make all DEVICE=/dev/sdX NODE=node001 IP=10.0.0.101
# Metal Configuration

This directory contains all configuration and automation related to the bare metal setup of the Raspberry Pi Kubernetes cluster. These steps are performed before Ansible can connect to and configure the nodes.

## Directory Structure

- **common/**: Configuration common to all node types
- **rpi/**: Raspberry Pi specific configuration

## Usage

The configuration and scripts in this directory are used to prepare the Raspberry Pi nodes before they are added to the cluster. This includes:

1. Preparing and flashing OS images to storage devices
2. Setting up network configuration
3. Configuring SSH access
4. Adjusting hardware settings (GPU memory, etc.)

See the README files in each subdirectory for specific instructions.

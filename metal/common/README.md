# Common Metal Configuration

This directory contains configuration files and templates common to all node types in the cluster.

## Directory Structure

- **cloud-init/**: Cloud-init configuration templates used for initial node setup
- **ssh/**: SSH keys and configuration for secure access to nodes

## Cloud-init

The cloud-init directory contains YAML templates used to configure nodes on their first boot. These templates handle:

- User creation
- SSH key installation
- Package installation
- Initial system configuration

## SSH

The SSH directory contains:

- SSH key pairs for cluster access
- SSH configuration templates
- Scripts for generating and distributing SSH keys

**Note**: Do not commit private SSH keys to the repository. The `.gitignore` file is configured to exclude them, but always verify before committing.
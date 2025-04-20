# Raspberry Pi Kubernetes Cluster

A fully ARM64 Kubernetes homelab using Raspberry Pi nodes, automated with Ansible and FluxCD.

This project is the continuation of what is mentioned on my projects section of my LinkedIn profile:

https://www.linkedin.com/in/lfdesousa

To be more precise the the project at the University of Liverpool.

![Kubernetes Logo](https://kubernetes.io/images/favicon.png) 

## Project Overview

This project documents and automates the creation of a lightweight Kubernetes (K3s) cluster using bare metal Raspberry Pi devices. It implements infrastructure as code (IaC) and GitOps methodologies to provide a fully automated, reproducible deployment process.

The entire cluster setup—from initial OS installation to deploying core services and applications—is automated using Ansible for provisioning and FluxCD for continuous delivery.

## Architecture

### Network Topology

Our cluster network architecture is designed with separation between management and cluster networks.

[View Network Topology Diagram](docs/architecture/network.md)

### Key Features

- **Pure ARM64 Architecture**: Built entirely on ARM64 Raspberry Pi devices for a homogeneous computing environment
- **Fully Automated**: Uses Ansible for infrastructure provisioning and FluxCD for GitOps-based deployments
- **Self-Healing**: Automated recovery from node failures and configuration drift
- **Distributed Storage**: Implements Longhorn for resilient container storage
- **Complete Observability**: Integrated monitoring, logging, and tracing solutions
- **Security-Focused**: Implements certificate management, secret handling, and identity access control

## Hardware Setup

This cluster is designed to run on the following hardware:
- Multiple Raspberry Pi 4 Model B (4GB RAM or higher)
- Gigabit Ethernet Switch
- Power Distribution Hub

See the [hardware setup guide](docs/setup-guides/hardware.md) for detailed specifications and assembly instructions.

## Core Components

The cluster includes the following core components:

- **K3s**: A lightweight Kubernetes distribution
- **Longhorn**: Distributed block storage for persistent volumes
- **Flux CD**: GitOps delivery for declarative infrastructure
- **Prometheus & Grafana**: Metrics monitoring and visualization
- **EFK Stack**: Logging and log analysis
- **Cert-Manager**: Automated certificate management
- **Vault & External Secrets**: Secrets management
- **Keycloak**: Identity and access management

For more information on each component, see the [components documentation](docs/components/).

## Getting Started

### Prerequisites

- Raspberry Pi 4 devices with SD cards or USB SSDs
- Gigabit network switch
- Host machine with Ansible installed
- Docker and kubectl installed on your workstation

### Quick Start
WIP
1. Clone this repository:

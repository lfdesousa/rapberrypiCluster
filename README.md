# Raspberry Pi Kubernetes Cluster

A fully ARM64 Kubernetes homelab using Raspberry Pi nodes, automated with Ansible and FluxCD.

This project is the continuation of what is mentioned on my projects section of my LinkedIn profile:

https://www.linkedin.com/in/lfdesousa

To be more precise the the project at the University of Liverpool.

![Kubernetes Logo](https://kubernetes.io/images/favicon.png) 

## Project Overview

This project documents and automates the creation of a lightweight Kubernetes (K3s) cluster using bare metal Raspberry Pi devices. It implements infrastructure as code (IaC) and GitOps methodologies to provide a fully automated, reproducible deployment process.

The entire cluster setup—from initial OS installation to deploying core services and applications—is automated using Ansible for provisioning and FluxCD for continuous delivery.

To be more precise and this will be evident in other sections, there is preparatory work that happens before we start the automation flow with Ansible. We need first to flash all the SSDs with the needed OS image and configure it for the first boot.

Another important point is that in this project, I am using an old router acting as a GW to isolate the LAB from my home network. This device was flashed with a custom Firmware OpenWrt and we also have a dedicated section to show how to configure the router so that the Raspberry pi's can be network isolated from the rest.

There is yet another reason to use OpenWrt and this is mentioned in the Network Architecture diagram, in fact I would like to be able to demo this system outside home, and rely on a mobile hotspot to have internet connectivity, this is a wish at the time of writting and I have not had yet a change to test it out.

You will notice a bit everwhere a mention to a domain allaboutdata.eu, this domain is mine and I will use later in the project certificates from this domain.

I would like to be clear, that once we have established a baseline, where we can deploy workloads in a repeatable way, thus why the effort on automation and tooling, we will then focus in the SW and Data Aspects.

This should be treated as a baseline for other investigations.

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
- Multiple Raspberry Pi (8GB RAM or higher)
- Gigabit Ethernet Switch with POE
- Linksys Router with OpenWrt
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

- Raspberry Pi 4/5 devices with USB SSDs/or NVME and POE Hat
- Sata to USB cables
- Ethernet Cables
- Gigabit network switch with Ports POE capable
- Linksys Router with OpenWrt
- Host machine with Ansible installed
- Docker and kubectl installed on your workstation

### Quick Start
The goal of this section is to point you out to a set of logical steps that you need to perform to have something up and running in a relatively short amount of time.

Thus, I would say that a key part is to start checking the directory called Metal. (That code is not yet tested)

Another helpful section from this project point of view is the setup of the OpenWrt Router, and I took an approach of having a network soultion in place for a single node first, once that worked, then I started to move to try to streamline the OS Image preparation for all the Raspberry Pi devices. In the current version I have 7 overall.

(tbc)


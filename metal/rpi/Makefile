# Makefile for Raspberry Pi OS preparation

# Variables
IMAGE_URL := https://cdimage.ubuntu.com/releases/24.10/release/ubuntu-24.10-preinstalled-server-arm64+raspi.img.xz
IMAGE_FILE := ubuntu-24.10-preinstalled-server-arm64-raspi.img.xz
EXTRACTED_IMAGE := ubuntu-24.10-preinstalled-server-arm64-raspi.img
DEVICE ?= /dev/sdX
NODE ?= pi-security
IP ?= 10.0.0.120
MOUNT_POINT := /tmp/pimount

.PHONY: download extract prepare flash clean all

# Download Ubuntu Server image
download:
	@echo "Downloading Raspberry Pi Ubuntu Server 24.10 image..."
	wget -O $(IMAGE_FILE) $(IMAGE_URL)

# Extract the image
extract: download
	@echo "Extracting image..."
	xz -d -k $(IMAGE_FILE)

# Prepare the image with custom configuration
# Prepare the image with custom configuration
prepare: extract
	@echo "Preparing image for $(NODE) with IP $(IP)..."
	@mkdir -p $(MOUNT_POINT)
	
	# Find the correct loop device and mount points
	@losetup -f $(EXTRACTED_IMAGE)
	@LOOP_DEV=$$(losetup -j $(EXTRACTED_IMAGE) | cut -d: -f1); \
	echo "Using loop device: $$LOOP_DEV"; \
	partprobe $$LOOP_DEV; \
	mkdir -p $(MOUNT_POINT)/boot; \
	mkdir -p $(MOUNT_POINT)/rootfs; \
	mount "$${LOOP_DEV}p1" $(MOUNT_POINT)/boot; \
	mount "$${LOOP_DEV}p2" $(MOUNT_POINT)/rootfs;
	
	# Process basic user-data template
	@SSH_KEY=$$(cat ../common/ssh/id_rsa_cluster.pub); \
	sed -e "s/{{NODE}}/$(NODE)/g" \
	    -e "s|{{SSH_PUBLIC_KEY}}|$$SSH_KEY|g" \
	    ../common/cloud-init/user-data.yml.template > /tmp/user-data-base.yml
	
	# Merge with SSD partitioning instructions
	@python3 -c "import yaml; \
	    base = yaml.safe_load(open('/tmp/user-data-base.yml')); \
	    ssd = yaml.safe_load(open('cloud-init/nodes/user-data-SSD-partition.yaml')); \
	    if 'bootcmd' in ssd: base['bootcmd'] = ssd['bootcmd']; \
	    if 'power_state' in ssd: base['power_state'] = ssd['power_state']; \
	    yaml.dump(base, open('$(MOUNT_POINT)/boot/user-data', 'w'))"
	
	@sed -e "s/{{IP}}/$(IP)/g" \
	    ../common/cloud-init/network-config.yml.template > $(MOUNT_POINT)/boot/network-config
	
	# Copy hardware configuration
	@cp config/config.txt $(MOUNT_POINT)/boot/config.txt
	
	# Create cloud-init.enabled file
	@touch $(MOUNT_POINT)/boot/cloud-init.enabled
	
	# Unmount and clean up
	@umount $(MOUNT_POINT)/boot
	@umount $(MOUNT_POINT)/rootfs
	@LOOP_DEV=$$(losetup -j $(EXTRACTED_IMAGE) | cut -d: -f1); \
	losetup -d $$LOOP_DEV
	@rm -f /tmp/user-data-base.yml

# Flash image to device
flash:
	@echo "Flashing image to $(DEVICE)..."
	@if [ "$(DEVICE)" = "/dev/sdX" ]; then \
		echo "Please specify a valid device with DEVICE=/dev/sdX"; \
		exit 1; \
	fi
	@read -p "Are you sure you want to flash $(EXTRACTED_IMAGE) to $(DEVICE)? This will erase all data on $(DEVICE). [y/N] " confirm; \
	if [ "$$confirm" != "y" ]; then exit 1; fi
	sudo dd if=$(EXTRACTED_IMAGE) of=$(DEVICE) bs=4M status=progress

# Clean up temporary files
clean:
	@echo "Cleaning up..."
	@rm -f $(IMAGE_FILE) $(EXTRACTED_IMAGE)
	@rm -rf $(MOUNT_POINT)

# All-in-one command
all: download extract prepare flash

# Check if required tools are installed
check-deps:
	@echo "Checking for required dependencies..."
	@which wget || (echo "wget is not installed"; exit 1)
	@which xz || (echo "xz-utils is not installed"; exit 1)
	@which losetup || (echo "util-linux is not installed"; exit 1)
	@which partprobe || (echo "parted is not installed"; exit 1)
	@which dd || (echo "coreutils is not installed"; exit 1)
	@echo "All dependencies are installed"

# Help target
help:
	@echo "Raspberry Pi OS Image Preparation Makefile"
	@echo ""
	@echo "Available targets:"
	@echo "  download    - Download the Ubuntu Server 24.10 image"
	@echo "  extract     - Extract the downloaded image"
	@echo "  prepare     - Prepare the image with custom configuration"
	@echo "  flash       - Flash the image to a device"
	@echo "  clean       - Clean up temporary files"
	@echo "  all         - Execute download, extract, prepare, and flash"
	@echo "  check-deps  - Check for required dependencies"
	@echo "  help        - Show this help message"
	@echo ""
	@echo "Parameters:"
	@echo "  DEVICE      - Target device for flashing (default: /dev/sdX)"
	@echo "  NODE        - Node hostname (default: pi-security)"
	@echo "  IP          - Static IP address (default: 10.0.0.120)"
	@echo ""
	@echo "Example usage:"
	@echo "  make prepare NODE=pi-master-01 IP=10.0.0.101"
	@echo "  make flash DEVICE=/dev/sdc"
	@echo "  make all DEVICE=/dev/sdc NODE=pi-worker-01 IP=10.0.0.111"
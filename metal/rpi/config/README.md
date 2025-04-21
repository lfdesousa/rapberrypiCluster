## metal/rpi/config/README.md

```markdown
# Raspberry Pi Hardware Configuration

This directory contains hardware configuration files that are applied during the image preparation process.

## Files

- **config.txt**: Main Raspberry Pi configuration file that controls hardware settings
  - GPU memory allocation
  - Hardware interfaces (I2C, SPI, etc.)
  - Boot options
  - Peripheral configuration

## Customization

You can modify these files to adjust hardware settings specific to your cluster requirements. For example:
- Changing the GPU memory allocation
- Enabling/disabling specific hardware interfaces
- Setting up overclocking parameters for performance (not recommended for production)

## References

For detailed information about `config.txt` options, see the [Raspberry Pi documentation](https://www.raspberrypi.com/documentation/computers/config_txt.html).

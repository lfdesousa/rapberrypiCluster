# SSH Keys

This directory should contain your SSH keys for cluster access.

## Generate a New Key Pair

```bash
ssh-keygen -t rsa -b 4096 -C "your_email@example.com" -f ./id_rsa_cluster

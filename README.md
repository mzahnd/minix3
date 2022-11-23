# Getting MINIX 3 image

~~~bash
# Get the ISO image
curl --remote-name  http://download.minix3.org/iso/minix_R3.3.0-588a35b.iso.bz2

# Decompress it
# If you don't have bzip2, install it running:
# sudo apt install bzip2 # Ubuntu / Debian
# sudo pacman -S bzip2 # Arch Linux
bzip2 -d minix_R3.3.0-588a35b.iso.bz2

# Create an image file (recomended minimum size is 8GB)
qemu-img create minix.img 8G

# Install it
qemu-system-x86_64 -net user -net nic -m 256 -cdrom minix_R3.3.0-588a35b.iso -drive file=minix.img,format=raw -boot d

# Run after installation
qemu-system-x86_64 -net user -net nic -m 256 -drive file=minix.img,format=raw
~~~

Once inside your Minix VM, install the basic tools and OpenSSH to access it from a shell in your host machine.
~~~
echo export TZ=America/Buenos_Aires > /etc/rc.timezone
pkgin update
pkgin install openssh git-base binutils clang vim
passwd # Set root password (needed for SSH)
reboot
~~~

pass: root123

We can now use SSH to control our Minix VM:
~~~bash
qemu-system-x86_64 -net user,hostfwd=tcp::2022-:22 -net nic -m 1024 -drive file=minix.img,format=raw
~~~

In a shell in your host machine:
~~~bash
# SSH
ssh -p 2022 root@localhost

# SFTP
sftp -P 2022 root@localhost
~~~


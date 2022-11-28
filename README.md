# Building Minix 3.3.0

This branch exists so we can build Minix v3.3.0 from sources as the main branch
is, at the time of writting, unable to successfully build Minix 3.

There's another way to get Minix running described in the 
[master branch](https://github.com/mzahnd/minix3/tree/master).

## Instructions

In a local shell, run the following commands:
~~~bash
mkdir obj.i386 # Inside MINIX 3 repo folder

# Build the docker image
chmod +x env/build_docker_image.sh
./env/build_docker_image.sh

# Run it
chmod +x env/run_docker.sh
./env/run_docker.sh
~~~

Once inside the Docker container, we can actually build the sources and
generate a hard disk image that can be mounted on qemu.

~~~bash
# Option 1: Use all your CPU threads to build
export JOBS=$(nproc); bash ./releasetools/x86_hdimage.sh

# Option 2: Leave one thread free to perform other tasks in your computer
export JOBS=$(($(nproc)-1)); bash ./releasetools/x86_hdimage.sh
~~~

This will generate an img file in `src/minix_x86.img`. We can run it with qemu
using:
~~~bash
qemu-system-x86_64 -net user -net nic -m 256 -drive file=src/minix_x86.img,format=raw
~~~

Note that this image file **does not** have a package manager (`pkgin`).
How to embed it is still unknown to me.

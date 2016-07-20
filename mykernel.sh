#!/bin/bash


if which qemu-system-i386
then
    echo ""
    echo "**************** QEMUE has been install already ***"
    echo ""
    echo "**************** Checking for existing file *******"
else
    echo ""
    echo "**************** QEMUE doesn't install ************"
    echo ""
    echo "**************** Install qemu now *****************"

    sudo apt-get install -y qemu >> /dev/null
    sudo ln -s /usr/bin/qemu-system-i386 /usr/bin/qemu
fi


if [ -d "mykernel" ];
then
    echo ""
    echo "**************** directory mykernel exist ******"
    echo ""
    echo "**************** Checking for existing file *******"
else
    echo "git mykernel"
    git clone git@github.com:gatieme/mykernel.git
fi

if [ -d "linux-3.9.4" ];
then
    echo ""
    echo "**************** directory linux-3.9.4 exist ******"
    echo ""
    echo "**************** Checking for existing file *******"

    if [ ! -a "./linux-3.9.4/arch/x86/boot/bzImage" ];
    then
        echo ""
        echo "**************** bzImage exist *******"

    else
        cd linux-3.9.4
        patch -p1 < ../mykernel/mykernel_for_linux3.9.4sc.patch
        make allnoconfig
        make
        cd ..
    fi
else
    wget https://www.kernel.org/pub/linux/kernel/v3.x/linux-3.9.4.tar.xz
    xz -d linux-3.9.4.tar.xz
    tar -xvf linux-3.9.4.tar

    cd linux-3.9.4
    patch -p1 < ../mykernel/mykernel_for_linux3.9.4sc.patch
    make allnoconfig
    make
    cd ..
fi

pwd
qemu -kernel linux-3.9.4/arch/x86/boot/bzImage

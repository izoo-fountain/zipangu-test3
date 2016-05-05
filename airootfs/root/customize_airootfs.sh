#!/bin/bash

set -e -u

sed -i 's/#\(ja_JP\.UTF-8\)/\1/' /etc/locale.gen
locale-gen

ln -sf /usr/share/zoneinfo/Asia/Tokyo /etc/localtime

usermod -s /bin/bash root
cp -aT /etc/skel/ /root
chmod 755 /root

useradd -m -G "users,adm,audio,floppy,log,network,rfkill,scanner,storage,optical,power,wheel" -s /bin/bash ablive


#! id ablive && useradd -m -p "" -g users -G "adm,audio,floppy,log,network,rfkill,scanner,storage,optical,power,wheel" -s /bin/bash ablive

sed -i 's/#\(PermitRootLogin \).\+/\1yes/' /etc/ssh/sshd_config
sed -i "s/#Server/Server/g" /etc/pacman.d/mirrorlist
sed -i 's/#\(Storage=\)auto/\1volatile/' /etc/systemd/journald.conf

sed -i 's/#\(HandleSuspendKey=\)suspend/\1ignore/' /etc/systemd/logind.conf
sed -i 's/#\(HandleHibernateKey=\)hibernate/\1ignore/' /etc/systemd/logind.conf
sed -i 's/#\(HandleLidSwitch=\)suspend/\1ignore/' /etc/systemd/logind.conf

systemctl enable pacman-init.service choose-mirror.service wicd.service lxdm.service
systemctl set-default graphical.target

ln -s /lib/systemd/system/lxdm.service /etc/systemd/system/graphical.target.wants/display-manager.service





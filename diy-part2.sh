#!/bin/bash
#
# Copyright (c) 2019-2020 P3TERX <https://p3terx.com>
#
# This is free software, licensed under the MIT License.
# See /LICENSE for more information.
#
# https://github.com/P3TERX/Actions-OpenWrt
# File name: diy-part2.sh
# Description: OpenWrt DIY script part 2 (After Update feeds)
#




# Modify default IP  修改默认IP为192.168.10.1
#sed -i 's/192.168.1.1/192.168.10.1/g' package/base-files/files/bin/config_generate


#---来自----https://github.com/IvanSolis1989/OpenWrt-DIY/----------

#这一步和diy-part1.sh里重复
# Add luci-app-ssr-plus  depth=1只要clone最近的一个版本，pushd popd 以栈模式切换目录
#pushd package/lean
#git clone --depth=1 https://github.com/fw876/helloworld
#popd

# Clone community packages to package/community
mkdir package/community
pushd package/community

#这一步和diy-part1.sh里重复
# Add Lienol's Packages
#git clone --depth=1 https://github.com/Lienol/openwrt-package

# Add dnsfilter
git clone --depth=1 https://github.com/garypang13/luci-app-dnsfilter

# Add luci-app-passwall 科学上网
git clone --depth=1 https://github.com/xiaorouji/openwrt-passwall

# Add luci-app-vssr <M>  科学上网HelloWorld
git clone --depth=1 https://github.com/jerrykuku/lua-maxminddb.git
git clone --depth=1 https://github.com/jerrykuku/luci-app-vssr

# Add mentohust & luci-app-mentohust  锐捷
git clone --depth=1 https://github.com/BoringCat/luci-app-mentohust
git clone --depth=1 https://github.com/KyleRicardo/MentoHUST-OpenWrt-ipk

# Add luci-proto-minieap  锐捷V3V4
git clone --depth=1 https://github.com/ysc3839/luci-proto-minieap

# Add ServerChan  Server酱 微信/Telegram 推送的插件
git clone --depth=1 https://github.com/tty228/luci-app-serverchan

# Add OpenClash
git clone --depth=1 -b master https://github.com/vernesong/OpenClash

# Add luci-app-onliner (need luci-app-nlbwmon)    通过arp实现的查看在线人员
git clone --depth=1 https://github.com/rufengsuixing/luci-app-onliner

# Add luci-app-adguardhome  AdGuard home广告过滤
git clone --depth=1 https://github.com/SuLingGG/luci-app-adguardhome

# Add luci-app-diskman  LuCI 插件，支持磁盘分区、格式化
git clone --depth=1 https://github.com/SuLingGG/luci-app-diskman
mkdir parted
cp luci-app-diskman/Parted.Makefile parted/Makefile

# Add luci-app-dockerman  Docker容器
rm -rf ../lean/luci-app-docker
git clone --depth=1 https://github.com/KFERMercer/luci-app-dockerman
git clone --depth=1 https://github.com/lisaac/luci-lib-docker

# Add luci-app-gowebdav  webdav server 
git clone --depth=1 https://github.com/project-openwrt/openwrt-gowebdav

# Add luci-theme-argon  主题
git clone --depth=1 -b 18.06 https://github.com/jerrykuku/luci-theme-argon
git clone --depth=1 https://github.com/jerrykuku/luci-app-argon-config
rm -rf ../lean/luci-theme-argon

# Use immortalwrt's luci-app-netdata   性能实时监测工具,太占资源了
rm -rf ../lean/luci-app-netdata
svn co https://github.com/immortalwrt/immortalwrt/trunk/package/ntlf9t/luci-app-netdata

# Add tmate   终端，可以ssh 3vRvL79H......@sfo2.tmate.io 
git clone --depth=1 https://github.com/project-openwrt/openwrt-tmate

# Add subconverter   科学上网订阅转换托管服务
git clone --depth=1 https://github.com/tindy2013/openwrt-subconverter

# Add gotop
svn co https://github.com/project-openwrt/openwrt/trunk/package/ctcgfw/gotop

# Add smartdns  SmartDNS本地服务器
svn co https://github.com/pymumu/smartdns/trunk/package/openwrt ../smartdns
svn co https://github.com/project-openwrt/openwrt/trunk/package/ntlf9t/luci-app-smartdns ../luci-app-smartdns

# Add luci-udptools
git clone --depth=1 https://github.com/zcy85611/openwrt-luci-kcp-udp

# Add OpenAppFilter
git clone --depth=1 https://github.com/destan19/OpenAppFilter
# Add luci-app-oled (R2S Only)
git clone --depth=1 https://github.com/NateLol/luci-app-oled
# Add driver for rtl8821cu & rtl8812au-ac
svn co https://github.com/project-openwrt/openwrt/branches/master/package/ctcgfw/rtl8812au-ac
svn co https://github.com/project-openwrt/openwrt/branches/master/package/ctcgfw/rtl8821cu
popd

# Add netdata  性能实时监测工具
pushd feeds/packages/admin
rm -rf netdata
svn co https://github.com/immortalwrt/packages/trunk/admin/netdata
popd

# Mod zzz-default-settings
pushd package/lean/default-settings/files
sed -i '/http/d' zzz-default-settings
export orig_version="$(cat "zzz-default-settings" | grep DISTRIB_REVISION= | awk -F "'" '{print $2}')"
sed -i "s/${orig_version}/${orig_version} ($(date +"%Y-%m-%d"))/g" zzz-default-settings
popd

# Use Lienol's https-dns-proxy package   通过HTTPS代理为DNS提供Web UI
pushd feeds/packages/net
rm -rf https-dns-proxy
svn co https://github.com/Lienol/openwrt-packages/trunk/net/https-dns-proxy
popd

# Use snapshots syncthing package
pushd feeds/packages/utils
rm -rf syncthing
svn co https://github.com/openwrt/packages/trunk/utils/syncthing
popd

# Fix mt76 wireless driver
pushd package/kernel/mt76
sed -i '/mt7662u_rom_patch.bin/a\\techo mt76-usb disable_usb_sg=1 > $\(1\)\/etc\/modules.d\/mt76-usb' Makefile
popd

# Add po2lmo
git clone https://github.com/openwrt-dev/po2lmo.git
pushd po2lmo
make && sudo make install
popd

# Change default shell to zsh
sed -i 's/\/bin\/ash/\/usr\/bin\/zsh/g' package/base-files/files/etc/passwd

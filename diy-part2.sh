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

# 在./scripts/feeds install -a之后操作
# 是在openwrt目录中执行的



# Modify default IP  修改默认IP为192.168.10.1
# sed -i 's/192.168.1.1/192.168.10.1/g' package/base-files/files/bin/config_generate

# 修改默认wifi名称ssid为Xiaomi_R4A
# sed -i 's/ssid=OpenWrt/ssid=XXKDB-R4A/g' package/kernel/mac80211/files/lib/wifi/mac80211.sh

# -------------------------------------------------------------

# 添加minieap 锐捷V3V4
git clone https://github.com/BoringCat/minieap-openwrt.git package/minieap
pushd package/minieap
sed -i 's/0.92.1/0.93/g' Makefile
popd


# ---来自----https://github.com/IvanSolis1989/OpenWrt-DIY/----------

# 这一步和diy-part1.sh里重复
# Add luci-app-ssr-plus  depth=1只要clone最近的一个版本，pushd popd 以栈模式切换目录
# pushd package/lean
# git clone --depth=1 https://github.com/fw876/helloworld
# popd

# Clone community packages to package/community
mkdir package/community
pushd package/community

# 这一步和diy-part1.sh里重复
# Add Lienol's Packages
# git clone --depth=1 https://github.com/Lienol/openwrt-package

# Add dnsfilter
git clone --depth=1 https://github.com/garypang13/luci-app-dnsfilter

# Add luci-app-passwall 科学上网
git clone --depth=1 https://github.com/xiaorouji/openwrt-passwall

# Add luci-app-vssr <M>  科学上网HelloWorld  和liuran001 package重复
# git clone --depth=1 https://github.com/jerrykuku/lua-maxminddb.git
# git clone --depth=1 https://github.com/jerrykuku/luci-app-vssr

# Add mentohust & luci-app-mentohust  锐捷
git clone --depth=1 https://github.com/BoringCat/luci-app-mentohust
git clone --depth=1 https://github.com/KyleRicardo/MentoHUST-OpenWrt-ipk

# Add luci-proto-minieap  锐捷V3V4
git clone --depth=1 https://github.com/ysc3839/luci-proto-minieap

# Add ServerChan  Server酱 微信/Telegram 推送的插件 和liuran001 package重复
# git clone --depth=1 https://github.com/tty228/luci-app-serverchan

# Add OpenClash
git clone --depth=1 -b master https://github.com/vernesong/OpenClash

# Add luci-app-onliner (need luci-app-nlbwmon)    通过arp实现的查看在线人员
git clone --depth=1 https://github.com/rufengsuixing/luci-app-onliner

# Add luci-app-adguardhome  AdGuard home广告过滤 和liuran001 package重复
# git clone --depth=1 https://github.com/SuLingGG/luci-app-adguardhome

# Add luci-app-diskman  LuCI 插件，支持磁盘分区、格式化 和liuran001 package重复
# git clone --depth=1 https://github.com/SuLingGG/luci-app-diskman
# mkdir parted
# cp luci-app-diskman/Parted.Makefile parted/Makefile

# Add luci-app-dockerman  Docker容器  和liuran001 package重复
# rm -rf ../lean/luci-app-docker
# git clone --depth=1 https://github.com/KFERMercer/luci-app-dockerman
# git clone --depth=1 https://github.com/lisaac/luci-lib-docker

# Add luci-app-gowebdav  webdav server 
git clone --depth=1 https://github.com/project-openwrt/openwrt-gowebdav

# Add luci-theme-argon  主题
git clone --depth=1 -b 18.06 https://github.com/jerrykuku/luci-theme-argon
git clone --depth=1 https://github.com/jerrykuku/luci-app-argon-config
rm -rf ../lean/luci-theme-argon

# Use immortalwrt's luci-app-netdata   性能实时监测工具,太占资源了 报错doesn't exist
# rm -rf ../lean/luci-app-netdata
# svn co https://github.com/immortalwrt/immortalwrt/trunk/package/ntlf9t/luci-app-netdata

# Add tmate   终端，可以ssh 3vRvL79H......@sfo2.tmate.io 
git clone --depth=1 https://github.com/project-openwrt/openwrt-tmate

# Add subconverter   科学上网订阅转换托管服务
git clone --depth=1 https://github.com/tindy2013/openwrt-subconverter

# Add gotop  报错doesn't exist
# svn co https://github.com/project-openwrt/openwrt/trunk/package/ctcgfw/gotop

# Add smartdns  SmartDNS本地服务器  和liuran001 package重复
# svn co https://github.com/pymumu/smartdns/trunk/package/openwrt ../smartdns
# svn co https://github.com/project-openwrt/openwrt/trunk/package/ntlf9t/luci-app-smartdns ../luci-app-smartdns

# Add luci-udptools kcp协议？？
#git clone --depth=1 https://github.com/zcy85611/openwrt-luci-kcp-udp 报错
git clone --depth=1 https://github.com/zcy85611/Openwrt-Package luci-udptools

# Add OpenAppFilter 实现对单个app进行管控的功能，并支持上网记录统计
git clone --depth=1 https://github.com/destan19/OpenAppFilter

# Add luci-app-oled (R2S Only) 不需要
# git clone --depth=1 https://github.com/NateLol/luci-app-oled

# Add driver for rtl8821cu & rtl8812au-ac  报错doesn't exist
# svn co https://github.com/project-openwrt/openwrt/branches/master/package/ctcgfw/rtl8812au-ac
# svn co https://github.com/project-openwrt/openwrt/branches/master/package/ctcgfw/rtl8821cu
popd

# Add netdata  性能实时监测工具
# pushd feeds/packages/admin
# rm -rf netdata
# svn co https://github.com/immortalwrt/packages/trunk/admin/netdata
# popd

# Mod zzz-default-settings
pushd package/lean/default-settings/files
# 删除这一行，这行是原代码更改下载包为镜像地址，没有问题
# sed -i '/http/d' zzz-default-settings
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

# Add po2lmo  OpenWRT中只识别格式为lmo格式的紧凑型文本格式
git clone https://github.com/openwrt-dev/po2lmo.git
pushd po2lmo
make && sudo make install
popd

# Change default shell to zsh
sed -i 's/\/bin\/ash/\/usr\/bin\/zsh/g' package/base-files/files/etc/passwd

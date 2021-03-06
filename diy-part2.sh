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

# Modify default IP
sed -i 's/192.168.1.1/192.168.3.1/g' package/base-files/files/bin/config_generate
sed -i 's/root::0:0:99999:7:::/root:$1$l6Tqa73w$Zoavr1irum3walH.ZOQAo1:18674:0:99999:7:::/g' ./package/base-files/files/etc/shadow
#!/bin/bash
#
# Copyright (c) 2019-2020 P3TERX <https://p3terx.com>
#
# This is free software, licensed under the MIT License.
# See /LICENSE for more information.
#
# https://github.com/P3TERX/Actions-OpenWrt
# File name: diy-part1.sh
# Description: OpenWrt DIY script part 1 (Before Update feeds)
#

# Uncomment a feed source
#sed -i 's/^#\(.*helloworld\)/\1/' feeds.conf.default

# Add a feed source
#sed -i '$a src-git onliner https://github.com/rufengsuixing/luci-app-onliner' feeds.conf.default

#!/bin/bash
#=================================================
# Description: DIY script
# Lisence: MIT
# Author: P3TERX
# Blog: https://p3terx.com
#=================================================
# Modify default IP
#sed -i 's/192.168.1.1/192.168.50.5/g' package/base-files/files/bin/config_generate

# Clone Lean's latest sources.
#pushd package
#git clone --depth=1 https://github.com/coolsnowwolf/lede
#popd

# Copy Lean's packages to ./package/lean.
#mkdir package/lean
#pushd package/lede/package/lean
#cp -r {luci-app-flowoffload,luci-app-zerotier,adbyby,automount,baidupcs-web,coremark,ddns-scripts_aliyun,ddns-scripts_dnspod,dns2socks,ipt2socks,ipv6-helper,kcptun,luci-app-adbyby-plus,luci-app-arpbind,luci-app-autoreboot,luci-app-baidupcs-web,luci-app-cifs-mount,luci-app-cpufreq,luci-app-familycloud,luci-app-filetransfer,luci-app-frpc,luci-app-n2n_v2,luci-app-nfs,luci-app-nft-qos,luci-app-nps,luci-app-ps3netsrv,luci-app-softethervpn,luci-app-usb-printer,luci-app-unblockmusic,luci-app-verysync,luci-app-vsftpd,luci-app-webadmin,luci-app-xlnetacc,luci-lib-fs,microsocks,n2n_v2,npc,pdnsd-alt,proxychains-ng,ps3netsrv,redsocks2,shadowsocksr-libev,simple-obfs,softethervpn5,srelay,tcpping,trojan,UnblockNeteaseMusic,UnblockNeteaseMusicGo,uugamebooster,v2ray,v2ray-plugin,verysync,vsftpd-alt,xray} "../../../lean"
#popd

# Add Project OpenWrt's autocore
pushd package/lean
rm -rf autocore
svn co https://github.com/project-openwrt/openwrt/branches/master/package/lean/autocore
svn co https://github.com/openwrt/packages/branches/master/net/zerotier
# Add luci-app-ssr-plus
git clone --depth=1 https://github.com/fw876/helloworld
rm -rf helloworld/luci-app-ssr-plus/po/zh_Hans
popd

# Clean Lean's code
#pushd package
#rm -rf lede
#popd

# Add luci-app-onliner. (need luci-app-nlbwmon)
pushd package/lean
git clone --depth=1 https://github.com/rufengsuixing/luci-app-onliner
svn co https://github.com/xiaorouji/openwrt-passwall/luci-app-passwall


# Add luci-theme-argon
#git clone --depth=1 https://github.com/jerrykuku/luci-theme-argon
#git clone --depth=1 https://github.com/jerrykuku/luci-app-argon-config


# Use immortalwrt's luci-app-netdata
svn co https://github.com/immortalwrt/immortalwrt/trunk/package/ntlf9t/luci-app-netdata
popd
# Add netdata
pushd feeds/packages/admin
rm -rf netdata
svn co https://github.com/immortalwrt/packages/trunk/admin/netdata
popd

# Change dnsmasq to dnsmasq-full
sed -i 's/dnsmasq/dnsmasq-full/g' include/target.mk

# Convert Translation
cp convert-translation.sh .
chmod +x ./convert-translation.sh
./convert-translation.sh || true

# Remove upx
cp remove-upx.sh .
chmod +x ./remove-upx.sh
./remove-upx.sh || true


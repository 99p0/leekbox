#!/usr/bin/python
import os

# 应用内测分发平台
_api_key="cee163bf3f0eb2c112e6e2f669539e55"
_uKey="77150b0da0686232503a11f481098194"

# 相对于项目的路径
_android_dir="/build/app/outputs/apk/release/app-armeabi-v7a-release.apk"

# 快速上传 Api
# curl -F "file=@`pwd`$_android_dir" \
# -F "uKey=$_uKey" \
# -F "_api_key=$_api_key" \
# -F "buildType=apk" \
# -F "oversea=2" \
# -F "buildInstallType=1" \
# -F "buildPassword=" \
# -F "buildDescription=习惯的坚持可以很大程度上增强自我的掌控力，进而增强自信心。颜值超高，图标也很可爱,免费且没有广告" \
# -F "buildUpdateDescription=" \
# -F "buildInstallDate=2" \
# "https://www.pgyer.com/apiv2/app/getCOSToken"


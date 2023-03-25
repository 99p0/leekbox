#!/usr/bin/python
import os
# flutter build apk --split-per-abi --release --obfuscate --split-debug-info ./build/split-debug-info
# flutter build apk --target-platform android-arm64 --release --obfuscate --split-debug-info ./build/split-debug-info
# flutter build apk --split-per-abi --target-platform android-arm64,android-arm --release --obfuscate --split-debug-info ./split-debug-info
# flutter build appbundle --target-platform  android-arm64,android-arm --release --obfuscate --split-debug-info ./split-debug-info

cmd = "flutter build apk --split-per-abi --release --obfuscate --split-debug-info ./build/split-debug-info"
os.system(cmd)
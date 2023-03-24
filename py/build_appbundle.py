#!/usr/bin/python
import os
cmd = "flutter build appbundle --split-per-abi --release --obfuscate --split-debug-info ./build/split-debug-info";
os.system(cmd);
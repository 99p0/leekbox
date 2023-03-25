#!/usr/bin/python
import os
cmd = "flutter build ipa --release --obfuscate --split-debug-info=./split-debug-info"
os.system(cmd)
#!/usr/bin/python3
import subprocess
import os
subprocess.run(["sudo", "docker", "compose", "pause"], stderr=subprocess.PIPE)
subprocess.run(["sudo", "docker", "compose", "unpause"], stderr=subprocess.PIPE)
subprocess.run(["sudo", "docker", "compose", "up"])


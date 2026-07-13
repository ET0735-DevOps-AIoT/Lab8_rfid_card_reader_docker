#!/usr/bin/env bash
# One-time setup for running main.py natively on the Raspberry Pi.
# The standard ET0735 lab Pi image already has these installed; run this
# only if "python main.py" fails with a missing module error.
set -e
cd "$(dirname "$0")"

# python3-setuptools: needed on Python 3.12+ where distutils was removed (PEP 632)
# python3-smbus:      I2C library for the LCD
# python3-rpi.gpio:   GPIO library for the LED / keypad
sudo apt-get install -y python3-setuptools python3-smbus python3-rpi.gpio

# Build and install the SPI driver for the RFID reader from the submodule
if [ ! -f SPI-Py/setup.py ]; then
    echo "SPI-Py submodule is missing - clone with: git clone --recurse-submodules <repo-url>"
    exit 1
fi
cd SPI-Py
sudo python3 setup.py install

echo
echo "Setup complete. You can now run:  python3 main.py"

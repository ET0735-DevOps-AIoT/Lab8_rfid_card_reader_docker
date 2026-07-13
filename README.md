# Lab 8 — Exercise 1: RFID Card Reader in a Docker Container

ET0735 DevOps for AIoT. Runs the RFID card reader (SPI) and LCD (I2C) on the
Raspberry Pi, first natively and then inside a Docker container.

## 1. Clone (this repo contains a submodule)

```bash
git clone --recurse-submodules https://github.com/ET0735-DevOps-AIoT/Lab8_rfid_card_reader_docker.git
```

## 2. Run natively on the Raspberry Pi

The RFID driver (`spi` module) comes from the **SPI-Py submodule** and must be
built and installed first:

```bash
# Needed on Python 3.12 or newer: distutils was removed from the standard
# library (PEP 632); setuptools provides a compatible replacement.
sudo apt install python3-setuptools

cd SPI-Py
sudo python3 setup.py install
cd ..

pip3 install smbus        # I2C LCD driver

python3 main.py           # tap an RFID card - its ID shows on the LCD
```

> **Note:** do not `pip install spi` — the `spi` package on PyPI is a
> different library that happens to share the module name. The RFID code
> needs SPI-Py from the submodule.

## 3. Build and run with Docker

```bash
docker build -t rfid_card_reader .
docker container run --privileged -d rfid_card_reader
```

`--privileged` is required because the container accesses the Raspberry Pi
hardware (SPI/I2C/GPIO) directly.

The provided Dockerfile installs the SPI driver only — completing it with the
remaining Python libraries needed by `main.py` is part of the exercise.

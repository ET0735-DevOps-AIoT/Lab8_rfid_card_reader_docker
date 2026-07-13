# Python Base Image from https://hub.docker.com/r/arm32v7/python/
FROM arm32v7/python:3
ENV SPI_PATH /app/SPI-Py
WORKDIR /app

# Copy SPI-Py driver to rfid_card_reader
COPY SPI-Py ./SPI-Py

# Install the relevant modules required

# Python 3.12+ removed distutils (PEP 632), which SPI-Py's setup.py imports;
# setuptools provides a compatible replacement
RUN pip install setuptools

# Install SPI driver
WORKDIR $SPI_PATH
RUN python3 setup.py install

# Trigger Python script
WORKDIR /app
CMD ["python3", "./main.py"]

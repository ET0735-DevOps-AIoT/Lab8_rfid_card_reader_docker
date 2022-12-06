# Python Base Image from https://hub.docker.com/r/arm32v7/python/
FROM arm32v7/python:3

# Copy the main.py and HAL folder to blink LED
COPY main.py ./
COPY hal ./hal

# Intall the rpi.gpio python module
RUN pip3 install --no-cache-dir rpi.gpio
RUN pip3 install --no-cache-dir smbus==1.1.post2


# Trigger Python script
CMD ["python3", "./main.py"]

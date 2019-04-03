'''
Simple script to test the thruster system with a Raspberry pi.
'''

from board import SCL, SDA
import busio
import time
from adafruit_pca9685 import PCA9685


'''
This function corrects for the misgivings of the optocoupler that we are using. For one, it inverts our output. Therefore, when enable is true (controlled by us, set to true when sending signal through the optocoupler), we invert our input. It also has a rise and fall time which shortens the pulse width of our signal, so fudge_factor adds back to that. Found via experimentation or by estimating rise/fall times (65535 * <ESTIMATED RISE/FALL TIME IN MS>/20ms)
'''


def invert(pulse_length, enable, fudge_factor):
    return (0xffff - pulse_length - fudge_factor) if enable else (pulse_length + fudge_factor)


# Create the I2C bus interface.
i2c_bus = busio.I2C(SCL, SDA)

# Create a simple PCA9685 class instance.
pca = PCA9685(i2c_bus)

# Set the PWM frequency to 50hz.
pca.frequency = 50

# Set channel of PWM module
c = 3

# Set for `invert` function
enable = True
fudge_factor = 0x0090

# Initialization is setting pulse width to 1.5 ms and waiting a bit
pca.channels[c].duty_cycle = invert(0x1333, enable, fudge_factor)
time.sleep(7)

# Run the thruster through some fun!
pca.channels[c].duty_cycle = invert(0x1851, enable, fudge_factor)
time.sleep(9)

pca.channels[c].duty_cycle = invert(0x1333, enable, fudge_factor)
time.sleep(3)

# Turn thruster back to zero
pca.channels[c].duty_cycle = invert(0x0000, enable, 0x0000)

# UBCSubbots ELECTRICAL TEAM

Newspaper eating contest 2x champions

--

## Major Subsystems

### Thruster System

Write Up Written (Pull Request Up)

### Battery Monitor

* Diagram (including 3.6 V source^1 for comparators, buffers out of battery, debounce/smoothing (lowpass filter?))
* Writeup (explaining purpose, functionality of circuit, how to create etc)

### Relays/Kill Switch

* Nosotros tienen las cambiar muertas
* Diagram/Write up

### Cameras/IMU

* Just hook it up (? all USB)

### Sensor (Pressure, Leak)

* These are both reading I2C - this is up to you.

### Safety

#### Current safety

* Place fuses that are slighty below the max current of the component in front of sensitive components, at battery, TX2, PWM module, relays. Not required for IMU, cameras, I2C connections (powered from TX2)

#### Voltage safety

* Zener diode to ground for signal line, Varsiter for power lines

#### Noise

* Capacitors from higher voltage lines to ground: ceramic (~100 nF) on high frequency lines, electrolytic on high current lines
* Twisting opposing lines on same circuit (e.g. lines to power & ground)
* Ground loops (incl. physical seperation)
* HIGH QUALITY SOLDER JOINTS
* Shielded/Fat MULTICORE WIRES
* Software Debouncing

### Extra Considerations

* README on best practices of electrical design
* PULL TEST

^1: 3.6 V source is voltage divider out from 5 volt regulator

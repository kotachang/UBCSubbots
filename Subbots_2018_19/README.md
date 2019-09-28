# UBCSubbots ELECTRICAL TEAM

Newspaper eating contest 2x champions

---

## Major Subsystems

### Thruster System

Writeup complete

### Battery Monitor

Writeup Complete

### Relays/Kill Switch

* Diagram/Write up

### Cameras/IMU

* Writeup Complete

### Sensor (Pressure, Leak)

* Writeup Complete

---

### Circuit Safety Considerations

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


## Verilog and Xilinx ISE Webpack project files for a GPS -> SPI Bridge

```
Inputs         

(From GPS chip)

GPS_I0
GPS_I1
GPS_Q0
GPS_Q1
GPS_CLK_16_368     (GPS data clock)

(From MCU)
RESET_N
MCU_CLK_25_000     (25Mhz Clock)

(Optional or tie high, see Seeed Studio board)
BUTTON_N,

Outputs       

(To MCU) 

MCU_MISO
MCU_CLK
MCU_SS

(For testing on Seeed studio board)
LED_D1,
LED_D2,

```

### Pin Selection

See file:

./src/devices/bridge-xc2c64a.ucf

This is specific to the xc2c64a breakout board

| Name            | CPLD Pin | Note        |
|:---------------:|:--------:|:-----------:|
| BUTTON_N        | P18      | Pullup      |
| GPS_CLK_16_368  | P37      |             |
| GPS_I0          | P40      |             |
| GPS_I1          | P41      |             |
| GPS_Q0          | P42      |             |
| GPS_Q1          | P43      |             |
| MCU_CLK_25_000  | P16      |             |
| MCU_MOSI        | P14      |             |
| MCU_SCK         | P12      |             |
| MCU_SS          | P13      |             |
| RESET_N         | P30      |             |
| LED_D1          | P39      |             |
| LED_D2          | P38      |             |

LVCMOS33 standard I/O voltages




## References

* http://www.seeedstudio.com/depot/XC2C64A-CoolRunnerII-CPLD-development-board-p-800.html
* http://dangerousprototypes.com/docs/CoolRunner-II_CPLD_breakout_board

## Programming

### Using Bus Pirate

* Follow the above references to the instructions on how to use Bus Pirate to 'play' a .xsvf file.

### Using Olimex ARM-USB-OCD

* In toolchain/openocd directory there is a file called olimex_coolrunner.cfg

* Connect JTAG device.
* Put power the board

In one terminal window execute:

```
~/.../gps-cpld/toolchain/openocd (master*) > sudo openocd -f olimex_coolrunner.cfg 
Open On-Chip Debugger 0.8.0 (2014-04-29-15:41)
Licensed under GNU GPL v2
For bug reports, read
	http://openocd.sourceforge.net/doc/doxygen/bugs.html
adapter speed: 1000 kHz
Info : only one transport option; autoselect 'jtag'
Info : clock speed 1000 kHz
Warn : There are no enabled taps.  AUTO PROBING MIGHT NOT WORK!!
Warn : AUTO auto0.tap - use "jtag newtap auto0 tap -expected-id 0x06e5e093 ..."
Warn : AUTO auto0.tap - use "... -irlen 2"
Error: IR capture error at bit 2, saw 0x3FFFFFFFFFFFFF05 not 0x...3
Warn : Bypassing JTAG setup events due to errors
Warn : gdb services need one or more targets defined
Info : accepting 'telnet' connection from 4444


```

* In another terminal window:

```
~/.../gps-cpld/toolchain/openocd (master*) > telnet localhost 4444
Trying ::1...
Connection failed: Connection refused
Trying 127.0.0.1...
Connected to localhost.
Escape character is '^]'.
Open On-Chip Debugger
>  xsvf plain ./bridge.xsvf
xsvf processing file: "./bridge.xsvf"
XSVF file programmed successfully
> 

```

* n.b.: The programming file bridge.xsvf should be in the same directory as where you execute these commands.





## Binary Files

The Release directory contains the latest binary file. The toolchain directory
has a link to this file.

Please do not check in the ISE Webpack files in the proj directory.

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

### Using the UM232H board

* Board reference
  * http://www.ftdichip.com/Support/Documents/DataSheets/Modules/DS_UM232H.pdf

* Find this program on sourceforge called xc3sprog
  * http://xc3sprog.sourceforge.net/

* Download and build the source as shown on link 
  * http://xc3sprog.sourceforge.net/guide.php


* Command line

```
./xc3sprog -c ft232h -v -p 0 -m ./xbr bridge.jed
```

#### Pinout notes for using the FTDI UM232H to program the CoolRunner-II CPLD:

* On the UM232H, loop 5V0 back to USB to give it power.

|UM232| CPLD|
|:---:|:---:|
| AD0 | TCK |
| AD1 | TDI |
| AD2 | TDO |
| AD3 | TMS |
| GND | GND |

#### Notes

* bridge.jed is the compiled CPLD design from ISE Xilinx software.
* -m ./xbr is the directory containing the map file: xc2c64a.map
* -p 0 is 'position 0' (Maybe means 'whole chip'- more research required)
* -c ft232h defines which chip xc3sprog is communicating across

* Help command

```
~/Projects/xc3sprog  > ./xc3sprog --help
XC3SPROG (c) 2004-2011 xc3sprog project $Rev: 768 $ OS: Linux
Free software: If you contribute nothing, expect nothing!
Feedback on success/failure/enhancement requests:
	http://sourceforge.net/mail/?group_id=170565 
Check Sourceforge for updates:
	http://sourceforge.net/projects/xc3sprog/develop

./xc3sprog: invalid option -- '-'
Unknown option -?
usage:	xc3sprog -c cable [options] <file0spec> <file1spec> ...
	List of known cables is given with -c follow by no or invalid cablename
	filespec is filename:action:offset:style:length
	action on of 'w|W|v|r|R'
	w: erase whole area, write and verify
	W: Write with auto-sector erase and verify
	v: Verify device against filename
	r: Read from device,write to file, don't overwrite existing file
	R: Read from device and write to file, overwrite existing file
	Default action is 'w'

	Default offset is 0

	style: One of BIT|BIN|BPI|MCS|IHEX|HEX
	BIT: Xilinx .bit format
	BIN: Binary format
	BPI: Binary format not bit reversed
	MCS: Intel Hex File, LSB first
	IHEX: INTEL Hex format, MSB first (Use for Xilinx .mcs files!)
	HEX:  Hex dump format
	Default for FPGA|SPI|XCF is BIT
	Default for CPLD is JED
	Default for XMEGA is IHEX
	Default length is whole device

Possible options:
   -p val[,val...]  Use device at JTAG Chain position <val>.
             Default (0) is device connected to JTAG Adapter TDO.
   -e        Erase whole device.
   -h        Print this help.
   -I[file]  Work on connected SPI Flash (ISF Mode),
             after loading 'bscan_spi' bitfile if given.
   -j        Detect JTAG chain, nothing else (default action).
   -l        Program lockbits if defined in fusefile.
   -m <dir>  Directory with XC2C mapfiles.
   -R        Try to reconfigure device(No other action!).
   -T val    Test chain 'val' times (0 = forever) or 10000 times default.
   -J val    Run at max with given JTAG Frequency, 0(default) means max. Rate of device
             Only used for FTDI cables for now
   -D        Dump internal devlist and cablelist to files
             In ISF Mode, test the SPI connection.
   -X opts   Set options for XCFxxP programming
   -v        Verbose output.

Programmer specific options:
   -d        (pp only     ) Parallel port device.
   -s num    (usb devices only) Serial number string.
   -L        (ftdi only       ) Don't use LibUSB.

Device specific options:
   -E file   (AVR only) EEPROM file.
   -F file   (AVR only) File with fuse bits.
~/Projects/xc3sprog  > 

```


### Using Olimex ARM-USB-OCD

* In toolchain/openocd directory there is a file called olimex_coolrunner.cfg

* Connect JTAG device.
* Put power the board

You might need to sudo if you haven't added udev rules for 15ba:0003 Olimex Ltd. OpenOCD JTAG
In one terminal window execute:

```
~/.../gps-cpld/toolchain/openocd (master*) > openocd -f olimex_coolrunner.cfg -c init -c "xsvf plain ./bridge.xsvf" -c shutdown
Open On-Chip Debugger 0.8.0 (2014-08-14-16:28)
Licensed under GNU GPL v2
For bug reports, read
	http://openocd.sourceforge.net/doc/doxygen/bugs.html
adapter speed: 1000 kHz
Info : only one transport option; autoselect 'jtag'
Info : clock speed 1000 kHz
Warn : There are no enabled taps.  AUTO PROBING MIGHT NOT WORK!!
Warn : AUTO auto0.tap - use "jtag newtap auto0 tap -expected-id 0x06e5e093 ..."
Warn : AUTO auto0.tap - use "... -irlen 8"
Warn : gdb services need one or more targets defined
xsvf processing file: "./bridge.xsvf"
XSVF file programmed successfully
```

* n.b.: The programming file bridge.xsvf (or a symlink to it) should be in the same directory as where you execute these commands.



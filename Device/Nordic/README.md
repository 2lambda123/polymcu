Nordic Specific Configuration
-----------------------------

NORDIC_I2C_SCL_PIN
NORDIC_I2C_SDA_PIN


Systick
-------

_Important Note:_ On nRF52, Nordic turns off Systick during sleep to ensure that the power consumption is low. 
It means the CPU would not be able to be woken up for a Systick interrupt.

Configure Nordic SoftDevice Memory Consumption
----------------------------------------------

Set `NORDIC_SOFTDEVICE_RAM_SIZE` to define how much memory Nordic SoftDevice consumes.

Requirements
------------

Download & Install Segger tool from https://www.segger.com/jlink-software.html

Use with two boards
-------------------

Define the environment variable $NORDIC_BOARD
```
J-Link>rconf
Total size of config area: 0x100 bytes

00000000 = 00 01 FF FF FF FF FF FF FF FF FF FF FF FF FF FF 
00000010 = FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF 
00000020 = FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF 
00000030 = FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF 
00000040 = FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF 
00000050 = FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF 
00000060 = FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF 
00000070 = FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF 
00000080 = FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF 
00000090 = FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF 
000000A0 = FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF 
000000B0 = FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF 
000000C0 = FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF 
000000D0 = FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF 
000000E0 = FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF 
000000F0 = FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF 

J-Link> wconf 0 02	// Set USB-Address 2
J-Link> wconf 1 00	// Set enumeration method to USB-Address

J-Link>rconf
Total size of config area: 0x100 bytes

00000000 = 02 00 FF FF FF FF FF FF FF FF FF FF FF FF FF FF 
00000010 = FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF 
00000020 = FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF 
00000030 = FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF 
00000040 = FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF 
00000050 = FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF 
00000060 = FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF 
00000070 = FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF 
00000080 = FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF 
00000090 = FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF 
000000A0 = FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF 
000000B0 = FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF 
000000C0 = FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF 
000000D0 = FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF 
000000E0 = FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF 
000000F0 = FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF 
```

Debug
-----

1. `JLinkGDBServer -if SWD -device nrf52`
2.
```
arm-none-eabi-gdb <PolyMCU-root>/Build/nordic/Application/Examples/Baremetal/Baremetal_Example.elf
target remote localhost:2331
```

* To get the `assert()` properly you might need to rebuild with `-DNORDIC_UART_FIFO=0`

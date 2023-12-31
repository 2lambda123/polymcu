Introduction
============

[PolyMCU](http://labapart.com/products/polymcu) has been designed from the beginning to be as flexible as possible: **host OS independent** (support Linux, Windows, MacOS), **support any toolchain** (GCC, LLVM), **any RTOS** (ARM RTX, FreeRTOS), **any micro-controller vendor SDK** (Nordic Semiconductor, NXP, Freescale, ST).  
Enabling such flexibility provides by the same time better software quality by testing the same piece of software in various configurations.
It supports [C](Application/Examples/Baremetal/main.c) and [C++](Application/Examples/Baremetal/main.cpp) languages.

The framework is based on [CMake](https://cmake.org/). It provides some examples to build baremetal and RTOS-based projects. 
In opposition to ARM mBed that provides its own library, PolyMCU used [Newlib](https://sourceware.org/newlib/). 
No new interface layout has been introduced in the framework. The abstraction layout for ARM architecture is driven by **ARM CMSIS v3.0**. 

Quick start
===========

- For AppNearMe's MicroNFCBoard: [here](/Board/AppNearMe/README.md)
- To port a new vendor SDK to PolyMCU: [here](/Doc/PortVendorSDK.md)
- Build & Install CMSIS RTOS Conformance test: [here](/Application/LabAPart/CMSIS_RTOS_Conformance/README.md)

Support
=======

- **CMake - version 2.8**
- Toolchains:
	- **GCC**: 4.9-2014: https://launchpad.net/gcc-arm-embedded/4.9/4.9-2014-q4-major
	- **Clang**: 3.6.0-2ubuntu1~trusty1 (tags/RELEASE_360/final) (based on LLVM 3.6.0)
- RTOS:
	- **ARM RTX: V4.79**
	- **FreeRTOS V8.2.3**
	- **RioT-OS 2015.09**
- Boards:
	- AppNearMe MicroNFCBoard
	- Freescale Freedom KL25
	- Nordic nRF52 Preview DK
	- NXP LP1768 mbed
	- ST STM32L476 Nucleo

- Features:
	- The application defined by `APPLICATION` can live out of the PolyMCU tree if `APPLICATION` defined an absolute path.

Status
======

The latest test results are available at http://labapart.com/products/polymcu/test_results.

Toolchain / Host
----------------

| Board                    | Linux - GCC  | Linux - LLVM  | Windows    |
|--------------------------|--------------|---------------|------------|
| AppNearMe MicroNFCBoard  | Pass         | Pass          | Pass       |
| Freescale Freedom KL25   | Pass         | Pass          | Pass       |
| Nordic nRF52 Preview DK  | Pass         | Pass          | Pass       |
| NXP LP1768 mbed          | Pass         | Pass          | Pass       |
| ST STM32L476 Nucleo      | Pass         | Pass          | _Not Tested_ |

Application
-----------

| Board                    | Baremetal  | CMSIS RTOS  | FreeRTOS   |
|--------------------------|------------|-------------|------------|
| AppNearMe MicroNFCBoard  | Pass       | Pass        | **Fail**   |
| Freescale Freedom KL25   | Pass       | Pass        | Pass       |
| Nordic nRF52 Preview DK  | Pass       | Pass        | Pass       |
| NXP LP1768 mbed          | Pass       | Pass        | Pass       |
| ST STM32L476 Nucleo      | Pass       | Pass        | Pass       |

Building on Linux
=================

The cross compilation toolchain is either in your `PATH` or defined by the environment variable `CROSS_COMPILE`.
The latest cross-compilation toolchain for ARM Cortex-M can be found at https://launchpad.net/gcc-arm-embedded.

It is recommended to build out of tree. To do that, create a new directory:
```
mkdir Build && cd Build
```

* Case when the application can support multiple board:
```
cmake -DAPPLICATION=<application_vendor/application_name> -DBOARD=<board_vendor/board_name> ../ && make
```

* Case when the application targets only a specific board:
```
cmake -DAPPLICATION=<application_vendor/application_name> ../ && make
```

* To build a release build:
```
cmake -DAPPLICATION=<application_vendor/application_name> -DCMAKE_BUILD_TYPE=Release ../ && make
```

* To make the build verbose:
```
cmake -DAPPLICATION=<application_vendor/application_name> ../ && make VERBOSE=1
```

* To build with Clang:
```
CC=<path-to-clang> cmake -DAPPLICATION=<application_vendor/application_name> ../ && make
```

Building on Windows
===================

Requirements
------------
- Install CMake: https://cmake.org/download/ 
- Install the latest GCC v4.9 2015q3 for ARM Cortex M: https://launchpad.net/gcc-arm-embedded/4.9/4.9-2015-q3-update/+download/gcc-arm-none-eabi-4_9-2015q3-20150921-win32.zip 
- Install MinGW: http://sourceforge.net/projects/mingw/files/Installer/mingw-get-setup.exe/download (mingw32-base, mingw32-gcc-g++)

Build
-----

1. Download the latest sources of PolyMCU at https://github.com/labapart/polymcu/archive/master.zip

2. Un-archive `master.zip`

3. Start a command line shell (ie: `cmd.exe`)

4. Add CMake and MinGW to your `PATH` if it is not already done. For instance:
```
SET PATH="c:\Program Files (x86)\CMake\bin";%PATH%
SET PATH=C:\MinGW\bin;%PATH%
```

5. Add your toolchain into the `CROSS_COMPILE`. For instance:
```
SET CROSS_COMPILE=c:\Users\Olivier\gcc-arm-none-eabi-4_9-2015q3-20150921-win32\bin\arm-none-eabi-
```

6. Create the `Build` directory into PolyMCU root
```
cd <PolyMCU Root>
mkdir Build
cd Build
```

7. **[Optional]** To build with LLVM
```
set PATH="C:\Program Files (x86)\LLVM\bin";%PATH%
set CC=clang.exe
```

8. Build the project
```
cmake -G "MinGW Makefiles" -DAPPLICATION=<application_vendor/application_name> -DBOARD=<board_vendor/board_name> ..
mingw32-make
```

* To make the build verbose: `mingw32-make VERBOSE=1`


Support
=======

All CMake variables that do not start with `CMAKE_` and `_` are defined in `${CMAKE_BINARY_DIR}/polymcu_config.h`
which is generated at build time.  
This include file can be included in your project to access CMake configuration variables.

Basic variables
---------------

| CMake variable                  | Value      | Description                                       |
|---------------------------------|------------|---------------------------------------------------|
| FIRMWARE_HEAP	                  | integer    | Size in bytes of the firmware heap                |
| FIRMWARE_STACK	              | integer    | Size in bytes of the firmware stack               |
| SUPPORT_RUN_FROM_RAM            | (0\|1)      | Define the firmware must be built to run from RAM
| EXTERNAL_PROJECT_IN_BINARY_DIR  | (0\|1)      | Build the external project into the binary directory instead of the source directory |
| SUPPORT_DEBUG_UART              | (none\|itm\|usb\|1) | Define which UART support to use for debugging  |
| DEBUG_UART_BAUDRATE             | integer    | Debug UART Baud Rate (default: 115200)            |
| SUPPORT_TIMER                   | (0\|1)     | Add PolyMCU Timer API                             |
| SUPPORT_TIMER_SYSTICK           | (0\|1)     | Use SysTick for PolyMCU Timer API (default:1)     |
| TIMER_TASK_MAX                  | integer    | Number maximum of PolyMCU Timer tasks (default: 5) |
| SUPPORT_RTOS                    | string     | Enable RTOS support with the name of specified RTOS |
| SUPPORT_WATCHDOG                | (0\|1)     | Add PolyMCU Watchdog API                          |
| SUPPORT_RAM_VECTOR_TABLE        | (0\|1)     | Tell if the Vector Table lives in RAM             |

Device variables
----------------

| CMake variable                  | Value      | Description                                        |
|---------------------------------|------------|----------------------------------------------------|
| SUPPORT_DEVICE_USB              | (0\|1)      | Add USB Device support                            |
| SUPPORT_DEVICE_USB_SERIAL       | (0\|1)      | Add Serial USB Device support                     |
| SUPPORT_DEVICE_USB_HID          | (0\|1)      | Add HID USB Device support                        |
| SUPPORT_DEVICE_USB_DFU          | (0\|1)      | Add DFU USB Device support                        |
| SUPPORT_DEVICE_USB_MSC          | (0\|1)      | Add MSC USB Device support                        |
| SUPPORT_BLE_CENTRAL             | (0\|1)      | Add Bluetooth Low Energy (BLE) Central support    |
| SUPPORT_BLE_PERIPHERAL          | (0\|1)      | Add Bluetooth Low Energy (BLE) Peripheral support |
| SUPPORT_I2C                     | (0\|1)      | Add I2C support                                   |
| SUPPORT_SPI                     | (0\|1)      | Add SPI support                                   |

### USB Specific Variables

| CMake variable                  | Value      | Description                                        |
|---------------------------------|------------|----------------------------------------------------|
| DEVICE_USB_VENDOR_ID            | integer    | USB Vendor ID                                      |
| DEVICE_USB_PRODUCT_ID           | integer    | USB Product ID                                     |
| DEVICE_USB_DEVICE_REVISION      | integer    | USB Device Revision                                |
| DEVICE_USB_DEVICE_MANUFACTURER  | string     | USB Device Manufacturer string                     |
| DEVICE_USB_DEVICE_PRODUCT       | string     | USB Device Product string                          |
| DEVICE_USB_DEVICE_SERIAL        | string     | USB Device Serial Number string                    |
| DEVICE_USB_HID_INPUT_REPORT_SIZE   | integer | Size of the USB HID Input Report                   |
| DEVICE_USB_HID_OUTPUT_REPORT_SIZE  | integer | Size of the USB HID Output Report                  |
| DEVICE_USB_HID_FEATURE_REPORT_SIZE | integer | Size of the USB HID Feature Report                 |

RTOS variables
--------------

| CMake variable                  | Value      | Description                                       |
|---------------------------------|------------|---------------------------------------------------|
| SUPPORT_RTOS_NO_CMSIS           | (0\|1)     | Disable CMSIS wrapper of the RTOS.                |
| RTOS_CLOCK                      | integer    | Frequency in Hz of the processor                  |
| RTOS_TICK                       | integer    | When OS_SYSTICK is not set we might need to provide a different tick |
| RTOS_TASK_COUNT                 | integer    | Number of RTOS task                               |
| RTOS_TASK_STACK_SIZE            | integer    | Size in bytes of the task (excluding the main and private tasks) |
| RTOS_MAIN_STACK_SIZE            | integer    | Size in bytes of the main task                    |
| RTOS_IDLE_STACK_SIZE            | integer    | Size in bytes of the idle task                    |
| RTOS_TIMER_STACK_SIZE           | integer    | Size in bytes of the timer task                   |
| RTOS_TIMER_CALLBACK_COUNT       | integer    | Number of concurrent active timer callback functions |
| RTOS_TASK_PRIVATE_STACK_COUNT   | integer    | Number of private tasks                           |
| RTOS_TASK_PRIVATE_STACK_SIZE    | integer    | Size in bytes of the private task                 |
| RTOS_STACK_WATERMARK            | (0\|1)     | Disable/Enable the stack watermark                |

Device Specific variables
-------------------------

| CMake variable                  | Value      | Description                                       |
|---------------------------------|------------|---------------------------------------------------|
| SUPPORT_NXP_USE_XTAL            | (0\|1)     | Use external oscillator instead of the internal one |

Debug
=====

Run an application from RAM
---------------------------

To build the firmware to run from RAM:

    cmake -DAPPLICATION=<application_vendor/application_name> -DSUPPORT_RUN_FROM_RAM=1 .. && make

Debug with GDB
--------------

1. Start the debugger server
```
pyocd-gdbserver
```

2. Start the GDB client
```
arm-none-eabi-gdb <filepath_of_the_ELF_application>
target remote localhost:3333
continue
```

* Examples of some GDB commands:
```
(gdb) print $pc
$1 = (void (*)()) 0x200000d8
(gdb) print $sp
$2 = (void *) 0x1fffff58
(gdb) print/x *0x400
$3 = 0x21004692
(gdb) set {int}0x20000000 = 1
```

```
(gdb) set arm force-mode thumb
(gdb) display /10i 0x0
1: x/10i 0x0
   0x0 <__Vectors>:	strh	r0, [r0, #0]
   0x2 <__Vectors+2>:	movs	r0, #0
   0x4 <__Vectors+4>:	lsls	r1, r1, #24
   0x6 <__Vectors+6>:	movs	r0, r0
   0x8 <__Vectors+8>:	lsls	r1, r7, #24
   0xa <__Vectors+10>:	movs	r0, r0
   0xc <__Vectors+12>:	adds	r0, #37	; 0x25
   0xe <__Vectors+14>:	movs	r0, r0
   0x10 <__Vectors+16>:	movs	r0, r0
   0x12 <__Vectors+18>:	movs	r0, r0
(gdb) display /10i $pc
2: x/10i $pc
=> 0x1a96 <ARM_USART_Send+18>:	ldr	r3, [sp, #16]
   0x1a98 <ARM_USART_Send+20>:	ldrb	r3, [r3, #0]
   0x1a9a <ARM_USART_Send+22>:	mov	r0, r3
   0x1a9c <ARM_USART_Send+24>:	bl	0x2da8 <app_uart_put>
   0x1aa0 <ARM_USART_Send+28>:	str	r0, [sp, #12]
   0x1aa2 <ARM_USART_Send+30>:	ldr	r3, [sp, #12]
   0x1aa4 <ARM_USART_Send+32>:	cmp	r3, #0
   0x1aa6 <ARM_USART_Send+34>:	bne.n	0x1a96 <ARM_USART_Send+18>
   0x1aa8 <ARM_USART_Send+36>:	ldr	r3, [sp, #16]
   0x1aaa <ARM_USART_Send+38>:	adds	r3, #1
```

- Dump memory into a file:
```
(gdb) dump binary memory /tmp/gdb.bin 0x0 0x1000
```

Debug UART Settings
===================

All the board UARTs are set with the following settings:

- Baud Rate: 115200
- Data Bits: 8
- Stop Bits: 1
- Parity: None
- Flow Control: None

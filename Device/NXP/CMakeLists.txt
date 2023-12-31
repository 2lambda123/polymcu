#
# Copyright (c) 2015-2016, Lab A Part
# All rights reserved.
#
# Redistribution and use in source and binary forms, with or without
# modification, are permitted provided that the following conditions are met:
#
# * Redistributions of source code must retain the above copyright notice, this
#  list of conditions and the following disclaimer.
#
# * Redistributions in binary form must reproduce the above copyright notice,
#   this list of conditions and the following disclaimer in the documentation
#   and/or other materials provided with the distribution.
#
# THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
# AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
# IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
# DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE
# FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL
# DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR
# SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER
# CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY,
# OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
# OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
#

cmake_minimum_required(VERSION 2.8)

find_package(Board)
find_package(CMSIS)
find_package(PolyMCU)
find_package(NXP)

# We define __REDLIB__ to avoid cr_startup_lpc11uxx.c entrypoint to directly call main()
# to redirect to __main()
add_definitions(-D__REDLIB__ -D__CODE_RED)

if(MCU_DEVICE STREQUAL lpc_chip_11uxx)
  # Add support for MCU romdivide library
  #add_definitions(-D__USE_ROMDIVIDE)

  # LPC11Uxx has USB API ROM
  add_definitions(-DSUPPORT_NXP_ROMAPI_USB)

  # Use main oscillator instead of the internal one
  add_definitions(-DSUPPORT_NXP_MAIN_OSC)

  set(nxp_SRCS ${MCU_DEVICE}/src/adc_11xx.c
               ${MCU_DEVICE}/src/chip_11xx.c
               ${MCU_DEVICE}/src/cr_startup_lpc11xx.c
               ${MCU_DEVICE}/src/clock_11xx.c
               ${MCU_DEVICE}/src/gpio_11xx_1.c
               ${MCU_DEVICE}/src/gpio_11xx_2.c
               ${MCU_DEVICE}/src/gpiogroup_11xx.c
               ${MCU_DEVICE}/src/i2c_11xx.c
               ${MCU_DEVICE}/src/i2cm_11xx.c
               ${MCU_DEVICE}/src/iap.c
               ${MCU_DEVICE}/src/iocon_11xx.c
               ${MCU_DEVICE}/src/pinint_11xx.c
               ${MCU_DEVICE}/src/pmu_11xx.c
               ${MCU_DEVICE}/src/ring_buffer.c
               ${MCU_DEVICE}/src/ssp_11xx.c
               ${MCU_DEVICE}/src/sysctl_11xx.c
               ${MCU_DEVICE}/src/sysinit.c
               ${MCU_DEVICE}/src/sysinit_11xx.c
               ${MCU_DEVICE}/src/timer_11xx.c
               ${MCU_DEVICE}/src/uart_11xx.c
               ${MCU_DEVICE}/src/wwdt_11xx.c)
               #${MCU_DEVICE}/src/aeabi_romdiv_patch.s)

  # Add UART support over the UART port if it is not over USB
  if(NOT SUPPORT_DEBUG_UART STREQUAL "none")
    if(NOT SUPPORT_DEBUG_UART STREQUAL "usb")
      list(APPEND nxp_SRCS Driver/uart_debug/Driver_USART.c)
    endif()
  endif()
elseif(MCU_DEVICE STREQUAL lpc_chip_11u6x)
  # Add support for MCU romdivide library
  #add_definitions(-D__USE_ROMDIVIDE)

  # LPC11U6x has USB API ROM
  add_definitions(-DSUPPORT_NXP_ROMAPI_USB)

  # Use main oscillator instead of the internal one
  add_definitions(-DSUPPORT_NXP_MAIN_OSC)

  set(nxp_SRCS ${MCU_DEVICE}/src/adc_11u6x.c
               ${MCU_DEVICE}/src/chip_11u6x.c
               ${MCU_DEVICE}/src/clock_11u6x.c
               ${MCU_DEVICE}/src/crc_11u6x.c
               ${MCU_DEVICE}/src/cr_startup_lpc11u6x.c
               ${MCU_DEVICE}/src/dma_11u6x.c
               ${MCU_DEVICE}/src/gpio_11u6x.c
               ${MCU_DEVICE}/src/gpiogroup_11u6x.c
               ${MCU_DEVICE}/src/i2c_11u6x.c
               ${MCU_DEVICE}/src/i2cm_11u6x.c
               ${MCU_DEVICE}/src/iocon_11u6x.c
               ${MCU_DEVICE}/src/pinint_11u6x.c
               ${MCU_DEVICE}/src/pmu_11u6x.c
               ${MCU_DEVICE}/src/ring_buffer.c
               ${MCU_DEVICE}/src/romdiv_11u6x.c
               ${MCU_DEVICE}/src/rtc_11u6x.c
               ${MCU_DEVICE}/src/sct_11u6x.c
               ${MCU_DEVICE}/src/ssp_11u6x.c
               ${MCU_DEVICE}/src/stopwatch_11u6.c
               ${MCU_DEVICE}/src/syscon_11u6x.c
               ${MCU_DEVICE}/src/sysinit_11u6x.c
               ${MCU_DEVICE}/src/sysinit.c
               ${MCU_DEVICE}/src/timer_11u6x.c
               ${MCU_DEVICE}/src/uart_0_11u6x.c
               ${MCU_DEVICE}/src/uart_n_11u6x.c
               ${MCU_DEVICE}/src/wwdt_11u6x.c)

  # Add UART support over the UART port if it is not over USB
  if(NOT SUPPORT_DEBUG_UART STREQUAL "none")
    if(NOT SUPPORT_DEBUG_UART STREQUAL "usb")
      list(APPEND nxp_SRCS Driver/uart_debug/Driver_USART.c)
    endif()
  endif()
elseif(MCU_DEVICE STREQUAL lpc_chip_175x_6x)
  set(nxp_SRCS ${MCU_DEVICE}/src/adc_17xx_40xx.c
               ${MCU_DEVICE}/src/can_17xx_40xx.c
               ${MCU_DEVICE}/src/clock_17xx_40xx.c
               ${MCU_DEVICE}/src/cmp_17xx_40xx.c
               ${MCU_DEVICE}/src/crc_17xx_40xx.c
  			   ${MCU_DEVICE}/src/chip_17xx_40xx.c
               ${MCU_DEVICE}/src/cr_startup_lpc175x_6x.c
               ${MCU_DEVICE}/src/dac_17xx_40xx.c
               ${MCU_DEVICE}/src/eeprom_17xx_40xx.c
               ${MCU_DEVICE}/src/emc_17xx_40xx.c
               ${MCU_DEVICE}/src/enet_17xx_40xx.c
  			   ${MCU_DEVICE}/src/gpdma_17xx_40xx.c
  			   ${MCU_DEVICE}/src/gpio_17xx_40xx.c
  			   ${MCU_DEVICE}/src/gpioint_17xx_40xx.c
  			   ${MCU_DEVICE}/src/i2c_17xx_40xx.c
  			   ${MCU_DEVICE}/src/i2s_17xx_40xx.c
  			   ${MCU_DEVICE}/src/iap.c
  			   ${MCU_DEVICE}/src/iocon_17xx_40xx.c
  			   ${MCU_DEVICE}/src/lcd_17xx_40xx.c
  			   ${MCU_DEVICE}/src/pmu_17xx_40xx.c
  			   ${MCU_DEVICE}/src/ring_buffer.c
  			   ${MCU_DEVICE}/src/ritimer_17xx_40xx.c
  			   ${MCU_DEVICE}/src/rtc_17xx_40xx.c
  			   ${MCU_DEVICE}/src/sdc_17xx_40xx.c
  			   ${MCU_DEVICE}/src/sdmmc_17xx_40xx.c
  			   ${MCU_DEVICE}/src/spi_17xx_40xx.c
  			   ${MCU_DEVICE}/src/ssp_17xx_40xx.c
  			   ${MCU_DEVICE}/src/stopwatch_17xx_40xx.c
  			   ${MCU_DEVICE}/src/sysctl_17xx_40xx.c
  			   ${MCU_DEVICE}/src/sysinit.c
               ${MCU_DEVICE}/src/sysinit_17xx_40xx.c
               ${MCU_DEVICE}/src/timer_17xx_40xx.c
               ${MCU_DEVICE}/src/wwdt_17xx_40xx.c)

  # UART support
  if(NOT SUPPORT_DEBUG_UART STREQUAL "none")
    list(APPEND nxp_SRCS Driver/uart_debug/Driver_USART.c
                         ${MCU_DEVICE}/src/uart_17xx_40xx.c)
  endif()
endif()

if(SUPPORT_RAM_VECTOR_TABLE)
  add_definitions(-DSUPPORT_RAM_VECTOR_TABLE)
endif()

#
# NXP USBD ROM Support
#
if(SUPPORT_DEVICE_USB)
  list(APPEND nxp_SRCS Library/USBD_ROM/USBD_ROM.c)

  if(SUPPORT_DEVICE_USB_DFU)
    add_definitions(-DSUPPORT_DEVICE_USB_DFU)
  endif()

  if(SUPPORT_DEVICE_USB_HID)
    add_definitions(-DSUPPORT_DEVICE_USB_HID)
  endif()

  if(SUPPORT_DEVICE_USB_MSC)
    add_definitions(-DSUPPORT_DEVICE_USB_MSC)
  endif()

  if(SUPPORT_DEVICE_USB_CDC)
    add_definitions(-DSUPPORT_DEVICE_USB_CDC)
  endif()

  # This driver is in conflict with 'uart_debug' - you cannot have both
  if((MCU_DEVICE STREQUAL lpc_chip_11uxx) OR (MCU_DEVICE STREQUAL lpc_chip_11u6x))
    # USB UART Support
    if(SUPPORT_DEBUG_UART STREQUAL "usb")
      list(APPEND nxp_SRCS Driver/LPC_VCOM/Driver_USART.c)
    endif()
  endif()
endif()

#
# PolyMCU Watchdog
#
if(SUPPORT_WATCHDOG)
  if(MCU_DEVICE STREQUAL lpc_chip_11uxx)
    list(APPEND nxp_SRCS Library/PolyMCU/lpc_chip_11uxx/watchdog.c)
  elseif(MCU_DEVICE STREQUAL lpc_chip_11u6x)
    list(APPEND nxp_SRCS Library/PolyMCU/lpc_chip_11u6x/watchdog.c)
  elseif(MCU_DEVICE STREQUAL lpc_chip_175x_6x)
    list(APPEND nxp_SRCS Library/PolyMCU/lpc_chip_175x_6x/watchdog.c)
  endif()
endif()

# Internal or External (XTAL) oscillators?
if(SUPPORT_NXP_USE_XTAL)
  add_definitions(-DSUPPORT_NXP_USE_XTAL)
endif()

if(DEBUG_UART_BAUDRATE)
  add_definitions(-DDEBUG_UART_BAUDRATE=${DEBUG_UART_BAUDRATE})
endif()

add_library(device_nxp STATIC ${nxp_SRCS})

# Rename the symbols to use the libray with Newlib
add_custom_command(TARGET device_nxp POST_BUILD
    COMMAND ${CMAKE_OBJCOPY} --redefine-sym __main=_mainCRTStartup
                             $<TARGET_FILE_NAME:device_nxp>)

#
# Generate lpcrc Tools
#
include(ExternalProject)

ExternalProject_Add(tool_lpcrc
  SOURCE_DIR ${CMAKE_CURRENT_SOURCE_DIR}/Tools/lpcrc
  BINARY_DIR ${CMAKE_CURRENT_BINARY_DIR}/Tools/lpcrc
  PREFIX ${CMAKE_CURRENT_BINARY_DIR}/Tools/lpcrc
  INSTALL_COMMAND ""
)

add_executable(lpcrc IMPORTED GLOBAL)
set_target_properties(lpcrc PROPERTIES IMPORTED_LOCATION ${CMAKE_CURRENT_BINARY_DIR}/Tools/lpcrc/lpcrc)
add_dependencies(lpcrc lpcrc_tool)

/*
 * Copyright (c) 2015, Lab A Part
 * All rights reserved.
 *
 * Redistribution and use in source and binary forms, with or without
 * modification, are permitted provided that the following conditions are met:
 *
 * o Redistributions of source code must retain the above copyright notice, this
 * o list of conditions and the following disclaimer.
 *
 * o Redistributions in binary form must reproduce the above copyright notice,
 * this list of conditions and the following disclaimer in the documentation
 * and/or other materials provided with the distribution.
 *
 * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
 * AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
 * IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
 * DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE
 * FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL
 * DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR
 * SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER
 * CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY,
 * OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
 * OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 */

MEMORY
{
  /* Define each memory region */
  MFlash512 (rx) : ORIGIN = 0x10002000, LENGTH = 0x6000 /* 24K bytes */
  RamLoc32 (rwx) : ORIGIN = 0x10000000, LENGTH = 0x2000 /* 8K bytes */
  RamAHB32 (rwx) : ORIGIN = 0x2007c000, LENGTH = 0x8000 /* 32K bytes */
}

  /* Define a symbol for the top of each memory region */
  __top_MFlash512 = 0x10002000 + 0x6000;
  __top_RamLoc32 = 0x10000000 + 0x2000;
  __top_RamAHB32 = 0x2007c000 + 0x8000;

  /* NewLib support*/
  __bss_start__ = _bss;
  __bss_end__ = _ebss;
  __stack = _vStackTop;
  
  __HeapBase = _pvHeapStart;
  __StackLimit = _vStackTop - __StackSize;

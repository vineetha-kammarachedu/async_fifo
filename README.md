# Asynchronous FIFO Design and Verification

## Overview
This project implements an Advanced Asynchronous FIFO using Verilog HDL with Clock Domain Crossing (CDC) synchronization techniques.

The FIFO supports:
- Independent write and read clocks
- Gray code pointer synchronization
- Full and Empty detection
- CDC handling using 2-Flip-Flop Synchronizers
- Overflow and Underflow verification

---

## Features
- Dual Clock FIFO Architecture
- Gray Code Pointer Logic
- Synchronizer Modules
- FIFO Memory Design
- Full/Empty Detection
- Advanced Verification Testbench
- Overflow & Underflow Testing

---

## Modules
- async_fifo.v
- wptr_full.v
- rptr_empty.v
- sync_r2w.v
- sync_w2r.v
- fifo_mem.v
- async_fifo_tb.v

---

## Verification
The design was verified using:
- Behavioral Simulation in Vivado
- Asynchronous clock testing
- Pointer synchronization analysis
- Overflow condition testing
- Underflow condition testing

---

## Tools Used
- Verilog HDL
- Xilinx Vivado 2024.2

---

## Key Concepts
- Clock Domain Crossing (CDC)
- Gray Code Counters
- Asynchronous FIFO Architecture
- RTL Design
- Verification Methodology

---

## Author
Kapuluru Chethana

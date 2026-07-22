# MIPS32 5-Stage Pipelined Processor in Verilog

## Overview

This repository contains the RTL implementation and verification of a **32-bit MIPS pipelined processor** developed in **Verilog HDL**. The processor follows the classic **five-stage pipeline architecture** (Instruction Fetch, Instruction Decode, Execute, Memory Access, and Write Back) and incorporates hardware mechanisms for resolving both **data hazards** and **control hazards**.

The project was developed to gain practical experience in processor microarchitecture, pipelined datapath design, RTL implementation, hazard resolution, and hardware verification. Along with functional correctness, the processor integrates lightweight **performance counters** to evaluate pipeline behavior through metrics such as CPI, pipeline stalls, forwarding events, and branch execution statistics.

---

# Highlights

* 32-bit MIPS processor
* Classic 5-stage pipelined architecture
* Modular RTL implementation in Verilog HDL
* Data forwarding unit
* Load-use hazard detection and pipeline stalling
* Branch and jump support
* Pipeline flushing for control hazards
* Hardware performance counters
* Comprehensive RTL verification using multiple benchmark programs

---

# Pipeline Architecture

The processor implements the classical five-stage pipeline.

| Stage | Description                        |
| ----- | ---------------------------------- |
| IF    | Instruction Fetch                  |
| ID    | Instruction Decode & Register Read |
| EX    | Execute / ALU Operations           |
| MEM   | Data Memory Access                 |
| WB    | Register Write Back                |

Pipeline state is maintained using dedicated pipeline registers:

* IF/ID
* ID/EX
* EX/MEM
* MEM/WB

---

# Processor Components

The processor consists of the following RTL modules:

* Program Counter (PC)
* Instruction Memory
* Instruction Decoder
* Control Unit
* Register File
* Sign/Zero Extension Unit
* Arithmetic Logic Unit (ALU)
* Data Memory
* Forwarding Unit
* Stall (Hazard Detection) Unit
* Pipeline Registers
* Top-Level CPU

---

# Supported Instructions

## Arithmetic

* ADD
* SUB
* ADDI

## Logical

* AND
* OR
* XOR
* NOR
* ANDI
* ORI
* XORI

## Comparison

* SLT
* SLTU

## Shift

* SLL
* SRL
* SRA

## Memory

* LW
* SW

## Branch

* BEQ
* BNE
* BLEZ
* BGTZ

## Jump

* J
* JR

---

# Immediate Handling

The processor supports both sign and zero extension.

### Sign Extension

Used for

* ADDI
* Branch offsets
* LW
* SW

### Zero Extension

Used for

* ANDI
* ORI
* XORI

---

# Hazard Handling

## Data Hazard Resolution

The processor resolves RAW hazards using a dedicated forwarding network.

Forwarding paths include:

* EX/MEM → EX
* MEM/WB → EX
* Store-data forwarding
* Register forwarding for control-flow instructions

---

## Load-Use Hazard Detection

The hazard detection unit automatically detects load-use dependencies and performs:

* PC stall
* IF/ID stall
* Bubble insertion

This prevents incorrect execution while minimizing pipeline stalls.

---

## Control Hazard Handling

Supported control-flow instructions include:

* BEQ
* BNE
* BLEZ
* BGTZ
* J
* JR

Control hazards are resolved through:

* Branch target generation
* Jump target generation
* Pipeline flushing
* Program counter redirection

---

# Performance Monitoring

The processor includes lightweight hardware performance counters for evaluating pipeline behavior.

Measured statistics include:

* Total execution cycles
* Executed instruction count
* Cycles Per Instruction (CPI)
* Pipeline stall count
* Branch execution count
* Forwarding events

  * ForwardA
  * ForwardB

Example benchmark result:

| Metric                  | Value |
| ----------------------- | ----: |
| Total Cycles            |    42 |
| Executed Instructions   |    31 |
| CPI                     |  1.35 |
| Pipeline Stalls         |     1 |
| Branches Executed       |     4 |
| ForwardA Events         |     7 |
| ForwardB Events         |     9 |
| Total Forwarding Events |    16 |

These counters demonstrate the effectiveness of the forwarding and hazard detection mechanisms and provide quantitative evaluation of the processor.

---

# Verification

Verification was carried out using a dedicated Verilog testbench together with multiple benchmark programs designed to validate every major component of the processor.

The verification suite covers:

* Arithmetic instructions
* Logical instructions
* Shift operations
* Comparison instructions
* Immediate instructions
* Register write-back
* Load/Store operations
* Data forwarding
* Load-use hazards
* Pipeline stalls
* Branch execution
* Jump execution
* Pipeline flushing
* Hardware performance counters

Waveform analysis was performed using **GTKWave** to verify correct datapath operation, pipeline behavior, forwarding paths, hazard handling, and control-flow execution.

---

# Repository Structure

```text
.
├── rtl/
│   ├── cpu.v
│   ├── alu.v
│   ├── control_unit.v
│   ├── forwarding_unit.v
│   ├── stall_unit.v
│   ├── reg_file.v
│   ├── pc.v
│   ├── sign_extend.v
│   ├── instr_decoder.v
│   ├── instr_mem.v
│   ├── data_mem.v
│   ├── IF_ID.v
│   ├── ID_EX.v
│   ├── EX_MEM.v
│   ├── MEM_WB.v
│   └── parameters.v
│
├── testbench/
│   └── cpu_tb.v
│
├── programs/
│   ├── program1.mem
│   ├── program1.txt
│   ├── program2.mem
│   ├── program2.txt
│   ├── program3.mem
│   └── program3.txt
│
├── docs/
│   └── schematic.pdf
│
├── README.md
└── LICENSE
```

---

# Tools Used

* Verilog HDL
* Icarus Verilog
* GTKWave

---

# Learning Outcomes

This project provided practical experience in:

* Processor Microarchitecture
* Computer Architecture
* RTL Design
* Verilog HDL
* Pipeline Design
* Pipeline Registers
* Hazard Detection
* Data Forwarding
* Branch Handling
* Control Hazard Resolution
* Hardware Verification
* Performance Evaluation
* Digital System Design

---

# Author

**Soumyadip Dutta**

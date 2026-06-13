# MIPS32 5-Stage Pipelined Processor in Verilog

## Overview

This project presents the design and verification of a 32-bit MIPS-style pipelined processor implemented in Verilog HDL. The processor follows the classic five-stage pipeline architecture and incorporates mechanisms for handling both data and control hazards, enabling correct execution of dependent and control-flow instructions while improving instruction throughput.

The design was developed as a computer architecture and digital design project to explore processor microarchitecture concepts including pipelining, forwarding, hazard detection, branch handling, and RTL verification.

---

## Highlights

* 32-bit MIPS-style processor
* 5-stage pipeline (IF, ID, EX, MEM, WB)
* Data forwarding unit
* Load-use hazard detection and stalling
* Branch and jump support
* Pipeline flushing for control hazards
* Verilog RTL implementation
* Comprehensive verification using custom test programs

---

## Architecture

The processor is organized into the following pipeline stages:

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

## Implemented Features

### Processor Datapath

* 32-bit datapath
* MIPS-style instruction format
* Program Counter (PC)
* Register File
* Arithmetic Logic Unit (ALU)
* Instruction Memory
* Data Memory
* Immediate Generation Unit
* Control Unit
* Instruction Decoder

### Pipeline Support

* Five-stage instruction pipeline
* Simultaneous execution of multiple instructions
* Pipeline register isolation between stages
* Pipeline flushing support

### Data Hazard Resolution

To maintain correct execution of dependent instructions, the processor implements:

#### Forwarding Unit

Supports forwarding from:

* EX/MEM stage
* MEM/WB stage

Forwarding paths include:

* ALU operand forwarding
* Store-data forwarding
* Register value forwarding for control-flow instructions

#### Hazard Detection Unit

Detects load-use hazards and automatically:

* Stalls the pipeline
* Prevents PC updates
* Prevents IF/ID updates
* Inserts pipeline bubbles when required

### Control Hazard Handling

Implemented control-flow instructions include:

| Instruction | Description                          |
| ----------- | ------------------------------------ |
| BEQ         | Branch if Equal                      |
| BNE         | Branch if Not Equal                  |
| BLEZ        | Branch if Less Than or Equal to Zero |
| BGTZ        | Branch if Greater Than Zero          |
| J           | Jump                                 |
| JR          | Jump Register                        |

Control hazard mitigation includes:

* Branch target generation
* Jump target generation
* Pipeline flushing on taken branches
* Pipeline flushing on jump instructions
* Pipeline flushing on JR instructions

---

## Instruction Support

### R-Type Instructions

* ADD
* SUB
* AND
* OR
* XOR
* Shift operations
* JR

### Immediate Instructions

* ADDI
* ANDI
* ORI
* XORI

### Memory Instructions

* LW
* SW

### Branch Instructions

* BEQ
* BNE
* BLEZ
* BGTZ

### Jump Instructions

* J
* JR

---

## Immediate Handling

The processor supports both:

### Sign Extension

Used for:

* Arithmetic immediates
* Branch offsets
* Load/store offsets

### Zero Extension

Used for:

* ANDI
* ORI
* XORI

---

## Repository Structure

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

## Verification

Verification was performed using a dedicated Verilog testbench and multiple instruction programs designed to exercise:

* Arithmetic operations
* Logical operations
* Immediate instructions
* Register write-back
* Load/store functionality
* Data hazards
* Forwarding logic
* Pipeline stalls
* Branch execution
* Jump execution
* Control hazard recovery

Waveform analysis was performed to validate correct datapath operation and pipeline behavior.

---

## Datapath Schematic

The complete processor datapath and synthesized architecture are provided in:

```text
docs/schematic.pdf
```

---

## Learning Outcomes

This project provided practical experience in:

* Computer Architecture
* Processor Microarchitecture
* RTL Design
* Verilog HDL
* Pipeline Design
* Hazard Detection
* Data Forwarding
* Control Hazard Handling
* Hardware Verification
* Digital System Design

---

## Author

**Soumyadip Dutta**

# SystemVerilog Verification of a Parameterized Synchronous FIFO

## Overview

This project presents the functional verification of a parameterized synchronous FIFO (First-In First-Out) using SystemVerilog. The verification environment is built using transaction-based verification concepts and employs constrained-random stimulus generation, functional coverage, and a queue-based reference scoreboard to validate the FIFO's primary functionality.

The objective of this project is to verify correct FIFO behavior under randomized operating conditions while collecting functional coverage for important FIFO status signals.

---

## Project Features

- Parameterized synchronous FIFO RTL
- Transaction-based verification environment
- Constrained-random stimulus generation
- SystemVerilog Interface using Modports
- Functional Coverage using Covergroups
- Cross Coverage for control and status signals
- Queue-based Reference Scoreboard
- Self-checking Testbench
- Automatic Simulation Reporting

---

## Verification Environment

The verification environment consists of the following components:

### Transaction Class

The transaction class encapsulates a FIFO transaction and generates randomized stimulus using SystemVerilog constraints.

Randomized fields include:

- Input Data
- Write Enable
- Read Enable
- Reset

---

### Testbench

The testbench generates randomized transactions and applies them to the DUT through the SystemVerilog interface.

---

### SystemVerilog Interface

The interface connects the DUT and verification components using modports, providing clean communication between the testbench, monitor, and RTL.

---

### Monitor

The monitor observes DUT activity every simulation cycle, captures interface signals, and forwards transactions to:

- Functional Coverage
- Scoreboard

---

### Functional Coverage

Functional coverage is implemented using SystemVerilog covergroups.

Coverage is collected for:

- Write Enable
- Read Enable
- Write Acknowledge
- FIFO Full
- FIFO Empty
- Almost Full
- Almost Empty
- Overflow
- Underflow

Cross coverage is implemented between read/write control signals and FIFO status signals to ensure a wide range of operating scenarios are exercised.

---

### Scoreboard

A queue-based reference model is used to validate the FIFO data path.

The scoreboard automatically checks:

- Data Output (`data_out`)
- Write Acknowledge (`wr_ack`)

Any mismatch between the DUT outputs and the reference model is reported during simulation.

---

## Verification Flow

```
          Random Transactions
                  │
                  ▼
            Testbench
                  │
                  ▼
              FIFO DUT
                  │
                  ▼
              Monitor
             /       \
            ▼         ▼
 Functional Coverage  Scoreboard
```

---

## Verification Scope

The verification environment automatically validates:

- FIFO Write Operation
- FIFO Read Operation
- FIFO Data Ordering (FIFO Behavior)
- Write Acknowledge Generation

Functional coverage is collected for:

- FIFO Full Condition
- FIFO Empty Condition
- Almost Full Condition
- Almost Empty Condition
- Overflow
- Underflow
- Read/Write Enable combinations

---

## Project Structure

```
FIFO_Verification/
│
├── RTL/
│   └── FIFO.sv
│
├── SV_TESTBENCH/
│   ├── fifo_coverage.sv
│   ├── fifo_if.sv
│   ├── fifo_monitor.sv
│   ├── fifo_score.sv
│   ├── fifo_shared.sv
│   ├── fifo_tb.sv
│   ├── fifo_top.sv
│   ├── fifo_transaction.sv
│   └── testbench.sv
│
└── README.md
```

---

## Simulation

The verification environment was simulated using **Riviera-PRO EDU Edition** on **EDA Playground**.

Simulation performs:

- Randomized FIFO stimulus generation
- Automatic DUT monitoring
- Functional coverage collection
- Queue-based output checking
- Simulation summary generation

---

## Technologies Used

- SystemVerilog
- Constrained Random Verification (CRV)
- Functional Coverage
- Transaction-Based Verification
- Queue-Based Reference Modeling
- Riviera-PRO EDU
- EDA Playground

---

## Learning Outcomes

This project provided practical experience with:

- SystemVerilog verification methodology
- Transaction-based verification
- Constrained-random stimulus generation
- Functional coverage implementation
- Cross coverage
- Queue-based reference modeling
- Interface-based verification
- Development of self-checking verification environments

---

## Future Enhancements

- SystemVerilog Assertions (SVA)
- UVM-based verification environment
- Coverage-driven randomization
- Functional coverage closure
- Regression automation
- Enhanced scoreboard for additional FIFO status verification

---

## Author

**Shri Ram Lakshmi Narasimhan**

B.Tech in Electronics and Communication Engineering

Areas of Interest:
- RTL Design
- Design Verification
- Digital IC Design
- Computer Architecture
- VLSI

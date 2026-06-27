# APB-based UART Master Core — RTL Verification

A complete UVM-based functional verification environment for an APB-interfaced UART Master Core, covering protocol compliance, error injection, register abstraction, and coverage closure.

---

## Table of Contents

- [Project Overview](#project-overview)
- [Repository Structure](#repository-structure)
- [Design Under Test](#design-under-test)
- [Verification Environment](#verification-environment)
- [Test Plan](#test-plan)
- [Coverage Strategy](#coverage-strategy)
- [How to Run](#how-to-run)
- [Tools & Technologies](#tools--technologies)

---

## Project Overview

This project implements a UVM verification environment for a UART Master Core that is configured and controlled through an APB (Advanced Peripheral Bus) interface. The environment verifies:

- Correct APB read/write transactions to UART registers
- UART serial communication features including configurable baud rate, data width, parity, and stop bits
- Error detection and handling: parity errors, framing errors, timeout errors, and overrun errors
- Full functional coverage and assertion-based checking to achieve coverage closure

---

## Repository Structure

```
.
├── uart_rtl/          # RTL source files (DUT — UART Master Core)
├── tb/                # Testbench top, interfaces, and UVM environment
├── uart_agt/          # UVM Agent: driver, monitor, sequencer, and transactions
├── test/              # UVM tests and virtual sequences
├── sim/               # Simulation scripts, Makefile, and run collateral
└── README.md
```

| Directory   | Contents |
|-------------|----------|
| `uart_rtl/` | Synthesizable RTL for the UART Master Core (Verilog) |
| `tb/`       | UVM environment, scoreboard, RAL model, and coverage collector |
| `uart_agt/` | APB/UART agent components (driver, monitor, sequencer, sequence items) |
| `test/`     | Test library: directed tests, constrained-random tests, error injection |
| `sim/`      | Makefile targets for compilation, elaboration, and simulation |

---

## Design Under Test

The **UART Master Core** is an APB slave peripheral that provides a serial UART interface. Key features:

- **Bus Interface:** APB (Advanced Peripheral Bus) — AMBA 2.0 compliant
- **UART Features:**
  - Configurable baud rate via divisor register
  - Configurable data width (5–8 bits)
  - Parity: none / odd / even
  - Stop bits: 1 or 2
  - TX/RX FIFOs
- **Interrupt support** for TX empty, RX data available, and error conditions

---

## Verification Environment

The environment follows the standard UVM layered testbench architecture.

```
┌─────────────────────────────────────────────────┐
│                  UVM Test                        │
│  ┌───────────────────────────────────────────┐  │
│  │            UVM Environment                │  │
│  │  ┌──────────────┐  ┌────────────────────┐ │  │
│  │  │  APB Agent   │  │   UART Agent       │ │  │
│  │  │  (Driver +   │  │  (Monitor)         │ │  │
│  │  │   Sequencer) │  │                    │ │  │
│  │  └──────┬───────┘  └────────┬───────────┘ │  │
│  │         │                   │             │  │
│  │  ┌──────▼───────────────────▼───────────┐ │  │
│  │  │            Scoreboard                │ │  │
│  │  └──────────────────────────────────────┘ │  │
│  │  ┌──────────────────────────────────────┐ │  │
│  │  │           RAL Model                  │ │  │
│  │  └──────────────────────────────────────┘ │  │
│  └───────────────────────────────────────────┘  │
└─────────────────────────────────────────────────┘
                       │
            ┌──────────▼──────────┐
            │   DUT (UART RTL)    │
            └─────────────────────┘
```

### Key Components

**Agent (`uart_agt/`)**
- `apb_driver` — Drives APB read/write transfers to the DUT
- `apb_sequencer` — Arbitrates sequences onto the driver
- `uart_monitor` — Passively observes UART TX/RX serial lines and decodes frames
- `apb_seq_item` — Transaction object for APB transfers

**Environment (`tb/`)**
- `uart_env` — Instantiates agents, scoreboard, and coverage
- `uart_scoreboard` — Compares expected vs. actual UART frames and register responses
- `uart_coverage` — Functional coverage collector
- `uart_ral_model` — Register Abstraction Layer (RAL) model for register-level access

**Tests (`test/`)**
- Register read/write sanity tests
- UART transmit and receive directed tests
- Parity, framing, timeout, and overrun error injection tests
- Constrained-random tests for broad stimulus coverage

---

## Test Plan

| Test Name                  | Description                                              | Pass Criterion                          |
|----------------------------|----------------------------------------------------------|-----------------------------------------|
| `apb_reg_rw_test`          | Write and read back all UART registers via APB           | Data integrity, no bus errors           |
| `uart_tx_basic_test`       | Transmit frames with various data/parity configurations  | Correct serial output on TX line        |
| `uart_rx_basic_test`       | Receive valid UART frames                                | Data captured correctly in RX register  |
| `parity_error_test`        | Inject parity errors on RX input                         | Parity error flag set; interrupt fires  |
| `framing_error_test`       | Corrupt stop bit on RX input                             | Framing error flag set                  |
| `overrun_error_test`       | Overflow RX FIFO without software read                   | Overrun flag set; no data corruption    |
| `timeout_error_test`       | Trigger RX timeout condition                             | Timeout flag set; interrupt fires       |
| `rand_config_test`         | Randomize baud rate, parity, data width, stop bits       | DUT operates correctly across configs   |

---

## Coverage Strategy

Coverage closure was achieved using two complementary methods:

### Functional Coverage
Implemented via SystemVerilog covergroups in `uart_coverage`:

- APB transfer types (read / write) per register address
- UART configuration combinations (baud divisor × parity × data bits × stop bits)
- Error flag combinations (parity / framing / overrun / timeout)
- FIFO fill levels (empty / partial / full)

### Assertion-Based Verification (SVA)
SystemVerilog assertions are bound to the DUT to check:

- APB protocol compliance (setup and enable phase timing, no spurious `PREADY`)
- UART frame integrity (correct start bit, data bits, parity bit, stop bit sequencing)
- Error flag correctness (flag must assert within one frame of the error condition)
- No undefined (`X`/`Z`) values on critical output signals

---

## How to Run

### Prerequisites

- A SystemVerilog simulator (Synopsys VCS, Cadence Xcelium, Mentor Questa, or compatible)
- UVM 1.2 library available in `$UVM_HOME`

### Simulation

```bash
# Navigate to the simulation directory
cd sim

# Compile, elaborate, and run the default test
make run

# Run a specific test
make run TEST=parity_error_test

# Run with coverage collection
make run COV=1

# Generate coverage report
make report
```

### Makefile Targets

| Target        | Description                              |
|---------------|------------------------------------------|
| `make compile` | Compile RTL and testbench sources        |
| `make elab`   | Elaborate the design                     |
| `make run`    | Run simulation (default: sanity test)    |
| `make cov`    | Merge and report coverage                |
| `make clean`  | Remove all generated files               |

---

## Tools & Technologies

| Tool / Technology      | Usage                                   |
|------------------------|-----------------------------------------|
| SystemVerilog          | RTL design and testbench implementation |
| UVM 1.2                | Verification methodology framework      |
| VCS / Xcelium / Questa | Simulation                              |
| SVA (SystemVerilog Assertions) | Protocol and functional checks  |
| RAL (Register Abstraction Layer) | Register-level test automation |
| Makefile               | Build and run automation                |

---

## Author

**Jandhyam Mohan Ganga**  
[GitHub Profile](https://github.com/jandhyammohanganga)

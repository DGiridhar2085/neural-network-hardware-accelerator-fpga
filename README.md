# 🧠 Hardware Accelerator For Neural Network (Image and Vid Processing using CNN) (Verilog HDL)

### ⚡ FPGA-Based Convolutional Neural Network Accelerator Implemented in Verilog

---

## 📘 Overview

This project implements a **hardware accelerator for Convolutional Neural Networks (CNNs)** using **Verilog HDL**.  
The accelerator performs convolution operations — the fundamental computations of CNNs — using parallel multiply-accumulate (MAC) units, enabling high-speed and low-latency performance compared to software implementations.  

It supports **behavioral simulation** and **synthesis** in **Vivado Design Suite**, making it suitable for both learning and research in hardware-accelerated AI.

---

## 🧩 Project Structure

| File | Description |
|------|-------------|
| `cnn_top.v` | Top-level integration module connecting all CNN computational blocks |
| `conv_channel.v` | Manages multiple input channels and performs convolution per channel |
| `conv_core.v` | Core MAC computation block handling pixel-by-pixel multiplication and accumulation |
| `conv_output.v` | Collects final feature map results and formats the convolution output |
| `tb_cnn_top.v` | Testbench file to simulate and verify CNN accelerator functionality |

---

## ⚙️ Key Features

- Fully modular Verilog-based CNN accelerator  
- Multi-channel convolution support (3 input channels, 8 output channels)  
- Fixed-point arithmetic for efficient FPGA computation  
- Parameterized architecture for easy scalability  
- Testbench verified for behavioral simulation  
- 3×3 kernel convolution operations  
- Fully pipelined design with single clock domain  

---

## 🏗️ Hardware Architecture

### Module Hierarchy
cnn_top
└── conv_output (8 instances)
└── conv_channel (3 instances)
└── conv_core (3×3 convolution MAC)


### 🔧 Configuration Parameters

| Parameter | Default | Description |
|-----------|---------|-------------|
| `DATA_W` | 8 | Data width in bits |
| `ACC_W` | 32 | Accumulator width in bits |
| `IN_CH` | 3 | Number of input channels |
| `OUT_CH` | 8 | Number of output channels |

---

## 📡 Interface Signals

### 🔌 Input Ports
| Signal | Width | Description |
|--------|-------|-------------|
| `clk` | 1 | System clock |
| `rstn` | 1 | Active-low reset |
| `valid_in` | 1 | Input data valid signal |
| `window_in` | 216 bits | Input feature map (3×3×3 channels) |
| `weight_bank` | 1728 bits | Filter weights (3×3×3×8 filters) |

### 📤 Output Ports
| Signal | Width | Description |
|--------|-------|-------------|
| `valid_out` | 8 bits | Output valid signals (one per channel) |
| `acc_out` | 256 bits | Convolution results (32-bit per channel) |

---

## 🧪 Simulation & Verification

### 🚀 Run Simulation
```bash
iverilog -o sim tb_cnn_top.v cnn_top.v conv_output.v conv_channel.v conv_core.v
vvp sim
====================================
Simulation complete
Valid_out = 11111111
acc_out[0] = 135
====================================


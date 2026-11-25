# CNN Hardware Accelerator in Verilog

> An FPGA-oriented, parameterised convolution engine implemented in Verilog HDL.

This repository contains a compact hardware implementation of the core computation behind a convolutional neural network: a multi-channel 3 x 3 convolution. It is designed as a learning and portfolio project for RTL design, verification, and FPGA development workflows.

## What is implemented

- 3 x 3 convolution using multiply-accumulate (MAC) operations
- 3 input channels and 8 output channels by default
- 8-bit input and weight data paths
- 32-bit signed accumulators
- Parameterised data width, accumulator width, input-channel count, and output-channel count
- A registered convolution output stage
- A Verilog testbench for behavioural simulation

## Architecture

```text
cnn_top
└── conv_output                 # Creates one path per output channel
    └── conv_channel x 8        # Sums contributions from input channels
        └── conv_core x 3       # Computes one 3 x 3 MAC per input channel
```

For every output channel, the design accepts a 3 x 3 window from each input channel and the associated 3 x 3 kernel weights. Each `conv_core` produces a channel contribution; `conv_channel` adds the contributions to create one output accumulator value.

## Repository structure

| File | Purpose |
| --- | --- |
| `cnn_top.v` | Top-level module |
| `conv_output.v` | Generates the output-channel convolution paths |
| `conv_channel.v` | Aggregates convolution results across input channels |
| `conv_core.v` | Performs one 3 x 3 multiply-accumulate operation |
| `tb_cnn_top.v` | Behavioural simulation testbench |

## Interface summary

| Signal | Width (default) | Description |
| --- | ---: | --- |
| `clk` | 1 | System clock |
| `rstn` | 1 | Active-low reset |
| `valid_in` | 1 | Marks a valid input window and weight bank |
| `window_in` | 216 bits | 3 x 3 pixels across 3 input channels |
| `weight_bank` | 1728 bits | 3 x 3 weights for 8 filters across 3 input channels |
| `valid_out` | 8 bits | Valid signal for each output channel |
| `acc_out` | 256 bits | Eight 32-bit accumulated convolution outputs |

## Simulating the design

With [Icarus Verilog](https://steveicarus.github.io/iverilog/) installed:

```bash
iverilog -o sim tb_cnn_top.v cnn_top.v conv_output.v conv_channel.v conv_core.v
vvp sim
```

The included testbench applies the values 1 through 9 to every input-channel window and sets all weights to 1. The expected accumulated result per output channel is:

```text
3 channels x (1 + 2 + ... + 9) = 3 x 45 = 135
```

The testbench checks the data path through a valid input pulse and reports the output validity and first accumulator result.

## Next improvements

- Add self-checking assertions to the testbench
- Add waveform screenshots and a Vivado simulation report
- Add synthesis, timing, and resource-utilisation results after rerunning the design
- Add activation, bias, and feature-map buffering modules
- Support configurable stride, padding, and quantisation

## Author

**D. Giridhar**  
[LinkedIn](https://www.linkedin.com/in/duddekunta-giridhar-799b88302/) · [GitHub](https://github.com/DGiridhar2085)

## License

This project is available under the MIT License.
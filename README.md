# MIPS32-Microprocessor

In the design of the Single-Cycle MIPS32® microprocessor, digital circuits can be grouped into two main categories: datapath and control. The datapath is a component of the microprocessor that performs arithmetic operations and data storage. It is also where the five stages of instruction processing take place, including instruction fetch, instruction decode, execute, memory access, and write back. On the other hand, the control component of the microprocessor regulates the datapath based on the instruction being executed.

The control section has been represented by the control unit that we designed in previous labs. For the datapath, we need to integrate the components we have created, including multiplexers, ALU, registers, data memory, instruction memory, and others, to form a pathway through which data can flow. Thus, control and datapath are inseparable in the design of a microprocessor. Together, they form a Single-Cycle MIPS32® microprocessor design known as a top-level design. The top-level design generally contains only the port mapping from one component to another.

When simulating a digital circuit, we typically provide input signals manually through a waveform editor. While this method is straightforward, it becomes inefficient when performing repeated simulations. An alternative way to simulate a digital circuit without providing inputs one by one using a waveform editor is to use a testbench.

Essentially, a testbench consists of VHDL or Verilog HDL code, depending on the implementation. The testbench can contain a design that stores the input signal values that need to be provided to the design under test (DUT). Then, the testbench will output each input that must be given to the DUT based on a trigger, such as a clock signal.

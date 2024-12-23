# Useful commands and stuff/knowledge

# Registers: 

# Predefined Purposes of Registers in x86 Assembly

### 1. General-purpose Registers
- **AX (Accumulator Register)**: Used for arithmetic, I/O, and data movement.
- **BX (Base Register)**: Often used as an address pointer for memory operations.
- **CX (Count Register)**: Used for loop counters or string operations.
- **DX (Data Register)**: Used for I/O operations or extended arithmetic.

### 2. Segment Registers
- **CS (Code Segment)**: Holds the segment address of the program code.
- **DS (Data Segment)**: Points to data used by the program.
- **SS (Stack Segment)**: Points to the stack.
- **ES, FS, GS**: Additional segments for special purposes.

### 3. Instruction-related Registers
- **IP (Instruction Pointer)**: Points to the next instruction.
- **Flags Register (EFLAGS)**: Stores condition flags (e.g., Zero Flag, Carry Flag).

### 4. Pointer and Index Registers
- **SP (Stack Pointer)**: Points to the top of the stack.
- **BP (Base Pointer)**: Used for stack frame referencing.
- **SI (Source Index)**: Used in string operations.
- **DI (Destination Index)**: Used in string operations.


# Flags in x86 Architecture :

## Flags Register Overview
Flags are stored in a **Flags Register** (often called the **EFLAGS register** in 32-bit mode and **FLAGS register** in 16-bit mode). These flags allow the processor to track conditions like zero results, carry-over from calculations, or whether a sign bit was set.

The **Flags Register** is split into two parts:
1. The lower 8 bits (for 16-bit mode or the lower part of the 32-bit register in 32-bit mode) hold the **Status Flags** and **Control Flags**.
2. The higher bits (also control and system-related flags) are used for **system control**.

---

## 1. Status Flags
These flags reflect the results of arithmetic or logical operations:

### - **CF (Carry Flag)**
  - **Purpose**: Indicates whether a carry occurred during an addition or a borrow occurred during a subtraction. Also used for overflow in shifts and rotates.
  - **How it works**:
    - Set if the result of an addition exceeds the destination register or a borrow occurs in subtraction.
    - Used in operations like `ADD`, `SUB`, `ADC`, `SBB`.

### - **PF (Parity Flag)**
  - **Purpose**: Indicates whether the number of set bits (1s) in the result is even or odd.
  - **How it works**:
    - Set if the number of 1s is even (even parity).
    - Cleared if the number of 1s is odd (odd parity).

### - **AF (Auxiliary Carry Flag)**
  - **Purpose**: Used in binary-coded decimal (BCD) arithmetic operations.
  - **How it works**:
    - Set if there is a carry from bit 3 to bit 4 in a nibble (4-bit group) during a BCD operation.
    - Cleared otherwise.

### - **ZF (Zero Flag)**
  - **Purpose**: Indicates whether the result of an operation is zero.
  - **How it works**:
    - Set if the result is zero.
    - Cleared if the result is non-zero.

### - **SF (Sign Flag)**
  - **Purpose**: Reflects the sign of the result of the operation.
  - **How it works**:
    - Set if the result is negative (most significant bit is 1).
    - Cleared if the result is positive (most significant bit is 0).

### - **TF (Trap Flag)**
  - **Purpose**: Controls single-step debugging.
  - **How it works**:
    - Set to cause an interrupt after each instruction (for stepping through instructions in debugging).
    - Cleared in normal execution.

### - **IF (Interrupt Flag)**
  - **Purpose**: Controls the processor's ability to respond to interrupts.
  - **How it works**:
    - Set if interrupts are enabled (hardware or software interrupts are allowed).
    - Cleared if interrupts are disabled.

### - **DF (Direction Flag)**
  - **Purpose**: Controls the direction of string operations.
  - **How it works**:
    - Set for decreasing the `SI` (Source Index) and `DI` (Destination Index) during string operations.
    - Cleared for incrementing the indices.

### - **OF (Overflow Flag)**
  - **Purpose**: Indicates if the result of an arithmetic operation caused a signed overflow.
  - **How it works**:
    - Set if the result cannot be represented in the destination register (too large or too small for the signed type).
    - Cleared if the result fits within the register size.

---

## 2. Control Flags
Control flags influence the execution behavior of the processor:

### - **IOPL (Input/Output Privilege Level)**
  - **Purpose**: Specifies the privilege level required to execute I/O instructions in protected mode.
  - **How it works**:
    - This 2-bit field defines the I/O privilege level (0-3), where 0 is the highest privilege.

### - **NT (Nested Task Flag)**
  - **Purpose**: Used to manage nested tasks in multitasking environments.
  - **How it works**:
    - Set if the processor is running a nested task.
    - Cleared otherwise.

### - **RF (Resume Flag)**
  - **Purpose**: Controls single-step behavior in debugging.
  - **How it works**:
    - Set to indicate the processor should resume normal execution after a debug exception.
    - Cleared otherwise.

### - **VM (Virtual 8086 Mode Flag)**
  - **Purpose**: Switches between real mode and virtual 8086 mode in protected environments.
  - **How it works**:
    - Set to enable Virtual 8086 mode, allowing real-mode programs to execute in a protected environment.
    - Cleared otherwise.

---

## 3. System Flags
These flags are used for system-level control of the processor and memory:

### - **AC (Alignment Check Flag)**
  - **Purpose**: Enables or disables alignment checking for memory accesses.
  - **How it works**:
    - Set to enable alignment checking (an exception occurs if data is misaligned).
    - Cleared to disable alignment checking.

### - **AI (Artificial Interrupt Flag)**
  - **Purpose**: Controls exceptions during program execution.
  - **How it works**:
    - Set to cause an artificial interrupt.
    - Cleared otherwise.

### - **ID (ID Flag)**
  - **Purpose**: Controls whether the processor recognizes the `CPUID` instruction.
  - **How it works**:
    - Set to enable the `CPUID` instruction.
    - Cleared to disable it.

---

## Summary of Flags

| **Flag** | **Description**                          | **Set/Reset Condition**                                |
|----------|------------------------------------------|-------------------------------------------------------|
| CF       | Carry Flag                               | Set if carry or borrow occurs                         |
| PF       | Parity Flag                              | Set if result has even parity                         |
| AF       | Auxiliary Carry Flag                    | Set if carry between bit 3 and bit 4 (BCD)           |
| ZF       | Zero Flag                                | Set if result is zero                                 |
| SF       | Sign Flag                                | Set if result is negative                             |
| TF       | Trap Flag                                | Set to enable single-stepping                         |
| IF       | Interrupt Flag                          | Set to allow interrupts                               |
| DF       | Direction Flag                          | Set to decrement indices in string operations         |
| OF       | Overflow Flag                           | Set if signed overflow occurs                        |
| IOPL     | I/O Privilege Level                     | Specifies privilege level for I/O                    |
| NT       | Nested Task Flag                        | Set if nested task is running                        |
| RF       | Resume Flag                             | Set to resume after debugging                        |
| VM       | Virtual 8086 Mode Flag                 | Set to enable 8086 emulation                         |
| AC       | Alignment Check Flag                   | Set to check memory alignment                        |
| ID       | ID Flag                                 | Set to enable `CPUID` instruction                    |



# Jump Commands in x86 Assembly

## 1. Unconditional Jump
- **JMP**: Jump to a specified address unconditionally.

---

## 2. Conditional Jumps
Conditional jumps depend on the status of specific flags (Zero, Carry, Sign, Overflow, etc.) after an operation.

### Based on Zero Flag (ZF):
- **JE** or **JZ**: Jump if Equal / Zero (ZF = 1).
- **JNE** or **JNZ**: Jump if Not Equal / Not Zero (ZF = 0).

### Based on Carry Flag (CF):
- **JC**: Jump if Carry (CF = 1).
- **JNC**: Jump if Not Carry (CF = 0).

### Based on Sign Flag (SF):
- **JS**: Jump if Sign (SF = 1, negative result).
- **JNS**: Jump if Not Sign (SF = 0).

### Based on Overflow Flag (OF):
- **JO**: Jump if Overflow (OF = 1).
- **JNO**: Jump if Not Overflow (OF = 0).

### Based on Parity Flag (PF):
- **JP** or **JPE**: Jump if Parity Even (PF = 1).
- **JNP** or **JPO**: Jump if Parity Odd (PF = 0).

---

## 3. Comparison-Based Jumps
These are used after `CMP` instructions.

### Unsigned Comparisons:
- **JA** or **JNBE**: Jump if Above (CF = 0 and ZF = 0).
- **JAE** or **JNB**: Jump if Above or Equal (CF = 0).
- **JB** or **JNAE**: Jump if Below (CF = 1).
- **JBE** or **JNA**: Jump if Below or Equal (CF = 1 or ZF = 1).

### Signed Comparisons:
- **JG** or **JNLE**: Jump if Greater (ZF = 0 and SF = OF).
- **JGE** or **JNL**: Jump if Greater or Equal (SF = OF).
- **JL** or **JNGE**: Jump if Less (SF ≠ OF).
- **JLE** or **JNG**: Jump if Less or Equal (ZF = 1 or SF ≠ OF).

---

## 4. Loop Control Jumps
These jumps rely on the **CX** register and are used for loops:
- **LOOP**: Decrement CX and jump if CX ≠ 0.
- **LOOPE** or **LOOPZ**: Decrement CX and jump if CX ≠ 0 and ZF = 1.
- **LOOPNE** or **LOOPNZ**: Decrement CX and jump if CX ≠ 0 and ZF = 0.

---

## 5. Program Flow Instructions
- **CALL**: Call a subroutine (pushes the return address onto the stack).
- **RET**: Return from a subroutine (pops the return address from the stack).
- **INT**: Trigger an interrupt.

---

## 6. Short Conditional Jumps (Optional)
Some assemblers allow short forms for conditional jumps, such as:

- **JCXZ**: Jump if the **CX** register is 0.

    .align 4

    .equ MAXIMUM_NUMBER_HART, 1
    .equ SIZE_STACK, 1024
    .equ SIZE_STACK_SHIFT_LEFT, 10

    .equ BASE_ADDRESS_UART, 128

    .equ RECEIVE_HOLDING_REGISTER, 0
    .equ TRANSMIT_HOLDING_REGISTER, 0
    .equ LSB_DIVISOR_LATCH, 0
    .equ INTERRUPT_ENABLE_REGISTER, 1
    .equ MSB_DIVISOR_LATCH, 1
    .equ FIFO_CONTROL_REGISTER, 2
    .equ INTERRUPT_STATUS_REGISTER, 2
    .equ LINE_CONTROL_REGISTER, 3
    .equ MODEM_CONTROL_REGISTER, 4
    .equ LINE_STATUS_REGISTER, 5
    .equ MODEM_STATUS_REGISTER, 6
    .equ SCRATCH_PAD_REGISTER, 7

    .text
    .global _start
uart_write:
    li t0, BASE_ADDRESS_UART
uart_write_0:
    lb t1, LINE_STATUS_REGISTER(t0)
    andi t1, t1, 32
    beqz t1, uart_write_0
    sb a0, TRANSMIT_HOLDING_REGISTER(t0)
    ret

park:
    wfi
    j park

_start:
    csrr t0, mhartid
    mv tp, t0
    bnez t0, park

    slli t0, t0, SIZE_STACK_SHIFT_LEFT
    la sp, stacks + SIZE_STACK
    add sp, sp, t0

    li t0, BASE_ADDRESS_UART
    li t1, 0
    sb t1, INTERRUPT_ENABLE_REGISTER(t0)
    lb t1, LINE_CONTROL_REGISTER(t0)
    ori t1, t1, 128
    sb t1, LINE_CONTROL_REGISTER(t0)
    li t1, 3
    sb t1, LSB_DIVISOR_LATCH(t0)
    li t1, 0
    sb t1, MSB_DIVISOR_LATCH(t0)
    li t1, 3
    sb t1, LINE_CONTROL_REGISTER(t0)

    li a0, 33
    jal uart_write

    .data
stacks:
    .skip SIZE_STACK * MAXIMUM_NUMBER_HART

    .end

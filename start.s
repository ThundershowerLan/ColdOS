    .equ STACK_SIZE, 8192
    .global _start
    .text
_start:
    csrr t0, mhartid
    mv tp, t0
    bnez t0, park
park:
    wfi
    j park

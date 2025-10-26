riscv64-unknown-elf-as -march=rv64gc -mabi=lp64d kernel.S -o kernel.o
riscv64-unknown-elf-ld -T kernel.ld kernel.o -o kernel.elf

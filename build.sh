riscv64-unknown-elf-as -march=rv64gc -mabi=lp64d kernel.S -o kernel.o
riscv64-unknown-elf-ld -Ttext=0x8020000 kernel.o -o kernel.elf

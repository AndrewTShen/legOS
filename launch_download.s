// Launch to different user programs
.syntax unified

.global launch_download
.align 6
// TODO, better way to do nop 17 times
launch_download:
    LDR r0, =#0x20005000        // User stack location
    MSR PSP, r0                 // Set PSP to 0x20005000.
    MOV r0, #0x3                // Set the 0 and 1 bits in CONTROL register.
    MSR CONTROL, r0             // Enables user mode and usage of the PSP.
    ISB                         // ISB to flush pipeline.
    LDR r0, =#0x2000A001        // User prog entry point
    BX r0                       // Branch to the user prog entry point.
    NOP
    NOP
    NOP
    NOP
    NOP
    NOP
    NOP
    NOP
    NOP
    NOP
    NOP
    NOP
    NOP
    NOP
    NOP
    NOP
    NOP

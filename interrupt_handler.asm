extern interrupt_handler
extern lol

%macro no_error_code_interrupt_handler 1
global interrupt_handler_%1
interrupt_handler_%1:
    push    dword 0                     ; push 0 as error code
    push    dword 0x21                    ; push the interrupt number
    jmp     common_interrupt_handler    ; jump to the common handler
%endmacro



%macro error_code_interrupt_handler 1
global interrupt_handler_%1
interrupt_handler_%1:
    push    dword %1                    ; push the interrupt number
    jmp     common_interrupt_handler    ; jump to the common handler
%endmacro

common_interrupt_handler:
    ;save registers
    push eax
    push ebx
    push ecx
    push edx
    push ebp
    push esi
    push edi

    ; call c function
    call interrupt_handler

    xchg bx, bx
    pop edi
    pop esi
    pop ebp
    pop edx
    pop ecx
    pop ebx
    pop eax
    
    add esp, 8
    iret


no_error_code_interrupt_handler 33 ; keyboard
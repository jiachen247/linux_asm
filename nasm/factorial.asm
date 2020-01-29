;PURPOSE - Given a number, this program computes the
; factorial. For example, the factorial of
; 3 is 3 * 2 * 1, or 6. The factorial of
; 4 is 4 * 3 * 2 * 1, or 24, and so on.
;
;This program shows how to call a function recursively.
SECTION  .data
                                        ; This program has no global data
SECTION  .text
GLOBAL _start

GLOBAL factorial        ; this is unneeded unless we want to share
                                        ; this function among other programs
_start: 
        push  dword 4           ; The factorial takes one argument - the
                                        ; number we want a factorial of. So, it
                                        ; gets pushed
        push esp ; idk if this is allowed

        call factorial  ; run the factorial function
        add  esp,4      ; Scrubs the parameter that was pushed on
                                        ; the stack     
        mov  ebx,eax    ; factorial returns the answer in %eax, but
                                        ; we want it in %ebx to send it as our exit
                                        ; status
        mov  eax,1      ; call the kernel’s exit function
        int 080h
                                        ; This is the actual function definition

GLOBAL factorial:function
factorial: 

        mov eax, esp;
        sub esp 4
        push eax
        mov eax, [eax+12]
        cmp eax, 1;
        je end_factorial
        dec eax
        mov [esp+4], eax
        call factorial
        mov ebx, [eax+12]
        imul  eax,ebx 
        
end_factorial: 
        mov  esp, [esp]
        ret
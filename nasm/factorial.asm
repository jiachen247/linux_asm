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
        push  dword 8          ; The factorial takes one argument - the
                                        ; number we want a factorial of. So, it
                                        ; gets pushed
        push esp ; idk if this is allowed

        call factorial  ; run the factorial function
        add  esp,8      ; Scrubs the parameter that was pushed on
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
        sub esp, 4; reserve however much space you need for local vars
        push eax; push old esp to the top of the stack
        mov eax, [eax+8]; get paraments as ofset from old esp that can be found at the top of the stack
        cmp eax, 1;
        je end_factorial;
        dec eax;
        mov [esp+4], eax;
        call factorial;
        mov ebx, [esp+16];
        imul  eax, ebx ;
        
end_factorial: 
        mov  esp, [esp]; where the magic happens, reset esp to previous pointer
        ret;

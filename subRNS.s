.text
.global subRNS

# Funkcja odejmuje dwie liczby zapisane w systemie RNS.
# Wynik jest zapisany w liczbie pierwszej.

# Funkcja dostaje trzy argumenty:
# 1. liczba pierwsza                          %rdi
# 2. liczba druga                             %rsi
# 3. tablica N                                %rdx

# VARIABLES:
# r8 - liczba pierwsza      rdi
# r9 - liczba druga         rsi
# r10 - tablica N           rdx
# r11 - licznik petli
# r12 - wczytana liczba z tablicy N

subRNS:
    push %rbp
    push %r12
    mov %rsp, %rbp
    mov %rdi, %r8
    mov %rsi, %r9
    mov %rdx, %r10
    xor %r11, %r11
petla:
    clc
    movq (%r10, %r11, 8), %r12      # wykonujemy petle do momentu N[i] == 0
    cmp $0, %r12
    jz koniec
    xor %rdx, %rdx
    movq (%r8, %r11, 8), %rax       # liczba pierwsza
    movq (%r9, %r11, 8), %rcx       # liczba druga
    sub %rcx, %rax
    cmp $0, %rax
    jl make_positive
continue:
    movq %rax, (%r8, %r11, 8)
    inc %r11
    jmp petla

make_positive:
addq %r12, %rax
jmp continue

koniec:
pop %r12
pop %rbp
ret
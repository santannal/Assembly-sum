section .data
    num1 dd 20
    num2 dd 30
    res dd 0
    res_msg db "Result: ", 0
    res_msg_len equ $ - res_msg
    buffer db "00000000", 0  

section .text
    global _start

_start:
    ; somando
    mov eax, [num1]
    mov ebx, [num2]
    add eax, ebx
    mov [res], eax

    ; Print
    mov eax, 4
    mov ebx, 1
    mov ecx, res_msg
    mov edx, res_msg_len
    int 0x80

    ;Conversão do resultado para string
    mov eax, [res]
    mov edi, buffer + 7  
    mov ecx, 10

convert_loop:
    xor edx, edx       
    div ecx            
    add dl, '0'        
    mov [edi], dl      
    dec edi            
    test eax, eax      
    jnz convert_loop   

    ; tamanho da string
    mov eax, buffer + 8  
    sub eax, edi         
    dec eax             

    ; Print
    mov eax, 4
    mov ebx, 1
    lea ecx, [edi + 1] 
    mov edx, eax      
    int 0x80

    ; Exit the program
    mov eax, 1
    xor ebx, ebx
    int 0x80

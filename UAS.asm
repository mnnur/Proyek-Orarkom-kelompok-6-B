org 0x100
global start
section .text

start:                  
    mov  dx, name           ;String name dimasukkan ke dx
    call printString        ;Menjalankan fungsi printString
    call getAnswer          ;Menjalankan fungsi getAnswer
    cmp  al, ' '            ;mengecek apakah al = ' ' (karakter apapun) -> fungsinya berhubungan dengan je
    je   Time               ;je(Jump if equal), jika al sama dengan ' ' maka akan loncat ke fungsi Time   

Time:               
    mov  dx, time           ;string time dimasukkan ke dx
    call printString        ;menjalankan fungsi printString
    call getAnswer          ;menjalankan fungsi getAnswer
    cmp  al, 'a'            ;mengecek apakah al = 'a' (karakter a) -> fungsinya akan berhubungan dengan je
    je   Pagi               ;je(jump if equal), jika al sama dengan 'a' maka akan loncat ke fungsi Pagi

Sore:                       ;kasus else, jika kasus di Time (cmp al, 'a') tidak terpenuhi (karakter tidak sama dengan 'a')
                            ;maka fungsi ini akan dijalankan
    mov  dx, pm             ;string pm dimasukkan ke dx
    call printString        ;menjalankan fungsi printString
    jmp  done               ;mengakhiri kasus else (sore) dengan berpindah ke done

Pagi:                       ;kasus then, jika kasus di Time (cmp al, 'a') terpenuhi (karakter sama dengan 'a')
                            ;maka fungsi ini akan dijalankan
    mov  dx, am             ;string am dimasukkan ke dx
    call printString        ;menjalankan fungsi printString
    jmp  done               ;mengakhiri kasus then (pagi) dengan berpindah ke done

done:                       ;fungsi untuk menyelesaikan program
    mov  al, 0              ;mengosongkan al
    mov  ah, 0x4c           ;exit
    int  0x21               ;interrupt

printString:
    mov  ah, 9              ;interrupt untuk output string
    int  0x21               ;interrupt
    ret                     ;ret(return), kembali ke letak fungsi 'call printString' yang sebelumnya menjalankan program ini 

getAnswer:
    mov  dx, answer         ;string answer dimasukkan ke dx
    mov  ah, 0x0a           ;fungsi untuk input string
    int  0x21               ;interrupt
    mov  al, [answer+2]     ;[answer+2] dimasukkan ke al
    ret                     ;ret(return), kembali ke letak fungsi 'call getAnswer' yang sebelumnya menjalankan program ini

name    db "Ur name?     $"                 ;string name
time    db "pm or am?$"                     ;string time
am      db 'Selamat pagi ', 0x0d, 0x0a, '$' ;string am    
pm      db 'Selamat sore ', 0x0d, 0x0a, '$' ;string pm

answer  db 50, 0            ;membuat batas dari maksimal karakter yang bisa diinput sebanyak 50
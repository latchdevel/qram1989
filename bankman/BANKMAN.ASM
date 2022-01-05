;; Disassembly of BANKMAN by Amstrad/Locomotive Software
;; https://cpctech.cpc-live.com/docs/bankman.asm [30-December-2013]

0000 f5        push    af
;; identify load location for this code.
0001 21e1e9    ld      hl,0e9e1h ;; pop hl: jp (hl)
0004 223000    ld      (0030h),hl ;; RST 6: user restart
0007 f7        rst     30h ;; RST 6: user restart
;; get address from stack (which is return address)
;; and run to it.

;; HL = address of code
0008 eb        ex      de,hl
0009 214e00    ld      hl,004eh	;; relocation table
000c 19        add     hl,de
;; read 16-bit address; 0 means end of list
000d 4e        ld      c,(hl)	
000e 23        inc     hl
000f 46        ld      b,(hl)
0010 23        inc     hl
0011 79        ld      a,c
0012 b0        or      b
0013 2814      jr      z,0029h ;; finished relocating code

0015 e5        push    hl
0016 60        ld      h,b
0017 69        ld      l,c
0018 19        add     hl,de
0019 e5        push    hl
001a 4e        ld      c,(hl)
001b 23        inc     hl
001c 46        ld      b,(hl)
001d 60        ld      h,b
001e 69        ld      l,c
001f 19        add     hl,de
0020 44        ld      b,h
0021 4d        ld      c,l
0022 e1        pop     hl
0023 71        ld      (hl),c
0024 23        inc     hl
0025 70        ld      (hl),b
0026 e1        pop     hl
0027 18e4      jr      000dh ;; continue relocating code.

0029 3ec9      ld      a,0c9h
002b 32f8ff    ld      (0fff8h),a

002e f1        pop     af
002f b7        or      a
0030 2003      jr      nz,0035h

0032 326901    ld      (0169h),a

0035 213401    ld      hl,0134h ;; look for SCREENCOPY (first command registered by us)
0038 cdd4bc    call    0bcd4h	;; KL FIND COMMAND
003b d8        ret     c		;; already setup

003c 21f8ff    ld      hl,0fff8h
003f 110080    ld      de,8000h
0042 b7        or      a
0043 ed52      sbc     hl,de
0045 3006      jr      nc,004dh		;; setup commands

0047 21fe00    ld      hl,00feh		;; display "Too low"
004a c31305    jp      0513h

004d 011701    ld      bc,0117h		;; rsx command table
0050 210301    ld      hl,0103h		;; bytes to be used by firmware
0053 c3d1bc    jp      0bcd1h		;; KL LOG EXT

;; relocation table
0056 24        inc     h
0057 00        nop     
0058 2b        dec     hl
0059 00        nop     
005a 35        dec     (hl)
005b 00        nop     
005c 40        ld      b,b
005d 00        nop     
005e 43        ld      b,e
005f 00        nop     
0060 46        ld      b,(hl)
0061 00        nop     
0062 49        ld      c,c
0063 00        nop     
0064 17        rla     
0065 011a01    ld      bc,011ah
0068 1d        dec     e
0069 012001    ld      bc,0120h
006c 23        inc     hl
006d 012601    ld      bc,0126h
0070 29        add     hl,hl
0071 012c01    ld      bc,012ch
0074 2f        cpl     
0075 013201    ld      bc,0132h
0078 78        ld      a,b
0079 018001    ld      bc,0180h
007c 8b        adc     a,e
007d 019a01    ld      bc,019ah
0080 ac        xor     h
0081 01b401    ld      bc,01b4h
0084 c201d3    jp      nz,0d301h
0087 01e001    ld      bc,01e0h
008a e7        rst     20h
008b 01ed01    ld      bc,01edh
008e f0        ret     p

008f 01f301    ld      bc,01f3h
0092 fb        ei      
0093 010c02    ld      bc,020ch
0096 0f        rrca    
0097 02        ld      (bc),a
0098 1802      jr      009ch
009a 3a0254    ld      a,(5402h)
009d 02        ld      (bc),a
009e 65        ld      h,l
009f 02        ld      (bc),a
00a0 76        halt    
00a1 02        ld      (bc),a
00a2 af        xor     a
00a3 02        ld      (bc),a
00a4 cb02      rlc     d
00a6 2e03      ld      l,03h
00a8 3a0340    ld      a,(4003h)
00ab 03        inc     bc
00ac 51        ld      d,c
00ad 03        inc     bc
00ae 62        ld      h,d
00af 03        inc     bc
00b0 65        ld      h,l
00b1 03        inc     bc
00b2 68        ld      l,b
00b3 03        inc     bc
00b4 6b        ld      l,e
00b5 03        inc     bc
00b6 6e        ld      l,(hl)
00b7 03        inc     bc
00b8 7a        ld      a,d
00b9 03        inc     bc
00ba 8b        adc     a,e
00bb 03        inc     bc
00bc 96        sub     (hl)
00bd 03        inc     bc
00be a8        xor     b
00bf 03        inc     bc
00c0 ab        xor     e
00c1 03        inc     bc
00c2 b1        or      c
00c3 03        inc     bc
00c4 ba        cp      d
00c5 03        inc     bc
00c6 bd        cp      l
00c7 03        inc     bc
00c8 c1        pop     bc
00c9 03        inc     bc
00ca cb03      rlc     e
00cc f5        push    af
00cd 03        inc     bc
00ce fe03      cp      03h
00d0 1804      jr      00d6h
00d2 6e        ld      l,(hl)
00d3 04        inc     b
00d4 77        ld      (hl),a
00d5 04        inc     b
00d6 9a        sbc     a,d
00d7 04        inc     b
00d8 c204ce    jp      nz,0ce04h
00db 04        inc     b
00dc 0b        dec     bc
00dd 05        dec     b
00de 2e00      ld      l,00h
00e0 86        add     a,(hl)
00e1 019501    ld      bc,0195h
00e4 ba        cp      d
00e5 01c701    ld      bc,01c7h
00e8 08        ex      af,af'
00e9 02        ld      (bc),a
00ea a5        and     l
00eb 02        ld      (bc),a
00ec c7        rst     00h
00ed 02        ld      (bc),a
00ee 5f        ld      e,a
00ef 03        inc     bc
00f0 76        halt    
00f1 03        inc     bc
00f2 ae        xor     (hl)
00f3 03        inc     bc
00f4 f8        ret     m

00f5 03        inc     bc
00f6 55        ld      d,l
00f7 04        inc     b
00f8 5a        ld      e,d
00f9 04        inc     b
00fa 71        ld      (hl),c
00fb 04        inc     b
00fc c9        ret     

00fd 04        inc     b
00fe e5        push    hl
00ff 04        inc     b
0100 f6
0101 defw &0411 ;; screen offset 4000
0103 defw &0005 ;; screen offset c000
0105 defb 0 ;; swap/copy flag for SCREENCOPY/SCREENSWAP
0106 defb "Too low",13,10
010e defs 3 ;; bytes used by firmware (including LF of previous text)
0112 defb "Bad command",13,10
011f defw &0134	;; address of commands
0121 c30402    jp      0204h	;; SCREENSWAP
0124 c30002    jp      0200h	;; SCREENCOPY
0127 c32b03    jp      032bh	;; BANKOPEN
012a c3ee03    jp      03eeh	;; BANKWRITE
012d c36704    jp      0467h	;; BANKREAD
0130 c34303    jp      0343h	;; BANKFIND
0133 c37501    jp      0175h	;; VIEW
0136 c3a901    jp      01a9h	;; VDU
0139 c3ea01    jp      01eah	;; VDU0
013c defb "SCREENSWA","P"+&80
     defb "SCREENCOP","Y"+&80
     defb "BANKOPE","N"+&80
     defb "BANKWRIT","E"+&80
     defb "BANKREA","D"+&80
     defb "BANKFIN","D"+&80
     defb "VIE","W"+&80
     defb "VD","U"+&80
     defb "VDU","0"+&80
     defb 0

;;--------------------------------------------------------------------------------

;; |VIEW,<screen> 
;; Display screen by changing base address
;; <screen> 0->4000-7fff, 1->c000-ffff
017d fe01      cp      01h
017f c21005    jp      nz,0510h ;; display bad command and quit

0182 dd7e00    ld      a,(ix+00h) ;; screen base wanted (0 or 1)
0185 fe02      cp      02h
0187 d21005    jp      nc,0510h ;; display bad command and quit

018a b7        or      a
018b 280f      jr      z,019ch	;; 0 = 4000, 1 = c000

018d cdd801    call    01d8h	;; get screen location and store it
0190 e5        push    hl
0191 f5        push    af
0192 2afb00    ld      hl,(00fbh) ;; screen offset (c000) 
0195 cd05bc    call    0bc05h ;; SCR SET OFFSET
0198 3ec0      ld      a,0c0h	;; &c000-&ffff
019a 180d      jr      01a9h

019c cdd801    call    01d8h	;; get screen location and store it
019f e5        push    hl
01a0 f5        push    af
01a1 2af900    ld      hl,(00f9h) ;; screen offset 4000
01a4 cd05bc    call    0bc05h ;; SCR SET OFFSET
01a7 3e40      ld      a,40h	;; &4000-&7fff

01a9 cd08bc    call    0bc08h ;; SCR SET BASE
01ac f1        pop     af
01ad e1        pop     hl
01ae c355bd    jp      0bd55h ;; SCR SET POSITION


;;--------------------------------------------------------------------------------
;; |VDU,<screen> 
;; Display screen by changing base address and when viewing &4000-&7fff ensure main bank selected
;; <screen> 0->4000-7fff, 1->c000-ffff

;; "VDU"
01b1 fe01      cp      01h
01b3 c21005    jp      nz,0510h ;; display bad command and quit

01b6 dd7e00    ld      a,(ix+00h) ;; screen base wanted (0 or 1)
01b9 fe02      cp      02h		
01bb d21005    jp      nc,0510h ;; display bad command and quit
01be b7        or      a
01bf 280d      jr      z,01ceh	;; 0 = 4000, 1 = c000

01c1 cdd801    call    01d8h	;; get screen location and store it
01c4 3ec0      ld      a,0c0h
01c6 cd08bc    call    0bc08h ;; SCR SET BASE
01c9 2afb00    ld      hl,(00fbh) ;; screen offset (c000)
01cc 180f      jr      01ddh

01ce cdd801    call    01d8h ;; get screen location and store it
01d1 af        xor     a 		;; configuration 0
01d2 cd5bbd    call    0bd5bh ;; KL BANK SWITCH (firmware v1.1)
01d5 3e40      ld      a,40h
01d7 cd08bc    call    0bc08h ;; SCR SET BASE
01da 2af900    ld      hl,(00f9h) ;; screen offset 4000
01dd c305bc    jp      0bc05h ;; SCR SET OFFSET

;; get screen location and store it
01e0 cd0bbc    call    0bc0bh ;; SCR GET LOCATION
01e3 fec0      cp      0c0h
01e5 2004      jr      nz,01ebh
01e7 22fb00    ld      (00fbh),hl ;; screen offset (c000)
01ea c9        ret     

01eb fe40      cp      40h
01ed c0        ret     nz

01ee 22f900    ld      (00f9h),hl  ;; screen offset 4000
01f1 c9        ret     

;; |VDU0,<bank>
;; view screen but restore bank 0
01f2 fe01      cp      01h
01f4 c21005    jp      nz,0510h ;; display bad command and quit
01f7 cd1103    call    0311h ;; convert actual bank to hardware number
01fa d21005    jp      nc,0510h ;; display bad command and quit
01fd dd7e00    ld      a,(ix+00h) ;; hardware bank number
0200 feff      cp      0ffh ;; id for base
0202 ca1005    jp      z,0510h ;; display bad command and quit
0205 c35bbd    jp      0bd5bh ;; KL BANK SWITCH (firmware v1.1)

;; |SCREENCOPY,<section>,<destination>,<source>
0208 f5        push    af
0209 af        xor     a ;; copy operation
020a 1803      jr      020fh

;; |SCREENSWAP,<section>,<destination>,<source>
020c f5        push    af
020d 3eff      ld      a,0ffh ;; swap operation

;; <section>,<destination>,<source>
;; <destination>/<source> = 0 = bad, 1 = normal, 2 = c4 ,3 = c5,4 = c6 ,5 = c7


;; 0=copy, &ff = swap
020f 32fd00    ld      (00fdh),a
0212 f1        pop     af
0213 cdfc02    call    02fch ;; convert <source>/<destination> to actual bank number for hardware
0216 d21005    jp      nc,0510h ;; display bad command and quit
0219 fe03      cp      03h		;; <section>,<source>,<destination>
021b 286f      jr      z,028ch 

021d fe02      cp      02h		;; <source>,<destination>
021f c21005    jp      nz,0510h ;; display bad command and quit

0222 010040    ld      bc,4000h

0225 60        ld      h,b
0226 69        ld      l,c
0227 1100c0    ld      de,0c000h
 
022a 3eff      ld      a,0ffh	;; base bank number
022c ddbe00    cp      (ix+00h)
022f 281a      jr      z,024bh ;; ix+0 is base
0231 ddbe02    cp      (ix+02h)
0234 281b      jr      z,0251h ;; ix+2 is base

;; <source>,<destination>
;; bank to bank

0236 010000    ld      bc,0000h
0239 210040    ld      hl,4000h ;; base to copy from/to
023c 09        add     hl,bc
023d c5        push    bc
023e 010001    ld      bc,0100h
0241 cda402    call    02a4h	;; copy from bank to bank
0244 c1        pop     bc
0245 04        inc     b
0246 cb70      bit     6,b
0248 28ef      jr      z,0239h
024a c9        ret     

;; <source>,<destination>
;; ix+00 = base
024b dd7e02    ld      a,(ix+02h)
024e eb        ex      de,hl
024f 1803      jr      0254h

;; <source>,<destination>
;; ix+0 = bank, ix+2 = base
0251 dd7e00    ld      a,(ix+00h)
0254 feff      cp      0ffh ;; id for base
0256 c8        ret     z ;; quit if base to base

0257 cd5bbd    call    0bd5bh ;; KL BANK SWITCH (firmware v1.1)
025a f5        push    af
025b 3afd00    ld      a,(00fdh) ;; 0 = copy, ff = swap
025e b7        or      a
025f 2005      jr      nz,0266h ;; swap 256 bytes at a time
;; copy
0261 f1        pop     af
0262 edb0      ldir    
0264 1823      jr      0289h

;; copy 256 bytes at a time
0266 f1        pop     af
0267 c5        push    bc
0268 010001    ld      bc,0100h
026b d5        push    de
026c 11f9ff    ld      de,0fff9h
026f e5        push    hl
0270 edb0      ldir    
0272 d1        pop     de
0273 e1        pop     hl
0274 e5        push    hl
0275 010001    ld      bc,0100h
0278 edb0      ldir    
027a eb        ex      de,hl
027b d1        pop     de
027c e5        push    hl
027d 21f9ff    ld      hl,0fff9h
0280 010001    ld      bc,0100h
0283 edb0      ldir    
0285 e1        pop     hl
0286 c1        pop     bc
0287 10de      djnz    0267h
0289 c35bbd    jp      0bd5bh ;; KL BANK SWITCH (firmware v1.1)

;; SCREENCOPY,SCREENSWAP by section
028c dd7e04    ld      a,(ix+04h) ;; section number
028f e63f      and     3fh
0291 47        ld      b,a
0292 0e00      ld      c,00h
0294 2100c0    ld      hl,0c000h
0297 09        add     hl,bc
0298 eb        ex      de,hl
0299 210040    ld      hl,4000h
029c 09        add     hl,bc
029d 010001    ld      bc,0100h

02a0 3eff      ld      a,0ffh ;; id for base
02a2 ddbe00    cp      (ix+00h)
02a5 28a4      jr      z,024bh ;; ix+0 is base
02a7 ddbe02    cp      (ix+02h)
02aa 28a5      jr      z,0251h ;; ix+2 is base

;; switch bank, copy and then restore bank
;; HL = address
;; IX+0 = destination bank, IX+2 = source bank
02ac 11f9ff    ld      de,0fff9h
02af dd7e00    ld      a,(ix+00h)
02b2 cd5bbd    call    0bd5bh ;; KL BANK SWITCH (firmware v1.1)
02b5 f5        push    af
02b6 3afd00    ld      a,(00fdh) ;; 0 = copy, ff = swap
02b9 b7        or      a
02ba 2012      jr      nz,02ceh ;; swap copy 128 bytes at a time
;; copy
02bc d5        push    de
02bd e5        push    hl
02be c5        push    bc
02bf edb0      ldir    
02c1 c1        pop     bc
02c2 d1        pop     de
02c3 e1        pop     hl
02c4 dd7e02    ld      a,(ix+02h) ;; destination
02c7 cd5bbd    call    0bd5bh ;; KL BANK SWITCH (firmware v1.1)
02ca edb0      ldir    
02cc 1807      jr      02d5h

02ce cdd102    call    02d1h ;; copy 128 bytes
02d1 eb        ex      de,hl
02d2 cdd102    call    02d1h ;; copy 128 bytes

02d5 f1        pop     af
02d6 c35bbd    jp      0bd5bh ;; KL BANK SWITCH (firmware v1.1)

;; copy 128 bytes at a time
02d9 d5        push    de
02da e5        push    hl
02db 018000    ld      bc,0080h
02de edb0      ldir    
02e0 e1        pop     hl
02e1 dd7e02    ld      a,(ix+02h) 
02e4 cd5bbd    call    0bd5bh ;; KL BANK SWITCH (firmware v1.1)
02e7 e5        push    hl
02e8 018000    ld      bc,0080h
02eb edb0      ldir    
02ed d1        pop     de
02ee e1        pop     hl
02ef e5        push    hl
02f0 d5        push    de
02f1 018000    ld      bc,0080h
02f4 edb0      ldir    
02f6 d1        pop     de
02f7 dd7e00    ld      a,(ix+00h)
02fa cd5bbd    call    0bd5bh ;; KL BANK SWITCH (firmware v1.1)
02fd 018000    ld      bc,0080h
0300 edb0      ldir    
0302 e1        pop     hl
0303 c9        ret     

;;---------------------
0304 f5        push    af
0305 dd7e02    ld      a,(ix+02h) ;; destination
0308 b7        or      a
0309 280a      jr      z,0315h

030b d602      sub     02h ;; base?
030d 3806      jr      c,0315h

030f c604      add     a,04h ;; 0->4, 1->5, 2->6, 3->7 for bank registers

0311 fe08      cp      08h	;; limit to 64KB
0313 301b      jr      nc,0330h	

;; actual bank selection for hardware
0315 dd7702    ld      (ix+02h),a
0318 f1        pop     af

;;-------------------
0319 f5        push    af
031a dd7e00    ld      a,(ix+00h) ;; source
031d b7        or      a
031e 280a      jr      z,032ah
0320 d602      sub     02h ;; base?
0322 3806      jr      c,032ah
0324 c604      add     a,04h	;; 0->4, 1->5, 2->6, 3->7 for bank registers
0326 fe08      cp      08h ;; limit to 64KB
0328 3006      jr      nc,0330h
;; actual bank selection for hardware

032a dd7700    ld      (ix+00h),a
032d f1        pop     af
;; success
032e 37        scf     
032f c9        ret     

;; error
0330 f1        pop     af
0331 b7        or      a
0332 c9        ret     

;; |BANKOPEN,<bank>
0333 fe01      cp      01h		;; 1 parameter
0335 c21005    jp      nz,0510h ;; display bad command and quit
0338 dd7e01    ld      a,(ix+01h) ;; check upper byte is zero
033b b7        or      a
033c 20f7      jr      nz,0335h

033e dd7e00    ld      a,(ix+00h)
0341 320701    ld      (0107h),a ;; bank to use?
0344 210000    ld      hl,0000h 
0347 220801    ld      (0108h),hl ;; offset in bank
034a c9        ret     

;; BANKFIND
034b 21ffff    ld      hl,0ffffh
034e fe02      cp      02h
0350 2814      jr      z,0366h
0352 fe03      cp      03h
0354 2810      jr      z,0366h
0356 fe04      cp      04h
0358 c21005    jp      nz,0510h ;; display bad command and quit

035b dd6601    ld      h,(ix+01h)
035e dd6e00    ld      l,(ix+00h)
0361 3d        dec     a
0362 dd23      inc     ix
0364 dd23      inc     ix
0366 220101    ld      (0101h),hl
0369 cdb704    call    04b7h
036c d24e04    jp      nc,044eh ;; end of file error

036f 22fe00    ld      (00feh),hl
0372 cdf504    call    04f5h
0375 320001    ld      (0100h),a
0378 eb        ex      de,hl
0379 2802      jr      z,037dh
037b edb0      ldir    
037d 3a0001    ld      a,(0100h)
0380 4f        ld      c,a
0381 2afe00    ld      hl,(00feh)
0384 eb        ex      de,hl
0385 7a        ld      a,d
0386 41        ld      b,c
0387 e6c0      and     0c0h
0389 07        rlca    
038a 07        rlca    
038b c604      add     a,04h
038d 4f        ld      c,a ;; set bank
038e cd5bbd    call    0bd5bh ;; KL BANK SWITCH (firmware v1.1)
0391 b7        or      a
0392 c24104    jp      nz,0441h ;; restore main bank indicate bank switching failure

0395 cbf2      set     6,d
0397 cbba      res     7,d
0399 78        ld      a,b
039a b7        or      a
039b 280d      jr      z,03aah
039d 21f9ff    ld      hl,0fff9h
03a0 eb        ex      de,hl
03a1 1a        ld      a,(de)
03a2 b7        or      a
03a3 2803      jr      z,03a8h
03a5 be        cp      (hl)
03a6 200d      jr      nz,03b5h
03a8 1037      djnz    03e1h
03aa af        xor     a ;; restore main ram
03ab cd5bbd    call    0bd5bh ;; KL BANK SWITCH (firmware v1.1)
03ae ed5b0801  ld      de,(0108h)
03b2 c35d04    jp      045dh	;; store result

03b5 2afe00    ld      hl,(00feh)
03b8 3a0701    ld      a,(0107h)
03bb 4f        ld      c,a
03bc 0600      ld      b,00h
03be 09        add     hl,bc
03bf 381a      jr      c,03dbh
03c1 22fe00    ld      (00feh),hl
03c4 2a0801    ld      hl,(0108h)
03c7 ed5b0101  ld      de,(0101h)
03cb b7        or      a
03cc ed52      sbc     hl,de
03ce 300b      jr      nc,03dbh
03d0 19        add     hl,de
03d1 23        inc     hl
03d2 220801    ld      (0108h),hl
03d5 af        xor     a ;; restore main ram
03d6 cd5bbd    call    0bd5bh ;; KL BANK SWITCH (firmware v1.1)
03d9 18a2      jr      037dh

03db af        xor     a ;; restore main ram
03dc cd5bbd    call    0bd5bh ;; KL BANK SWITCH (firmware v1.1)
03df 1870      jr      0451h ;; no match found

03e1 23        inc     hl
03e2 13        inc     de
03e3 7d        ld      a,l
03e4 b7        or      a
03e5 20ba      jr      nz,03a1h
03e7 7c        ld      a,h
03e8 e63f      and     3fh
03ea 20b5      jr      nz,03a1h
03ec f640      or      40h
03ee 67        ld      h,a
03ef 79        ld      a,c
03f0 3c        inc     a
03f1 cd5bbd    call    0bd5bh ;; KL BANK SWITCH (firmware v1.1)
03f4 18ab      jr      03a1h

;; BANK WRITE
03f6 fe02      cp      02h
03f8 2805      jr      z,03ffh
03fa fe03      cp      03h
03fc c21005    jp      nz,0510h ;; display bad command and quit
03ff cdb704    call    04b7h
0402 3052      jr      nc,0456h ;; end of file error
0404 e5        push    hl
0405 cdf504    call    04f5h
0408 eb        ex      de,hl
0409 2804      jr      z,040fh
040b c5        push    bc
040c edb0      ldir    
040e c1        pop     bc
040f d1        pop     de
0410 7a        ld      a,d
0411 41        ld      b,c
0412 e6c0      and     0c0h
0414 07        rlca    
0415 07        rlca    
0416 c604      add     a,04h
0418 4f        ld      c,a
0419 cd5bbd    call    0bd5bh ;; KL BANK SWITCH (firmware v1.1)
041c b7        or      a
041d 202a      jr      nz,0449h ;; restore main bank indicate bank switching failure

041f 21f9ff    ld      hl,0fff9h
0422 cbf2      set     6,d
0424 cbba      res     7,d
0426 78        ld      a,b
0427 b7        or      a
0428 2804      jr      z,042eh	;; restore main ram

042a 7e        ld      a,(hl)
042b 12        ld      (de),a
042c 1006      djnz    0434h

042e af        xor     a ;; restore main ram
042f cd5bbd    call    0bd5bh ;; KL BANK SWITCH (firmware v1.1)
0432 1827      jr      045bh ;; store result

0434 23        inc     hl
0435 13        inc     de
0436 7b        ld      a,e
0437 b7        or      a
0438 20f0      jr      nz,042ah
043a 7a        ld      a,d
043b e63f      and     3fh
043d 20eb      jr      nz,042ah
043f f640      or      40h
0441 57        ld      d,a
0442 79        ld      a,c
0443 3c        inc     a
0444 cd5bbd    call    0bd5bh ;; KL BANK SWITCH (firmware v1.1)
0447 18e1      jr      042ah

0449 cd5bbd    call    0bd5bh ;; KL BANK SWITCH (firmware v1.1)
044c 11fdff    ld      de,0fffdh ;; -3 (bank switching failure)
044f 1814      jr      0465h	;; store result

0451 11feff    ld      de,0fffeh ;; -2 (no match found)
0454 180f      jr      0465h	;; store result

0456 11ffff    ld      de,0ffffh ;; -1 (end of file error)
0459 180a      jr      0465h	;; store result

045b ed5b0801  ld      de,(0108h)
045f 13        inc     de
0460 ed530801  ld      (0108h),de
0464 1b        dec     de

;; store result
0465 dd6e02    ld      l,(ix+02h)
0468 dd6603    ld      h,(ix+03h)
046b 73        ld      (hl),e
046c 23        inc     hl
046d 72        ld      (hl),d
046e c9        ret     

;; BANKREAD
046f fe02      cp      02h
0471 2805      jr      z,0478h
0473 fe03      cp      03h
0475 c21005    jp      nz,0510h ;; display bad command and quit
0478 cdb704    call    04b7h
047b 30d9      jr      nc,0456h ;; end of file error
047d e5        push    hl
047e cdf504    call    04f5h
0481 d1        pop     de
0482 7a        ld      a,d
0483 41        ld      b,c
0484 e6c0      and     0c0h
0486 07        rlca    
0487 07        rlca    
0488 c604      add     a,04h
048a 4f        ld      c,a
048b cd5bbd    call    0bd5bh ;; KL BANK SWITCH (firmware v1.1)
048e b7        or      a
048f 20b8      jr      nz,0449h ;; restore main bank indicate bank switching failure
0491 cbf2      set     6,d
0493 cbba      res     7,d
0495 78        ld      a,b
0496 b7        or      a
0497 2804      jr      z,049dh
0499 1a        ld      a,(de)
049a 77        ld      (hl),a
049b 100d      djnz    04aah
049d af        xor     a
049e cd5bbd    call    0bd5bh ;; KL BANK SWITCH (firmware v1.1)
04a1 cdf504    call    04f5h
04a4 28b5      jr      z,045bh ;; store result
04a6 edb0      ldir    
04a8 18b1      jr      045bh ;; store result

04aa 23        inc     hl
04ab 13        inc     de
04ac 7b        ld      a,e
04ad b7        or      a
04ae 20e9      jr      nz,0499h
04b0 7a        ld      a,d
04b1 e63f      and     3fh
04b3 20e4      jr      nz,0499h
04b5 f640      or      40h
04b7 57        ld      d,a
04b8 79        ld      a,c
04b9 3c        inc     a
04ba cd5bbd    call    0bd5bh ;; KL BANK SWITCH (firmware v1.1)
04bd 18da      jr      0499h
04bf fe02      cp      02h
04c1 280d      jr      z,04d0h
04c3 dd6e00    ld      l,(ix+00h)
04c6 dd6601    ld      h,(ix+01h)
04c9 220801    ld      (0108h),hl
04cc dd23      inc     ix
04ce dd23      inc     ix
04d0 3a0701    ld      a,(0107h)
04d3 47        ld      b,a
04d4 ed5b0801  ld      de,(0108h)
04d8 210000    ld      hl,0000h
04db cb38      srl     b
04dd 3003      jr      nc,04e2h
04df 19        add     hl,de
04e0 3808      jr      c,04eah
04e2 2808      jr      z,04ech
04e4 cb23      sla     e
04e6 cb12      rl      d
04e8 30f1      jr      nc,04dbh
04ea b7        or      a
04eb c9        ret     

04ec 3a0701    ld      a,(0107h)
04ef 5f        ld      e,a
04f0 af        xor     a
04f1 57        ld      d,a
04f2 ed5a      adc     hl,de
04f4 2802      jr      z,04f8h
04f6 38f2      jr      c,04eah
04f8 b7        or      a
04f9 ed52      sbc     hl,de
04fb 37        scf     
04fc c9        ret     

04fd 3a0701    ld      a,(0107h)
0500 4f        ld      c,a
0501 0600      ld      b,00h
0503 dd6e00    ld      l,(ix+00h)
0506 dd6601    ld      h,(ix+01h)
0509 7e        ld      a,(hl)
050a b9        cp      c
050b 3001      jr      nc,050eh
050d 4f        ld      c,a
050e 23        inc     hl
050f 5e        ld      e,(hl)
0510 23        inc     hl
0511 56        ld      d,(hl)
0512 21f9ff    ld      hl,0fff9h
0515 79        ld      a,c
0516 b7        or      a
0517 c9        ret     

;; display error
0518 210a01    ld      hl,010ah ;; "Bad command"

051b 7e        ld      a,(hl)
051c 23        inc     hl
051d cd5abb    call    0bb5ah ;; TXT OUTPUT
0520 fe0a      cp      0ah
0522 20f7      jr      nz,051bh
0524 c9        ret     

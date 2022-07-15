   1                     ; C Compiler for STM8 (COSMIC Software)
   2                     ; Parser V4.12.6 - 16 Dec 2021
   3                     ; Generator (Limited) V4.5.4 - 16 Dec 2021
  42                     ; 53 void UART2_DeInit(void)
  42                     ; 54 {
  44                     	switch	.text
  45  0000               _UART2_DeInit:
  49                     ; 57   (void) UART2->SR;
  51  0000 c65240        	ld	a,21056
  52                     ; 58   (void)UART2->DR;
  54  0003 c65241        	ld	a,21057
  55                     ; 60   UART2->BRR2 = UART2_BRR2_RESET_VALUE;  /*  Set UART2_BRR2 to reset value 0x00 */
  57  0006 725f5243      	clr	21059
  58                     ; 61   UART2->BRR1 = UART2_BRR1_RESET_VALUE;  /*  Set UART2_BRR1 to reset value 0x00 */
  60  000a 725f5242      	clr	21058
  61                     ; 63   UART2->CR1 = UART2_CR1_RESET_VALUE; /*  Set UART2_CR1 to reset value 0x00  */
  63  000e 725f5244      	clr	21060
  64                     ; 64   UART2->CR2 = UART2_CR2_RESET_VALUE; /*  Set UART2_CR2 to reset value 0x00  */
  66  0012 725f5245      	clr	21061
  67                     ; 65   UART2->CR3 = UART2_CR3_RESET_VALUE; /*  Set UART2_CR3 to reset value 0x00  */
  69  0016 725f5246      	clr	21062
  70                     ; 66   UART2->CR4 = UART2_CR4_RESET_VALUE; /*  Set UART2_CR4 to reset value 0x00  */
  72  001a 725f5247      	clr	21063
  73                     ; 67   UART2->CR5 = UART2_CR5_RESET_VALUE; /*  Set UART2_CR5 to reset value 0x00  */
  75  001e 725f5248      	clr	21064
  76                     ; 68   UART2->CR6 = UART2_CR6_RESET_VALUE; /*  Set UART2_CR6 to reset value 0x00  */
  78  0022 725f5249      	clr	21065
  79                     ; 69 }
  82  0026 81            	ret
 403                     .const:	section	.text
 404  0000               L01:
 405  0000 00000064      	dc.l	100
 406                     ; 85 void UART2_Init(uint32_t BaudRate, UART2_WordLength_TypeDef WordLength, UART2_StopBits_TypeDef StopBits, UART2_Parity_TypeDef Parity, UART2_SyncMode_TypeDef SyncMode, UART2_Mode_TypeDef Mode)
 406                     ; 86 {
 407                     	switch	.text
 408  0027               _UART2_Init:
 410  0027 520e          	subw	sp,#14
 411       0000000e      OFST:	set	14
 414                     ; 87   uint8_t BRR2_1 = 0, BRR2_2 = 0;
 418                     ; 88   uint32_t BaudRate_Mantissa = 0, BaudRate_Mantissa100 = 0;
 422                     ; 91   assert_param(IS_UART2_BAUDRATE_OK(BaudRate));
 424                     ; 92   assert_param(IS_UART2_WORDLENGTH_OK(WordLength));
 426                     ; 93   assert_param(IS_UART2_STOPBITS_OK(StopBits));
 428                     ; 94   assert_param(IS_UART2_PARITY_OK(Parity));
 430                     ; 95   assert_param(IS_UART2_MODE_OK((uint8_t)Mode));
 432                     ; 96   assert_param(IS_UART2_SYNCMODE_OK((uint8_t)SyncMode));
 434                     ; 99   UART2->CR1 &= (uint8_t)(~UART2_CR1_M);
 436  0029 72195244      	bres	21060,#4
 437                     ; 101   UART2->CR1 |= (uint8_t)WordLength; 
 439  002d c65244        	ld	a,21060
 440  0030 1a15          	or	a,(OFST+7,sp)
 441  0032 c75244        	ld	21060,a
 442                     ; 104   UART2->CR3 &= (uint8_t)(~UART2_CR3_STOP);
 444  0035 c65246        	ld	a,21062
 445  0038 a4cf          	and	a,#207
 446  003a c75246        	ld	21062,a
 447                     ; 106   UART2->CR3 |= (uint8_t)StopBits; 
 449  003d c65246        	ld	a,21062
 450  0040 1a16          	or	a,(OFST+8,sp)
 451  0042 c75246        	ld	21062,a
 452                     ; 109   UART2->CR1 &= (uint8_t)(~(UART2_CR1_PCEN | UART2_CR1_PS  ));
 454  0045 c65244        	ld	a,21060
 455  0048 a4f9          	and	a,#249
 456  004a c75244        	ld	21060,a
 457                     ; 111   UART2->CR1 |= (uint8_t)Parity;
 459  004d c65244        	ld	a,21060
 460  0050 1a17          	or	a,(OFST+9,sp)
 461  0052 c75244        	ld	21060,a
 462                     ; 114   UART2->BRR1 &= (uint8_t)(~UART2_BRR1_DIVM);
 464  0055 725f5242      	clr	21058
 465                     ; 116   UART2->BRR2 &= (uint8_t)(~UART2_BRR2_DIVM);
 467  0059 c65243        	ld	a,21059
 468  005c a40f          	and	a,#15
 469  005e c75243        	ld	21059,a
 470                     ; 118   UART2->BRR2 &= (uint8_t)(~UART2_BRR2_DIVF);
 472  0061 c65243        	ld	a,21059
 473  0064 a4f0          	and	a,#240
 474  0066 c75243        	ld	21059,a
 475                     ; 121   BaudRate_Mantissa    = ((uint32_t)CLK_GetClockFreq() / (BaudRate << 4));
 477  0069 96            	ldw	x,sp
 478  006a 1c0011        	addw	x,#OFST+3
 479  006d cd0000        	call	c_ltor
 481  0070 a604          	ld	a,#4
 482  0072 cd0000        	call	c_llsh
 484  0075 96            	ldw	x,sp
 485  0076 1c0001        	addw	x,#OFST-13
 486  0079 cd0000        	call	c_rtol
 489  007c cd0000        	call	_CLK_GetClockFreq
 491  007f 96            	ldw	x,sp
 492  0080 1c0001        	addw	x,#OFST-13
 493  0083 cd0000        	call	c_ludv
 495  0086 96            	ldw	x,sp
 496  0087 1c000b        	addw	x,#OFST-3
 497  008a cd0000        	call	c_rtol
 500                     ; 122   BaudRate_Mantissa100 = (((uint32_t)CLK_GetClockFreq() * 100) / (BaudRate << 4));
 502  008d 96            	ldw	x,sp
 503  008e 1c0011        	addw	x,#OFST+3
 504  0091 cd0000        	call	c_ltor
 506  0094 a604          	ld	a,#4
 507  0096 cd0000        	call	c_llsh
 509  0099 96            	ldw	x,sp
 510  009a 1c0001        	addw	x,#OFST-13
 511  009d cd0000        	call	c_rtol
 514  00a0 cd0000        	call	_CLK_GetClockFreq
 516  00a3 a664          	ld	a,#100
 517  00a5 cd0000        	call	c_smul
 519  00a8 96            	ldw	x,sp
 520  00a9 1c0001        	addw	x,#OFST-13
 521  00ac cd0000        	call	c_ludv
 523  00af 96            	ldw	x,sp
 524  00b0 1c0007        	addw	x,#OFST-7
 525  00b3 cd0000        	call	c_rtol
 528                     ; 126   BRR2_1 = (uint8_t)((uint8_t)(((BaudRate_Mantissa100 - (BaudRate_Mantissa * 100))
 528                     ; 127                                 << 4) / 100) & (uint8_t)0x0F); 
 530  00b6 96            	ldw	x,sp
 531  00b7 1c000b        	addw	x,#OFST-3
 532  00ba cd0000        	call	c_ltor
 534  00bd a664          	ld	a,#100
 535  00bf cd0000        	call	c_smul
 537  00c2 96            	ldw	x,sp
 538  00c3 1c0001        	addw	x,#OFST-13
 539  00c6 cd0000        	call	c_rtol
 542  00c9 96            	ldw	x,sp
 543  00ca 1c0007        	addw	x,#OFST-7
 544  00cd cd0000        	call	c_ltor
 546  00d0 96            	ldw	x,sp
 547  00d1 1c0001        	addw	x,#OFST-13
 548  00d4 cd0000        	call	c_lsub
 550  00d7 a604          	ld	a,#4
 551  00d9 cd0000        	call	c_llsh
 553  00dc ae0000        	ldw	x,#L01
 554  00df cd0000        	call	c_ludv
 556  00e2 b603          	ld	a,c_lreg+3
 557  00e4 a40f          	and	a,#15
 558  00e6 6b05          	ld	(OFST-9,sp),a
 560                     ; 128   BRR2_2 = (uint8_t)((BaudRate_Mantissa >> 4) & (uint8_t)0xF0);
 562  00e8 1e0d          	ldw	x,(OFST-1,sp)
 563  00ea 54            	srlw	x
 564  00eb 54            	srlw	x
 565  00ec 54            	srlw	x
 566  00ed 54            	srlw	x
 567  00ee 01            	rrwa	x,a
 568  00ef a4f0          	and	a,#240
 569  00f1 5f            	clrw	x
 570  00f2 6b06          	ld	(OFST-8,sp),a
 572                     ; 130   UART2->BRR2 = (uint8_t)(BRR2_1 | BRR2_2);
 574  00f4 7b05          	ld	a,(OFST-9,sp)
 575  00f6 1a06          	or	a,(OFST-8,sp)
 576  00f8 c75243        	ld	21059,a
 577                     ; 132   UART2->BRR1 = (uint8_t)BaudRate_Mantissa;           
 579  00fb 7b0e          	ld	a,(OFST+0,sp)
 580  00fd c75242        	ld	21058,a
 581                     ; 135   UART2->CR2 &= (uint8_t)~(UART2_CR2_TEN | UART2_CR2_REN);
 583  0100 c65245        	ld	a,21061
 584  0103 a4f3          	and	a,#243
 585  0105 c75245        	ld	21061,a
 586                     ; 137   UART2->CR3 &= (uint8_t)~(UART2_CR3_CPOL | UART2_CR3_CPHA | UART2_CR3_LBCL);
 588  0108 c65246        	ld	a,21062
 589  010b a4f8          	and	a,#248
 590  010d c75246        	ld	21062,a
 591                     ; 139   UART2->CR3 |= (uint8_t)((uint8_t)SyncMode & (uint8_t)(UART2_CR3_CPOL | \
 591                     ; 140     UART2_CR3_CPHA | UART2_CR3_LBCL));
 593  0110 7b18          	ld	a,(OFST+10,sp)
 594  0112 a407          	and	a,#7
 595  0114 ca5246        	or	a,21062
 596  0117 c75246        	ld	21062,a
 597                     ; 142   if ((uint8_t)(Mode & UART2_MODE_TX_ENABLE))
 599  011a 7b19          	ld	a,(OFST+11,sp)
 600  011c a504          	bcp	a,#4
 601  011e 2706          	jreq	L302
 602                     ; 145     UART2->CR2 |= (uint8_t)UART2_CR2_TEN;
 604  0120 72165245      	bset	21061,#3
 606  0124 2004          	jra	L502
 607  0126               L302:
 608                     ; 150     UART2->CR2 &= (uint8_t)(~UART2_CR2_TEN);
 610  0126 72175245      	bres	21061,#3
 611  012a               L502:
 612                     ; 152   if ((uint8_t)(Mode & UART2_MODE_RX_ENABLE))
 614  012a 7b19          	ld	a,(OFST+11,sp)
 615  012c a508          	bcp	a,#8
 616  012e 2706          	jreq	L702
 617                     ; 155     UART2->CR2 |= (uint8_t)UART2_CR2_REN;
 619  0130 72145245      	bset	21061,#2
 621  0134 2004          	jra	L112
 622  0136               L702:
 623                     ; 160     UART2->CR2 &= (uint8_t)(~UART2_CR2_REN);
 625  0136 72155245      	bres	21061,#2
 626  013a               L112:
 627                     ; 164   if ((uint8_t)(SyncMode & UART2_SYNCMODE_CLOCK_DISABLE))
 629  013a 7b18          	ld	a,(OFST+10,sp)
 630  013c a580          	bcp	a,#128
 631  013e 2706          	jreq	L312
 632                     ; 167     UART2->CR3 &= (uint8_t)(~UART2_CR3_CKEN); 
 634  0140 72175246      	bres	21062,#3
 636  0144 200a          	jra	L512
 637  0146               L312:
 638                     ; 171     UART2->CR3 |= (uint8_t)((uint8_t)SyncMode & UART2_CR3_CKEN);
 640  0146 7b18          	ld	a,(OFST+10,sp)
 641  0148 a408          	and	a,#8
 642  014a ca5246        	or	a,21062
 643  014d c75246        	ld	21062,a
 644  0150               L512:
 645                     ; 173 }
 648  0150 5b0e          	addw	sp,#14
 649  0152 81            	ret
 704                     ; 181 void UART2_Cmd(FunctionalState NewState)
 704                     ; 182 {
 705                     	switch	.text
 706  0153               _UART2_Cmd:
 710                     ; 183   if (NewState != DISABLE)
 712  0153 4d            	tnz	a
 713  0154 2706          	jreq	L542
 714                     ; 186     UART2->CR1 &= (uint8_t)(~UART2_CR1_UARTD);
 716  0156 721b5244      	bres	21060,#5
 718  015a 2004          	jra	L742
 719  015c               L542:
 720                     ; 191     UART2->CR1 |= UART2_CR1_UARTD; 
 722  015c 721a5244      	bset	21060,#5
 723  0160               L742:
 724                     ; 193 }
 727  0160 81            	ret
 859                     ; 210 void UART2_ITConfig(UART2_IT_TypeDef UART2_IT, FunctionalState NewState)
 859                     ; 211 {
 860                     	switch	.text
 861  0161               _UART2_ITConfig:
 863  0161 89            	pushw	x
 864  0162 89            	pushw	x
 865       00000002      OFST:	set	2
 868                     ; 212   uint8_t uartreg = 0, itpos = 0x00;
 872                     ; 215   assert_param(IS_UART2_CONFIG_IT_OK(UART2_IT));
 874                     ; 216   assert_param(IS_FUNCTIONALSTATE_OK(NewState));
 876                     ; 219   uartreg = (uint8_t)((uint16_t)UART2_IT >> 0x08);
 878  0163 9e            	ld	a,xh
 879  0164 6b01          	ld	(OFST-1,sp),a
 881                     ; 222   itpos = (uint8_t)((uint8_t)1 << (uint8_t)((uint8_t)UART2_IT & (uint8_t)0x0F));
 883  0166 9f            	ld	a,xl
 884  0167 a40f          	and	a,#15
 885  0169 5f            	clrw	x
 886  016a 97            	ld	xl,a
 887  016b a601          	ld	a,#1
 888  016d 5d            	tnzw	x
 889  016e 2704          	jreq	L61
 890  0170               L02:
 891  0170 48            	sll	a
 892  0171 5a            	decw	x
 893  0172 26fc          	jrne	L02
 894  0174               L61:
 895  0174 6b02          	ld	(OFST+0,sp),a
 897                     ; 224   if (NewState != DISABLE)
 899  0176 0d07          	tnz	(OFST+5,sp)
 900  0178 273a          	jreq	L133
 901                     ; 227     if (uartreg == 0x01)
 903  017a 7b01          	ld	a,(OFST-1,sp)
 904  017c a101          	cp	a,#1
 905  017e 260a          	jrne	L333
 906                     ; 229       UART2->CR1 |= itpos;
 908  0180 c65244        	ld	a,21060
 909  0183 1a02          	or	a,(OFST+0,sp)
 910  0185 c75244        	ld	21060,a
 912  0188 2066          	jra	L743
 913  018a               L333:
 914                     ; 231     else if (uartreg == 0x02)
 916  018a 7b01          	ld	a,(OFST-1,sp)
 917  018c a102          	cp	a,#2
 918  018e 260a          	jrne	L733
 919                     ; 233       UART2->CR2 |= itpos;
 921  0190 c65245        	ld	a,21061
 922  0193 1a02          	or	a,(OFST+0,sp)
 923  0195 c75245        	ld	21061,a
 925  0198 2056          	jra	L743
 926  019a               L733:
 927                     ; 235     else if (uartreg == 0x03)
 929  019a 7b01          	ld	a,(OFST-1,sp)
 930  019c a103          	cp	a,#3
 931  019e 260a          	jrne	L343
 932                     ; 237       UART2->CR4 |= itpos;
 934  01a0 c65247        	ld	a,21063
 935  01a3 1a02          	or	a,(OFST+0,sp)
 936  01a5 c75247        	ld	21063,a
 938  01a8 2046          	jra	L743
 939  01aa               L343:
 940                     ; 241       UART2->CR6 |= itpos;
 942  01aa c65249        	ld	a,21065
 943  01ad 1a02          	or	a,(OFST+0,sp)
 944  01af c75249        	ld	21065,a
 945  01b2 203c          	jra	L743
 946  01b4               L133:
 947                     ; 247     if (uartreg == 0x01)
 949  01b4 7b01          	ld	a,(OFST-1,sp)
 950  01b6 a101          	cp	a,#1
 951  01b8 260b          	jrne	L153
 952                     ; 249       UART2->CR1 &= (uint8_t)(~itpos);
 954  01ba 7b02          	ld	a,(OFST+0,sp)
 955  01bc 43            	cpl	a
 956  01bd c45244        	and	a,21060
 957  01c0 c75244        	ld	21060,a
 959  01c3 202b          	jra	L743
 960  01c5               L153:
 961                     ; 251     else if (uartreg == 0x02)
 963  01c5 7b01          	ld	a,(OFST-1,sp)
 964  01c7 a102          	cp	a,#2
 965  01c9 260b          	jrne	L553
 966                     ; 253       UART2->CR2 &= (uint8_t)(~itpos);
 968  01cb 7b02          	ld	a,(OFST+0,sp)
 969  01cd 43            	cpl	a
 970  01ce c45245        	and	a,21061
 971  01d1 c75245        	ld	21061,a
 973  01d4 201a          	jra	L743
 974  01d6               L553:
 975                     ; 255     else if (uartreg == 0x03)
 977  01d6 7b01          	ld	a,(OFST-1,sp)
 978  01d8 a103          	cp	a,#3
 979  01da 260b          	jrne	L163
 980                     ; 257       UART2->CR4 &= (uint8_t)(~itpos);
 982  01dc 7b02          	ld	a,(OFST+0,sp)
 983  01de 43            	cpl	a
 984  01df c45247        	and	a,21063
 985  01e2 c75247        	ld	21063,a
 987  01e5 2009          	jra	L743
 988  01e7               L163:
 989                     ; 261       UART2->CR6 &= (uint8_t)(~itpos);
 991  01e7 7b02          	ld	a,(OFST+0,sp)
 992  01e9 43            	cpl	a
 993  01ea c45249        	and	a,21065
 994  01ed c75249        	ld	21065,a
 995  01f0               L743:
 996                     ; 264 }
 999  01f0 5b04          	addw	sp,#4
1000  01f2 81            	ret
1057                     ; 272 void UART2_IrDAConfig(UART2_IrDAMode_TypeDef UART2_IrDAMode)
1057                     ; 273 {
1058                     	switch	.text
1059  01f3               _UART2_IrDAConfig:
1063                     ; 274   assert_param(IS_UART2_IRDAMODE_OK(UART2_IrDAMode));
1065                     ; 276   if (UART2_IrDAMode != UART2_IRDAMODE_NORMAL)
1067  01f3 4d            	tnz	a
1068  01f4 2706          	jreq	L314
1069                     ; 278     UART2->CR5 |= UART2_CR5_IRLP;
1071  01f6 72145248      	bset	21064,#2
1073  01fa 2004          	jra	L514
1074  01fc               L314:
1075                     ; 282     UART2->CR5 &= ((uint8_t)~UART2_CR5_IRLP);
1077  01fc 72155248      	bres	21064,#2
1078  0200               L514:
1079                     ; 284 }
1082  0200 81            	ret
1117                     ; 292 void UART2_IrDACmd(FunctionalState NewState)
1117                     ; 293 {
1118                     	switch	.text
1119  0201               _UART2_IrDACmd:
1123                     ; 295   assert_param(IS_FUNCTIONALSTATE_OK(NewState));
1125                     ; 297   if (NewState != DISABLE)
1127  0201 4d            	tnz	a
1128  0202 2706          	jreq	L534
1129                     ; 300     UART2->CR5 |= UART2_CR5_IREN;
1131  0204 72125248      	bset	21064,#1
1133  0208 2004          	jra	L734
1134  020a               L534:
1135                     ; 305     UART2->CR5 &= ((uint8_t)~UART2_CR5_IREN);
1137  020a 72135248      	bres	21064,#1
1138  020e               L734:
1139                     ; 307 }
1142  020e 81            	ret
1201                     ; 316 void UART2_LINBreakDetectionConfig(UART2_LINBreakDetectionLength_TypeDef UART2_LINBreakDetectionLength)
1201                     ; 317 {
1202                     	switch	.text
1203  020f               _UART2_LINBreakDetectionConfig:
1207                     ; 319   assert_param(IS_UART2_LINBREAKDETECTIONLENGTH_OK(UART2_LINBreakDetectionLength));
1209                     ; 321   if (UART2_LINBreakDetectionLength != UART2_LINBREAKDETECTIONLENGTH_10BITS)
1211  020f 4d            	tnz	a
1212  0210 2706          	jreq	L764
1213                     ; 323     UART2->CR4 |= UART2_CR4_LBDL;
1215  0212 721a5247      	bset	21063,#5
1217  0216 2004          	jra	L174
1218  0218               L764:
1219                     ; 327     UART2->CR4 &= ((uint8_t)~UART2_CR4_LBDL);
1221  0218 721b5247      	bres	21063,#5
1222  021c               L174:
1223                     ; 329 }
1226  021c 81            	ret
1347                     ; 341 void UART2_LINConfig(UART2_LinMode_TypeDef UART2_Mode, 
1347                     ; 342                      UART2_LinAutosync_TypeDef UART2_Autosync, 
1347                     ; 343                      UART2_LinDivUp_TypeDef UART2_DivUp)
1347                     ; 344 {
1348                     	switch	.text
1349  021d               _UART2_LINConfig:
1351  021d 89            	pushw	x
1352       00000000      OFST:	set	0
1355                     ; 346   assert_param(IS_UART2_SLAVE_OK(UART2_Mode));
1357                     ; 347   assert_param(IS_UART2_AUTOSYNC_OK(UART2_Autosync));
1359                     ; 348   assert_param(IS_UART2_DIVUP_OK(UART2_DivUp));
1361                     ; 350   if (UART2_Mode != UART2_LIN_MODE_MASTER)
1363  021e 9e            	ld	a,xh
1364  021f 4d            	tnz	a
1365  0220 2706          	jreq	L155
1366                     ; 352     UART2->CR6 |=  UART2_CR6_LSLV;
1368  0222 721a5249      	bset	21065,#5
1370  0226 2004          	jra	L355
1371  0228               L155:
1372                     ; 356     UART2->CR6 &= ((uint8_t)~UART2_CR6_LSLV);
1374  0228 721b5249      	bres	21065,#5
1375  022c               L355:
1376                     ; 359   if (UART2_Autosync != UART2_LIN_AUTOSYNC_DISABLE)
1378  022c 0d02          	tnz	(OFST+2,sp)
1379  022e 2706          	jreq	L555
1380                     ; 361     UART2->CR6 |=  UART2_CR6_LASE ;
1382  0230 72185249      	bset	21065,#4
1384  0234 2004          	jra	L755
1385  0236               L555:
1386                     ; 365     UART2->CR6 &= ((uint8_t)~ UART2_CR6_LASE );
1388  0236 72195249      	bres	21065,#4
1389  023a               L755:
1390                     ; 368   if (UART2_DivUp != UART2_LIN_DIVUP_LBRR1)
1392  023a 0d05          	tnz	(OFST+5,sp)
1393  023c 2706          	jreq	L165
1394                     ; 370     UART2->CR6 |=  UART2_CR6_LDUM;
1396  023e 721e5249      	bset	21065,#7
1398  0242 2004          	jra	L365
1399  0244               L165:
1400                     ; 374     UART2->CR6 &= ((uint8_t)~ UART2_CR6_LDUM);
1402  0244 721f5249      	bres	21065,#7
1403  0248               L365:
1404                     ; 376 }
1407  0248 85            	popw	x
1408  0249 81            	ret
1443                     ; 384 void UART2_LINCmd(FunctionalState NewState)
1443                     ; 385 {
1444                     	switch	.text
1445  024a               _UART2_LINCmd:
1449                     ; 386   assert_param(IS_FUNCTIONALSTATE_OK(NewState));
1451                     ; 388   if (NewState != DISABLE)
1453  024a 4d            	tnz	a
1454  024b 2706          	jreq	L306
1455                     ; 391     UART2->CR3 |= UART2_CR3_LINEN;
1457  024d 721c5246      	bset	21062,#6
1459  0251 2004          	jra	L506
1460  0253               L306:
1461                     ; 396     UART2->CR3 &= ((uint8_t)~UART2_CR3_LINEN);
1463  0253 721d5246      	bres	21062,#6
1464  0257               L506:
1465                     ; 398 }
1468  0257 81            	ret
1503                     ; 406 void UART2_SmartCardCmd(FunctionalState NewState)
1503                     ; 407 {
1504                     	switch	.text
1505  0258               _UART2_SmartCardCmd:
1509                     ; 409   assert_param(IS_FUNCTIONALSTATE_OK(NewState));
1511                     ; 411   if (NewState != DISABLE)
1513  0258 4d            	tnz	a
1514  0259 2706          	jreq	L526
1515                     ; 414     UART2->CR5 |= UART2_CR5_SCEN;
1517  025b 721a5248      	bset	21064,#5
1519  025f 2004          	jra	L726
1520  0261               L526:
1521                     ; 419     UART2->CR5 &= ((uint8_t)(~UART2_CR5_SCEN));
1523  0261 721b5248      	bres	21064,#5
1524  0265               L726:
1525                     ; 421 }
1528  0265 81            	ret
1564                     ; 429 void UART2_SmartCardNACKCmd(FunctionalState NewState)
1564                     ; 430 {
1565                     	switch	.text
1566  0266               _UART2_SmartCardNACKCmd:
1570                     ; 432   assert_param(IS_FUNCTIONALSTATE_OK(NewState));
1572                     ; 434   if (NewState != DISABLE)
1574  0266 4d            	tnz	a
1575  0267 2706          	jreq	L746
1576                     ; 437     UART2->CR5 |= UART2_CR5_NACK;
1578  0269 72185248      	bset	21064,#4
1580  026d 2004          	jra	L156
1581  026f               L746:
1582                     ; 442     UART2->CR5 &= ((uint8_t)~(UART2_CR5_NACK));
1584  026f 72195248      	bres	21064,#4
1585  0273               L156:
1586                     ; 444 }
1589  0273 81            	ret
1646                     ; 452 void UART2_WakeUpConfig(UART2_WakeUp_TypeDef UART2_WakeUp)
1646                     ; 453 {
1647                     	switch	.text
1648  0274               _UART2_WakeUpConfig:
1652                     ; 454   assert_param(IS_UART2_WAKEUP_OK(UART2_WakeUp));
1654                     ; 456   UART2->CR1 &= ((uint8_t)~UART2_CR1_WAKE);
1656  0274 72175244      	bres	21060,#3
1657                     ; 457   UART2->CR1 |= (uint8_t)UART2_WakeUp;
1659  0278 ca5244        	or	a,21060
1660  027b c75244        	ld	21060,a
1661                     ; 458 }
1664  027e 81            	ret
1700                     ; 466 void UART2_ReceiverWakeUpCmd(FunctionalState NewState)
1700                     ; 467 {
1701                     	switch	.text
1702  027f               _UART2_ReceiverWakeUpCmd:
1706                     ; 468   assert_param(IS_FUNCTIONALSTATE_OK(NewState));
1708                     ; 470   if (NewState != DISABLE)
1710  027f 4d            	tnz	a
1711  0280 2706          	jreq	L717
1712                     ; 473     UART2->CR2 |= UART2_CR2_RWU;
1714  0282 72125245      	bset	21061,#1
1716  0286 2004          	jra	L127
1717  0288               L717:
1718                     ; 478     UART2->CR2 &= ((uint8_t)~UART2_CR2_RWU);
1720  0288 72135245      	bres	21061,#1
1721  028c               L127:
1722                     ; 480 }
1725  028c 81            	ret
1748                     ; 487 uint8_t UART2_ReceiveData8(void)
1748                     ; 488 {
1749                     	switch	.text
1750  028d               _UART2_ReceiveData8:
1754                     ; 489   return ((uint8_t)UART2->DR);
1756  028d c65241        	ld	a,21057
1759  0290 81            	ret
1793                     ; 497 uint16_t UART2_ReceiveData9(void)
1793                     ; 498 {
1794                     	switch	.text
1795  0291               _UART2_ReceiveData9:
1797  0291 89            	pushw	x
1798       00000002      OFST:	set	2
1801                     ; 499   uint16_t temp = 0;
1803                     ; 501   temp = ((uint16_t)(((uint16_t)((uint16_t)UART2->CR1 & (uint16_t)UART2_CR1_R8)) << 1));
1805  0292 c65244        	ld	a,21060
1806  0295 5f            	clrw	x
1807  0296 a480          	and	a,#128
1808  0298 5f            	clrw	x
1809  0299 02            	rlwa	x,a
1810  029a 58            	sllw	x
1811  029b 1f01          	ldw	(OFST-1,sp),x
1813                     ; 503   return (uint16_t)((((uint16_t)UART2->DR) | temp) & ((uint16_t)0x01FF));
1815  029d c65241        	ld	a,21057
1816  02a0 5f            	clrw	x
1817  02a1 97            	ld	xl,a
1818  02a2 01            	rrwa	x,a
1819  02a3 1a02          	or	a,(OFST+0,sp)
1820  02a5 01            	rrwa	x,a
1821  02a6 1a01          	or	a,(OFST-1,sp)
1822  02a8 01            	rrwa	x,a
1823  02a9 01            	rrwa	x,a
1824  02aa a4ff          	and	a,#255
1825  02ac 01            	rrwa	x,a
1826  02ad a401          	and	a,#1
1827  02af 01            	rrwa	x,a
1830  02b0 5b02          	addw	sp,#2
1831  02b2 81            	ret
1865                     ; 511 void UART2_SendData8(uint8_t Data)
1865                     ; 512 {
1866                     	switch	.text
1867  02b3               _UART2_SendData8:
1871                     ; 514   UART2->DR = Data;
1873  02b3 c75241        	ld	21057,a
1874                     ; 515 }
1877  02b6 81            	ret
1911                     ; 522 void UART2_SendData9(uint16_t Data)
1911                     ; 523 {
1912                     	switch	.text
1913  02b7               _UART2_SendData9:
1915  02b7 89            	pushw	x
1916       00000000      OFST:	set	0
1919                     ; 525   UART2->CR1 &= ((uint8_t)~UART2_CR1_T8);                  
1921  02b8 721d5244      	bres	21060,#6
1922                     ; 528   UART2->CR1 |= (uint8_t)(((uint8_t)(Data >> 2)) & UART2_CR1_T8); 
1924  02bc 54            	srlw	x
1925  02bd 54            	srlw	x
1926  02be 9f            	ld	a,xl
1927  02bf a440          	and	a,#64
1928  02c1 ca5244        	or	a,21060
1929  02c4 c75244        	ld	21060,a
1930                     ; 531   UART2->DR   = (uint8_t)(Data);                    
1932  02c7 7b02          	ld	a,(OFST+2,sp)
1933  02c9 c75241        	ld	21057,a
1934                     ; 532 }
1937  02cc 85            	popw	x
1938  02cd 81            	ret
1961                     ; 539 void UART2_SendBreak(void)
1961                     ; 540 {
1962                     	switch	.text
1963  02ce               _UART2_SendBreak:
1967                     ; 541   UART2->CR2 |= UART2_CR2_SBK;
1969  02ce 72105245      	bset	21061,#0
1970                     ; 542 }
1973  02d2 81            	ret
2007                     ; 549 void UART2_SetAddress(uint8_t UART2_Address)
2007                     ; 550 {
2008                     	switch	.text
2009  02d3               _UART2_SetAddress:
2011  02d3 88            	push	a
2012       00000000      OFST:	set	0
2015                     ; 552   assert_param(IS_UART2_ADDRESS_OK(UART2_Address));
2017                     ; 555   UART2->CR4 &= ((uint8_t)~UART2_CR4_ADD);
2019  02d4 c65247        	ld	a,21063
2020  02d7 a4f0          	and	a,#240
2021  02d9 c75247        	ld	21063,a
2022                     ; 557   UART2->CR4 |= UART2_Address;
2024  02dc c65247        	ld	a,21063
2025  02df 1a01          	or	a,(OFST+1,sp)
2026  02e1 c75247        	ld	21063,a
2027                     ; 558 }
2030  02e4 84            	pop	a
2031  02e5 81            	ret
2065                     ; 566 void UART2_SetGuardTime(uint8_t UART2_GuardTime)
2065                     ; 567 {
2066                     	switch	.text
2067  02e6               _UART2_SetGuardTime:
2071                     ; 569   UART2->GTR = UART2_GuardTime;
2073  02e6 c7524a        	ld	21066,a
2074                     ; 570 }
2077  02e9 81            	ret
2111                     ; 594 void UART2_SetPrescaler(uint8_t UART2_Prescaler)
2111                     ; 595 {
2112                     	switch	.text
2113  02ea               _UART2_SetPrescaler:
2117                     ; 597   UART2->PSCR = UART2_Prescaler;
2119  02ea c7524b        	ld	21067,a
2120                     ; 598 }
2123  02ed 81            	ret
2280                     ; 606 FlagStatus UART2_GetFlagStatus(UART2_Flag_TypeDef UART2_FLAG)
2280                     ; 607 {
2281                     	switch	.text
2282  02ee               _UART2_GetFlagStatus:
2284  02ee 89            	pushw	x
2285  02ef 88            	push	a
2286       00000001      OFST:	set	1
2289                     ; 608   FlagStatus status = RESET;
2291                     ; 611   assert_param(IS_UART2_FLAG_OK(UART2_FLAG));
2293                     ; 614   if (UART2_FLAG == UART2_FLAG_LBDF)
2295  02f0 a30210        	cpw	x,#528
2296  02f3 2610          	jrne	L5511
2297                     ; 616     if ((UART2->CR4 & (uint8_t)UART2_FLAG) != (uint8_t)0x00)
2299  02f5 9f            	ld	a,xl
2300  02f6 c45247        	and	a,21063
2301  02f9 2706          	jreq	L7511
2302                     ; 619       status = SET;
2304  02fb a601          	ld	a,#1
2305  02fd 6b01          	ld	(OFST+0,sp),a
2308  02ff 2039          	jra	L3611
2309  0301               L7511:
2310                     ; 624       status = RESET;
2312  0301 0f01          	clr	(OFST+0,sp)
2314  0303 2035          	jra	L3611
2315  0305               L5511:
2316                     ; 627   else if (UART2_FLAG == UART2_FLAG_SBK)
2318  0305 1e02          	ldw	x,(OFST+1,sp)
2319  0307 a30101        	cpw	x,#257
2320  030a 2611          	jrne	L5611
2321                     ; 629     if ((UART2->CR2 & (uint8_t)UART2_FLAG) != (uint8_t)0x00)
2323  030c c65245        	ld	a,21061
2324  030f 1503          	bcp	a,(OFST+2,sp)
2325  0311 2706          	jreq	L7611
2326                     ; 632       status = SET;
2328  0313 a601          	ld	a,#1
2329  0315 6b01          	ld	(OFST+0,sp),a
2332  0317 2021          	jra	L3611
2333  0319               L7611:
2334                     ; 637       status = RESET;
2336  0319 0f01          	clr	(OFST+0,sp)
2338  031b 201d          	jra	L3611
2339  031d               L5611:
2340                     ; 640   else if ((UART2_FLAG == UART2_FLAG_LHDF) || (UART2_FLAG == UART2_FLAG_LSF))
2342  031d 1e02          	ldw	x,(OFST+1,sp)
2343  031f a30302        	cpw	x,#770
2344  0322 2707          	jreq	L7711
2346  0324 1e02          	ldw	x,(OFST+1,sp)
2347  0326 a30301        	cpw	x,#769
2348  0329 2614          	jrne	L5711
2349  032b               L7711:
2350                     ; 642     if ((UART2->CR6 & (uint8_t)UART2_FLAG) != (uint8_t)0x00)
2352  032b c65249        	ld	a,21065
2353  032e 1503          	bcp	a,(OFST+2,sp)
2354  0330 2706          	jreq	L1021
2355                     ; 645       status = SET;
2357  0332 a601          	ld	a,#1
2358  0334 6b01          	ld	(OFST+0,sp),a
2361  0336 2002          	jra	L3611
2362  0338               L1021:
2363                     ; 650       status = RESET;
2365  0338 0f01          	clr	(OFST+0,sp)
2367  033a               L3611:
2368                     ; 668   return  status;
2370  033a 7b01          	ld	a,(OFST+0,sp)
2373  033c 5b03          	addw	sp,#3
2374  033e 81            	ret
2375  033f               L5711:
2376                     ; 655     if ((UART2->SR & (uint8_t)UART2_FLAG) != (uint8_t)0x00)
2378  033f c65240        	ld	a,21056
2379  0342 1503          	bcp	a,(OFST+2,sp)
2380  0344 2706          	jreq	L7021
2381                     ; 658       status = SET;
2383  0346 a601          	ld	a,#1
2384  0348 6b01          	ld	(OFST+0,sp),a
2387  034a 20ee          	jra	L3611
2388  034c               L7021:
2389                     ; 663       status = RESET;
2391  034c 0f01          	clr	(OFST+0,sp)
2393  034e 20ea          	jra	L3611
2428                     ; 699 void UART2_ClearFlag(UART2_Flag_TypeDef UART2_FLAG)
2428                     ; 700 {
2429                     	switch	.text
2430  0350               _UART2_ClearFlag:
2432  0350 89            	pushw	x
2433       00000000      OFST:	set	0
2436                     ; 701   assert_param(IS_UART2_CLEAR_FLAG_OK(UART2_FLAG));
2438                     ; 704   if (UART2_FLAG == UART2_FLAG_RXNE)
2440  0351 a30020        	cpw	x,#32
2441  0354 2606          	jrne	L1321
2442                     ; 706     UART2->SR = (uint8_t)~(UART2_SR_RXNE);
2444  0356 35df5240      	mov	21056,#223
2446  035a 201e          	jra	L3321
2447  035c               L1321:
2448                     ; 709   else if (UART2_FLAG == UART2_FLAG_LBDF)
2450  035c 1e01          	ldw	x,(OFST+1,sp)
2451  035e a30210        	cpw	x,#528
2452  0361 2606          	jrne	L5321
2453                     ; 711     UART2->CR4 &= (uint8_t)(~UART2_CR4_LBDF);
2455  0363 72195247      	bres	21063,#4
2457  0367 2011          	jra	L3321
2458  0369               L5321:
2459                     ; 714   else if (UART2_FLAG == UART2_FLAG_LHDF)
2461  0369 1e01          	ldw	x,(OFST+1,sp)
2462  036b a30302        	cpw	x,#770
2463  036e 2606          	jrne	L1421
2464                     ; 716     UART2->CR6 &= (uint8_t)(~UART2_CR6_LHDF);
2466  0370 72135249      	bres	21065,#1
2468  0374 2004          	jra	L3321
2469  0376               L1421:
2470                     ; 721     UART2->CR6 &= (uint8_t)(~UART2_CR6_LSF);
2472  0376 72115249      	bres	21065,#0
2473  037a               L3321:
2474                     ; 723 }
2477  037a 85            	popw	x
2478  037b 81            	ret
2560                     ; 738 ITStatus UART2_GetITStatus(UART2_IT_TypeDef UART2_IT)
2560                     ; 739 {
2561                     	switch	.text
2562  037c               _UART2_GetITStatus:
2564  037c 89            	pushw	x
2565  037d 89            	pushw	x
2566       00000002      OFST:	set	2
2569                     ; 740   ITStatus pendingbitstatus = RESET;
2571                     ; 741   uint8_t itpos = 0;
2573                     ; 742   uint8_t itmask1 = 0;
2575                     ; 743   uint8_t itmask2 = 0;
2577                     ; 744   uint8_t enablestatus = 0;
2579                     ; 747   assert_param(IS_UART2_GET_IT_OK(UART2_IT));
2581                     ; 750   itpos = (uint8_t)((uint8_t)1 << (uint8_t)((uint8_t)UART2_IT & (uint8_t)0x0F));
2583  037e 9f            	ld	a,xl
2584  037f a40f          	and	a,#15
2585  0381 5f            	clrw	x
2586  0382 97            	ld	xl,a
2587  0383 a601          	ld	a,#1
2588  0385 5d            	tnzw	x
2589  0386 2704          	jreq	L27
2590  0388               L47:
2591  0388 48            	sll	a
2592  0389 5a            	decw	x
2593  038a 26fc          	jrne	L47
2594  038c               L27:
2595  038c 6b01          	ld	(OFST-1,sp),a
2597                     ; 752   itmask1 = (uint8_t)((uint8_t)UART2_IT >> (uint8_t)4);
2599  038e 7b04          	ld	a,(OFST+2,sp)
2600  0390 4e            	swap	a
2601  0391 a40f          	and	a,#15
2602  0393 6b02          	ld	(OFST+0,sp),a
2604                     ; 754   itmask2 = (uint8_t)((uint8_t)1 << itmask1);
2606  0395 7b02          	ld	a,(OFST+0,sp)
2607  0397 5f            	clrw	x
2608  0398 97            	ld	xl,a
2609  0399 a601          	ld	a,#1
2610  039b 5d            	tnzw	x
2611  039c 2704          	jreq	L67
2612  039e               L001:
2613  039e 48            	sll	a
2614  039f 5a            	decw	x
2615  03a0 26fc          	jrne	L001
2616  03a2               L67:
2617  03a2 6b02          	ld	(OFST+0,sp),a
2619                     ; 757   if (UART2_IT == UART2_IT_PE)
2621  03a4 1e03          	ldw	x,(OFST+1,sp)
2622  03a6 a30100        	cpw	x,#256
2623  03a9 261c          	jrne	L7031
2624                     ; 760     enablestatus = (uint8_t)((uint8_t)UART2->CR1 & itmask2);
2626  03ab c65244        	ld	a,21060
2627  03ae 1402          	and	a,(OFST+0,sp)
2628  03b0 6b02          	ld	(OFST+0,sp),a
2630                     ; 763     if (((UART2->SR & itpos) != (uint8_t)0x00) && enablestatus)
2632  03b2 c65240        	ld	a,21056
2633  03b5 1501          	bcp	a,(OFST-1,sp)
2634  03b7 270a          	jreq	L1131
2636  03b9 0d02          	tnz	(OFST+0,sp)
2637  03bb 2706          	jreq	L1131
2638                     ; 766       pendingbitstatus = SET;
2640  03bd a601          	ld	a,#1
2641  03bf 6b02          	ld	(OFST+0,sp),a
2644  03c1 2064          	jra	L5131
2645  03c3               L1131:
2646                     ; 771       pendingbitstatus = RESET;
2648  03c3 0f02          	clr	(OFST+0,sp)
2650  03c5 2060          	jra	L5131
2651  03c7               L7031:
2652                     ; 774   else if (UART2_IT == UART2_IT_LBDF)
2654  03c7 1e03          	ldw	x,(OFST+1,sp)
2655  03c9 a30346        	cpw	x,#838
2656  03cc 261c          	jrne	L7131
2657                     ; 777     enablestatus = (uint8_t)((uint8_t)UART2->CR4 & itmask2);
2659  03ce c65247        	ld	a,21063
2660  03d1 1402          	and	a,(OFST+0,sp)
2661  03d3 6b02          	ld	(OFST+0,sp),a
2663                     ; 779     if (((UART2->CR4 & itpos) != (uint8_t)0x00) && enablestatus)
2665  03d5 c65247        	ld	a,21063
2666  03d8 1501          	bcp	a,(OFST-1,sp)
2667  03da 270a          	jreq	L1231
2669  03dc 0d02          	tnz	(OFST+0,sp)
2670  03de 2706          	jreq	L1231
2671                     ; 782       pendingbitstatus = SET;
2673  03e0 a601          	ld	a,#1
2674  03e2 6b02          	ld	(OFST+0,sp),a
2677  03e4 2041          	jra	L5131
2678  03e6               L1231:
2679                     ; 787       pendingbitstatus = RESET;
2681  03e6 0f02          	clr	(OFST+0,sp)
2683  03e8 203d          	jra	L5131
2684  03ea               L7131:
2685                     ; 790   else if (UART2_IT == UART2_IT_LHDF)
2687  03ea 1e03          	ldw	x,(OFST+1,sp)
2688  03ec a30412        	cpw	x,#1042
2689  03ef 261c          	jrne	L7231
2690                     ; 793     enablestatus = (uint8_t)((uint8_t)UART2->CR6 & itmask2);
2692  03f1 c65249        	ld	a,21065
2693  03f4 1402          	and	a,(OFST+0,sp)
2694  03f6 6b02          	ld	(OFST+0,sp),a
2696                     ; 795     if (((UART2->CR6 & itpos) != (uint8_t)0x00) && enablestatus)
2698  03f8 c65249        	ld	a,21065
2699  03fb 1501          	bcp	a,(OFST-1,sp)
2700  03fd 270a          	jreq	L1331
2702  03ff 0d02          	tnz	(OFST+0,sp)
2703  0401 2706          	jreq	L1331
2704                     ; 798       pendingbitstatus = SET;
2706  0403 a601          	ld	a,#1
2707  0405 6b02          	ld	(OFST+0,sp),a
2710  0407 201e          	jra	L5131
2711  0409               L1331:
2712                     ; 803       pendingbitstatus = RESET;
2714  0409 0f02          	clr	(OFST+0,sp)
2716  040b 201a          	jra	L5131
2717  040d               L7231:
2718                     ; 809     enablestatus = (uint8_t)((uint8_t)UART2->CR2 & itmask2);
2720  040d c65245        	ld	a,21061
2721  0410 1402          	and	a,(OFST+0,sp)
2722  0412 6b02          	ld	(OFST+0,sp),a
2724                     ; 811     if (((UART2->SR & itpos) != (uint8_t)0x00) && enablestatus)
2726  0414 c65240        	ld	a,21056
2727  0417 1501          	bcp	a,(OFST-1,sp)
2728  0419 270a          	jreq	L7331
2730  041b 0d02          	tnz	(OFST+0,sp)
2731  041d 2706          	jreq	L7331
2732                     ; 814       pendingbitstatus = SET;
2734  041f a601          	ld	a,#1
2735  0421 6b02          	ld	(OFST+0,sp),a
2738  0423 2002          	jra	L5131
2739  0425               L7331:
2740                     ; 819       pendingbitstatus = RESET;
2742  0425 0f02          	clr	(OFST+0,sp)
2744  0427               L5131:
2745                     ; 823   return  pendingbitstatus;
2747  0427 7b02          	ld	a,(OFST+0,sp)
2750  0429 5b04          	addw	sp,#4
2751  042b 81            	ret
2787                     ; 852 void UART2_ClearITPendingBit(UART2_IT_TypeDef UART2_IT)
2787                     ; 853 {
2788                     	switch	.text
2789  042c               _UART2_ClearITPendingBit:
2791  042c 89            	pushw	x
2792       00000000      OFST:	set	0
2795                     ; 854   assert_param(IS_UART2_CLEAR_IT_OK(UART2_IT));
2797                     ; 857   if (UART2_IT == UART2_IT_RXNE)
2799  042d a30255        	cpw	x,#597
2800  0430 2606          	jrne	L1631
2801                     ; 859     UART2->SR = (uint8_t)~(UART2_SR_RXNE);
2803  0432 35df5240      	mov	21056,#223
2805  0436 2011          	jra	L3631
2806  0438               L1631:
2807                     ; 862   else if (UART2_IT == UART2_IT_LBDF)
2809  0438 1e01          	ldw	x,(OFST+1,sp)
2810  043a a30346        	cpw	x,#838
2811  043d 2606          	jrne	L5631
2812                     ; 864     UART2->CR4 &= (uint8_t)~(UART2_CR4_LBDF);
2814  043f 72195247      	bres	21063,#4
2816  0443 2004          	jra	L3631
2817  0445               L5631:
2818                     ; 869     UART2->CR6 &= (uint8_t)(~UART2_CR6_LHDF);
2820  0445 72135249      	bres	21065,#1
2821  0449               L3631:
2822                     ; 871 }
2825  0449 85            	popw	x
2826  044a 81            	ret
2839                     	xdef	_UART2_ClearITPendingBit
2840                     	xdef	_UART2_GetITStatus
2841                     	xdef	_UART2_ClearFlag
2842                     	xdef	_UART2_GetFlagStatus
2843                     	xdef	_UART2_SetPrescaler
2844                     	xdef	_UART2_SetGuardTime
2845                     	xdef	_UART2_SetAddress
2846                     	xdef	_UART2_SendBreak
2847                     	xdef	_UART2_SendData9
2848                     	xdef	_UART2_SendData8
2849                     	xdef	_UART2_ReceiveData9
2850                     	xdef	_UART2_ReceiveData8
2851                     	xdef	_UART2_ReceiverWakeUpCmd
2852                     	xdef	_UART2_WakeUpConfig
2853                     	xdef	_UART2_SmartCardNACKCmd
2854                     	xdef	_UART2_SmartCardCmd
2855                     	xdef	_UART2_LINCmd
2856                     	xdef	_UART2_LINConfig
2857                     	xdef	_UART2_LINBreakDetectionConfig
2858                     	xdef	_UART2_IrDACmd
2859                     	xdef	_UART2_IrDAConfig
2860                     	xdef	_UART2_ITConfig
2861                     	xdef	_UART2_Cmd
2862                     	xdef	_UART2_Init
2863                     	xdef	_UART2_DeInit
2864                     	xref	_CLK_GetClockFreq
2865                     	xref.b	c_lreg
2866                     	xref.b	c_x
2885                     	xref	c_lsub
2886                     	xref	c_smul
2887                     	xref	c_ludv
2888                     	xref	c_rtol
2889                     	xref	c_llsh
2890                     	xref	c_ltor
2891                     	end

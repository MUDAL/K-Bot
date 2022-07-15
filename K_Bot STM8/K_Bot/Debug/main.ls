   1                     ; C Compiler for STM8 (COSMIC Software)
   2                     ; Parser V4.12.6 - 16 Dec 2021
   3                     ; Generator (Limited) V4.5.4 - 16 Dec 2021
  44                     ; 29 static void Bluetooth_Init(void)
  44                     ; 30 {
  46                     	switch	.text
  47  0000               L3_Bluetooth_Init:
  51                     ; 32 	UART2_Init(9600,UART2_WORDLENGTH_8D,
  51                     ; 33 						 UART2_STOPBITS_1,UART2_PARITY_NO,
  51                     ; 34 						 UART2_SYNCMODE_CLOCK_DISABLE,
  51                     ; 35 						 UART2_MODE_RX_ENABLE);
  53  0000 4b08          	push	#8
  54  0002 4b80          	push	#128
  55  0004 4b00          	push	#0
  56  0006 4b00          	push	#0
  57  0008 4b00          	push	#0
  58  000a ae2580        	ldw	x,#9600
  59  000d 89            	pushw	x
  60  000e ae0000        	ldw	x,#0
  61  0011 89            	pushw	x
  62  0012 cd0000        	call	_UART2_Init
  64  0015 5b09          	addw	sp,#9
  65                     ; 36 	UART2_Cmd(ENABLE);
  67  0017 a601          	ld	a,#1
  68  0019 cd0000        	call	_UART2_Cmd
  70                     ; 37 }
  73  001c 81            	ret
 109                     ; 39 static char Bluetooth_Receive(void)
 109                     ; 40 {
 110                     	switch	.text
 111  001d               L32_Bluetooth_Receive:
 113  001d 88            	push	a
 114       00000001      OFST:	set	1
 117                     ; 41 	char rxData = '\0';
 119  001e 0f01          	clr	(OFST+0,sp)
 121                     ; 42 	if(UART2_GetFlagStatus(UART2_FLAG_RXNE) == SET)
 123  0020 ae0020        	ldw	x,#32
 124  0023 cd0000        	call	_UART2_GetFlagStatus
 126  0026 a101          	cp	a,#1
 127  0028 2605          	jrne	L34
 128                     ; 44 		rxData = (char)UART2_ReceiveData8();
 130  002a cd0000        	call	_UART2_ReceiveData8
 132  002d 6b01          	ld	(OFST+0,sp),a
 134  002f               L34:
 135                     ; 46 	return rxData;
 137  002f 7b01          	ld	a,(OFST+0,sp)
 140  0031 5b01          	addw	sp,#1
 141  0033 81            	ret
 170                     ; 50 static void SpeedSensors_Init(void)
 170                     ; 51 {
 171                     	switch	.text
 172  0034               L54_SpeedSensors_Init:
 176                     ; 53 	TIM3_ICInit(TIM3_CHANNEL_1,TIM3_ICPOLARITY_RISING,
 176                     ; 54 							TIM3_ICSELECTION_DIRECTTI,TIM3_ICPSC_DIV8,
 176                     ; 55 							0x0F);
 178  0034 4b0f          	push	#15
 179  0036 4b0c          	push	#12
 180  0038 4b01          	push	#1
 181  003a 5f            	clrw	x
 182  003b cd0000        	call	_TIM3_ICInit
 184  003e 5b03          	addw	sp,#3
 185                     ; 56 	TIM3_Cmd(ENABLE); //Enable TIM3
 187  0040 a601          	ld	a,#1
 188  0042 cd0000        	call	_TIM3_Cmd
 190                     ; 57 	TIM3_ClearFlag(TIM3_FLAG_CC1); //Clear CC1 flag
 192  0045 ae0002        	ldw	x,#2
 193  0048 cd0000        	call	_TIM3_ClearFlag
 195                     ; 59 	TIM2_ICInit(TIM2_CHANNEL_1,TIM2_ICPOLARITY_RISING,
 195                     ; 60 							TIM2_ICSELECTION_DIRECTTI,TIM2_ICPSC_DIV8,
 195                     ; 61 							0x0F);
 197  004b 4b0f          	push	#15
 198  004d 4b0c          	push	#12
 199  004f 4b01          	push	#1
 200  0051 5f            	clrw	x
 201  0052 cd0000        	call	_TIM2_ICInit
 203  0055 5b03          	addw	sp,#3
 204                     ; 62 	TIM2_Cmd(ENABLE); //Enable TIM2
 206  0057 a601          	ld	a,#1
 207  0059 cd0000        	call	_TIM2_Cmd
 209                     ; 63 	TIM2_ClearFlag(TIM2_FLAG_CC1); //Clear CC1 flag
 211  005c ae0002        	ldw	x,#2
 212  005f cd0000        	call	_TIM2_ClearFlag
 214                     ; 64 }
 217  0062 81            	ret
 263                     ; 66 static uint16_t LeftSensor_GetPeriod(void)
 263                     ; 67 {
 264                     	switch	.text
 265  0063               L75_LeftSensor_GetPeriod:
 267  0063 5204          	subw	sp,#4
 268       00000004      OFST:	set	4
 271                     ; 68 	uint16_t firstCapture = 0;
 273                     ; 69 	uint16_t secondCapture = 0;
 276  0065               L501:
 277                     ; 71 	while((TIM3->SR1 & TIM3_FLAG_CC1) != TIM3_FLAG_CC1){}
 279  0065 c65322        	ld	a,21282
 280  0068 a402          	and	a,#2
 281  006a a102          	cp	a,#2
 282  006c 26f7          	jrne	L501
 283                     ; 72 	firstCapture = TIM3_GetCapture1();
 285  006e cd0000        	call	_TIM3_GetCapture1
 287  0071 1f01          	ldw	(OFST-3,sp),x
 289                     ; 73 	TIM3_ClearFlag(TIM3_FLAG_CC1);
 291  0073 ae0002        	ldw	x,#2
 292  0076 cd0000        	call	_TIM3_ClearFlag
 295  0079               L311:
 296                     ; 75 	while((TIM3->SR1 & TIM3_FLAG_CC1) != TIM3_FLAG_CC1){}
 298  0079 c65322        	ld	a,21282
 299  007c a402          	and	a,#2
 300  007e a102          	cp	a,#2
 301  0080 26f7          	jrne	L311
 302                     ; 76 	secondCapture = TIM3_GetCapture1();
 304  0082 cd0000        	call	_TIM3_GetCapture1
 306  0085 1f03          	ldw	(OFST-1,sp),x
 308                     ; 77 	TIM3_ClearFlag(TIM3_FLAG_CC1);
 310  0087 ae0002        	ldw	x,#2
 311  008a cd0000        	call	_TIM3_ClearFlag
 313                     ; 79 	return (secondCapture - firstCapture);
 315  008d 1e03          	ldw	x,(OFST-1,sp)
 316  008f 72f001        	subw	x,(OFST-3,sp)
 319  0092 5b04          	addw	sp,#4
 320  0094 81            	ret
 366                     ; 82 static uint16_t RightSensor_GetPeriod(void)
 366                     ; 83 {
 367                     	switch	.text
 368  0095               L711_RightSensor_GetPeriod:
 370  0095 5204          	subw	sp,#4
 371       00000004      OFST:	set	4
 374                     ; 84 	uint16_t firstCapture = 0;
 376                     ; 85 	uint16_t secondCapture = 0;
 379  0097               L541:
 380                     ; 87 	while((TIM2->SR1 & TIM2_FLAG_CC1) != TIM2_FLAG_CC1){}
 382  0097 c65302        	ld	a,21250
 383  009a a402          	and	a,#2
 384  009c a102          	cp	a,#2
 385  009e 26f7          	jrne	L541
 386                     ; 88 	firstCapture = TIM2_GetCapture1();
 388  00a0 cd0000        	call	_TIM2_GetCapture1
 390  00a3 1f01          	ldw	(OFST-3,sp),x
 392                     ; 89 	TIM2_ClearFlag(TIM2_FLAG_CC1);
 394  00a5 ae0002        	ldw	x,#2
 395  00a8 cd0000        	call	_TIM2_ClearFlag
 398  00ab               L351:
 399                     ; 91 	while((TIM2->SR1 & TIM2_FLAG_CC1) != TIM2_FLAG_CC1){}
 401  00ab c65302        	ld	a,21250
 402  00ae a402          	and	a,#2
 403  00b0 a102          	cp	a,#2
 404  00b2 26f7          	jrne	L351
 405                     ; 92 	secondCapture = TIM2_GetCapture1();
 407  00b4 cd0000        	call	_TIM2_GetCapture1
 409  00b7 1f03          	ldw	(OFST-1,sp),x
 411                     ; 93 	TIM2_ClearFlag(TIM2_FLAG_CC1);
 413  00b9 ae0002        	ldw	x,#2
 414  00bc cd0000        	call	_TIM2_ClearFlag
 416                     ; 95 	return (secondCapture - firstCapture);
 418  00bf 1e03          	ldw	x,(OFST-1,sp)
 419  00c1 72f001        	subw	x,(OFST-3,sp)
 422  00c4 5b04          	addw	sp,#4
 423  00c6 81            	ret
 452                     ; 99 static void Actuators_Init(void)
 452                     ; 100 {
 453                     	switch	.text
 454  00c7               L751_Actuators_Init:
 458                     ; 102 	GPIO_Init(GPIOC,GPIO_PIN_3,GPIO_MODE_OUT_PP_LOW_FAST);
 460  00c7 4be0          	push	#224
 461  00c9 4b08          	push	#8
 462  00cb ae500a        	ldw	x,#20490
 463  00ce cd0000        	call	_GPIO_Init
 465  00d1 85            	popw	x
 466                     ; 103 	GPIO_Init(GPIOC,GPIO_PIN_4,GPIO_MODE_OUT_PP_LOW_FAST);
 468  00d2 4be0          	push	#224
 469  00d4 4b10          	push	#16
 470  00d6 ae500a        	ldw	x,#20490
 471  00d9 cd0000        	call	_GPIO_Init
 473  00dc 85            	popw	x
 474                     ; 105 	GPIO_Init(GPIOC,GPIO_PIN_5,GPIO_MODE_OUT_PP_LOW_FAST);
 476  00dd 4be0          	push	#224
 477  00df 4b20          	push	#32
 478  00e1 ae500a        	ldw	x,#20490
 479  00e4 cd0000        	call	_GPIO_Init
 481  00e7 85            	popw	x
 482                     ; 106 	GPIO_Init(GPIOC,GPIO_PIN_6,GPIO_MODE_OUT_PP_LOW_FAST);
 484  00e8 4be0          	push	#224
 485  00ea 4b40          	push	#64
 486  00ec ae500a        	ldw	x,#20490
 487  00ef cd0000        	call	_GPIO_Init
 489  00f2 85            	popw	x
 490                     ; 108 	GPIO_Init(GPIOD,GPIO_PIN_0,GPIO_MODE_OUT_PP_LOW_FAST);
 492  00f3 4be0          	push	#224
 493  00f5 4b01          	push	#1
 494  00f7 ae500f        	ldw	x,#20495
 495  00fa cd0000        	call	_GPIO_Init
 497  00fd 85            	popw	x
 498                     ; 109 	GPIO_Init(GPIOD,GPIO_PIN_3,GPIO_MODE_OUT_PP_LOW_FAST);
 500  00fe 4be0          	push	#224
 501  0100 4b08          	push	#8
 502  0102 ae500f        	ldw	x,#20495
 503  0105 cd0000        	call	_GPIO_Init
 505  0108 85            	popw	x
 506                     ; 112 	TIM1_TimeBaseInit(7,TIM1_COUNTERMODE_UP,(PWM_PERIOD-1),0);
 508  0109 4b00          	push	#0
 509  010b ae018f        	ldw	x,#399
 510  010e 89            	pushw	x
 511  010f 4b00          	push	#0
 512  0111 ae0007        	ldw	x,#7
 513  0114 cd0000        	call	_TIM1_TimeBaseInit
 515  0117 5b04          	addw	sp,#4
 516                     ; 115 	TIM1_OC1Init(TIM1_OCMODE_PWM2,TIM1_OUTPUTSTATE_ENABLE,
 516                     ; 116 							 TIM1_OUTPUTNSTATE_ENABLE,1,
 516                     ; 117 							 TIM1_OCPOLARITY_LOW,TIM1_OCNPOLARITY_HIGH,
 516                     ; 118 							 TIM1_OCIDLESTATE_SET,
 516                     ; 119 							 TIM1_OCNIDLESTATE_RESET);
 518  0119 4b00          	push	#0
 519  011b 4b55          	push	#85
 520  011d 4b00          	push	#0
 521  011f 4b22          	push	#34
 522  0121 ae0001        	ldw	x,#1
 523  0124 89            	pushw	x
 524  0125 4b44          	push	#68
 525  0127 ae7011        	ldw	x,#28689
 526  012a cd0000        	call	_TIM1_OC1Init
 528  012d 5b07          	addw	sp,#7
 529                     ; 122 	TIM1_OC2Init(TIM1_OCMODE_PWM2,TIM1_OUTPUTSTATE_ENABLE,
 529                     ; 123 							 TIM1_OUTPUTNSTATE_ENABLE,1,
 529                     ; 124 							 TIM1_OCPOLARITY_LOW,TIM1_OCNPOLARITY_HIGH,
 529                     ; 125 							 TIM1_OCIDLESTATE_SET,
 529                     ; 126 							 TIM1_OCNIDLESTATE_RESET);	
 531  012f 4b00          	push	#0
 532  0131 4b55          	push	#85
 533  0133 4b00          	push	#0
 534  0135 4b22          	push	#34
 535  0137 ae0001        	ldw	x,#1
 536  013a 89            	pushw	x
 537  013b 4b44          	push	#68
 538  013d ae7011        	ldw	x,#28689
 539  0140 cd0000        	call	_TIM1_OC2Init
 541  0143 5b07          	addw	sp,#7
 542                     ; 128 	TIM1_Cmd(ENABLE);
 544  0145 a601          	ld	a,#1
 545  0147 cd0000        	call	_TIM1_Cmd
 547                     ; 130 	TIM1_CtrlPWMOutputs(ENABLE);
 549  014a a601          	ld	a,#1
 550  014c cd0000        	call	_TIM1_CtrlPWMOutputs
 552                     ; 131 }
 555  014f 81            	ret
 579                     ; 133 static void Pump_Toggle(void)
 579                     ; 134 {
 580                     	switch	.text
 581  0150               L171_Pump_Toggle:
 585                     ; 135 	GPIO_WriteReverse(GPIOC,GPIO_PIN_3);
 587  0150 4b08          	push	#8
 588  0152 ae500a        	ldw	x,#20490
 589  0155 cd0000        	call	_GPIO_WriteReverse
 591  0158 84            	pop	a
 592                     ; 136 }
 595  0159 81            	ret
 619                     ; 138 static void Brush_Toggle(void)
 619                     ; 139 {
 620                     	switch	.text
 621  015a               L302_Brush_Toggle:
 625                     ; 140 	GPIO_WriteReverse(GPIOC,GPIO_PIN_4);
 627  015a 4b10          	push	#16
 628  015c ae500a        	ldw	x,#20490
 629  015f cd0000        	call	_GPIO_WriteReverse
 631  0162 84            	pop	a
 632                     ; 141 }
 635  0163 81            	ret
 659                     ; 143 static void Motors_Stop(void)
 659                     ; 144 {
 660                     	switch	.text
 661  0164               L512_Motors_Stop:
 665                     ; 146 	GPIO_WriteLow(GPIOC,GPIO_PIN_5);
 667  0164 4b20          	push	#32
 668  0166 ae500a        	ldw	x,#20490
 669  0169 cd0000        	call	_GPIO_WriteLow
 671  016c 84            	pop	a
 672                     ; 147 	GPIO_WriteLow(GPIOC,GPIO_PIN_6);
 674  016d 4b40          	push	#64
 675  016f ae500a        	ldw	x,#20490
 676  0172 cd0000        	call	_GPIO_WriteLow
 678  0175 84            	pop	a
 679                     ; 149 	GPIO_WriteLow(GPIOD,GPIO_PIN_0);
 681  0176 4b01          	push	#1
 682  0178 ae500f        	ldw	x,#20495
 683  017b cd0000        	call	_GPIO_WriteLow
 685  017e 84            	pop	a
 686                     ; 150 	GPIO_WriteLow(GPIOD,GPIO_PIN_3);
 688  017f 4b08          	push	#8
 689  0181 ae500f        	ldw	x,#20495
 690  0184 cd0000        	call	_GPIO_WriteLow
 692  0187 84            	pop	a
 693                     ; 151 }
 696  0188 81            	ret
 721                     ; 153 static void Motors_Advance(void)
 721                     ; 154 {
 722                     	switch	.text
 723  0189               L722_Motors_Advance:
 727                     ; 156 	GPIO_WriteHigh(GPIOC,GPIO_PIN_5);
 729  0189 4b20          	push	#32
 730  018b ae500a        	ldw	x,#20490
 731  018e cd0000        	call	_GPIO_WriteHigh
 733  0191 84            	pop	a
 734                     ; 157 	GPIO_WriteLow(GPIOC,GPIO_PIN_6);
 736  0192 4b40          	push	#64
 737  0194 ae500a        	ldw	x,#20490
 738  0197 cd0000        	call	_GPIO_WriteLow
 740  019a 84            	pop	a
 741                     ; 159 	GPIO_WriteHigh(GPIOD,GPIO_PIN_0);
 743  019b 4b01          	push	#1
 744  019d ae500f        	ldw	x,#20495
 745  01a0 cd0000        	call	_GPIO_WriteHigh
 747  01a3 84            	pop	a
 748                     ; 160 	GPIO_WriteLow(GPIOD,GPIO_PIN_3);	
 750  01a4 4b08          	push	#8
 751  01a6 ae500f        	ldw	x,#20495
 752  01a9 cd0000        	call	_GPIO_WriteLow
 754  01ac 84            	pop	a
 755                     ; 161 }
 758  01ad 81            	ret
 783                     ; 163 static void Motors_Reverse(void)
 783                     ; 164 {
 784                     	switch	.text
 785  01ae               L142_Motors_Reverse:
 789                     ; 166 	GPIO_WriteLow(GPIOC,GPIO_PIN_5);
 791  01ae 4b20          	push	#32
 792  01b0 ae500a        	ldw	x,#20490
 793  01b3 cd0000        	call	_GPIO_WriteLow
 795  01b6 84            	pop	a
 796                     ; 167 	GPIO_WriteHigh(GPIOC,GPIO_PIN_6);
 798  01b7 4b40          	push	#64
 799  01b9 ae500a        	ldw	x,#20490
 800  01bc cd0000        	call	_GPIO_WriteHigh
 802  01bf 84            	pop	a
 803                     ; 169 	GPIO_WriteLow(GPIOD,GPIO_PIN_0);
 805  01c0 4b01          	push	#1
 806  01c2 ae500f        	ldw	x,#20495
 807  01c5 cd0000        	call	_GPIO_WriteLow
 809  01c8 84            	pop	a
 810                     ; 170 	GPIO_WriteHigh(GPIOD,GPIO_PIN_3);		
 812  01c9 4b08          	push	#8
 813  01cb ae500f        	ldw	x,#20495
 814  01ce cd0000        	call	_GPIO_WriteHigh
 816  01d1 84            	pop	a
 817                     ; 171 }
 820  01d2 81            	ret
 855                     ; 173 static void LeftMotor_SetSpeed(uint16_t speed)
 855                     ; 174 {
 856                     	switch	.text
 857  01d3               L352_LeftMotor_SetSpeed:
 859  01d3 89            	pushw	x
 860       00000000      OFST:	set	0
 863                     ; 175 	if(speed >= PWM_PERIOD)
 865  01d4 a30190        	cpw	x,#400
 866  01d7 2409          	jruge	L43
 867                     ; 177 		return;
 869                     ; 179 	TIM1_SetCompare1(PWM_PERIOD-1-speed);//Adjust duty cycle
 871  01d9 ae018f        	ldw	x,#399
 872  01dc 72f001        	subw	x,(OFST+1,sp)
 873  01df cd0000        	call	_TIM1_SetCompare1
 875                     ; 180 }
 876  01e2               L43:
 879  01e2 85            	popw	x
 880  01e3 81            	ret
 916                     ; 182 static void RightMotor_SetSpeed(uint16_t speed)
 916                     ; 183 {
 917                     	switch	.text
 918  01e4               L572_RightMotor_SetSpeed:
 920  01e4 89            	pushw	x
 921       00000000      OFST:	set	0
 924                     ; 184 	if(speed >= PWM_PERIOD)
 926  01e5 a30190        	cpw	x,#400
 927  01e8 2409          	jruge	L04
 928                     ; 186 		return;
 930                     ; 188 	TIM1_SetCompare2(PWM_PERIOD-1-speed);//Adjust duty cycle	
 932  01ea ae018f        	ldw	x,#399
 933  01ed 72f001        	subw	x,(OFST+1,sp)
 934  01f0 cd0000        	call	_TIM1_SetCompare2
 936                     ; 189 }
 937  01f3               L04:
 940  01f3 85            	popw	x
 941  01f4 81            	ret
 966                     ; 191 static void KBot_TurnRight(void)
 966                     ; 192 {
 967                     	switch	.text
 968  01f5               L713_KBot_TurnRight:
 972                     ; 194 	GPIO_WriteHigh(GPIOC,GPIO_PIN_5);
 974  01f5 4b20          	push	#32
 975  01f7 ae500a        	ldw	x,#20490
 976  01fa cd0000        	call	_GPIO_WriteHigh
 978  01fd 84            	pop	a
 979                     ; 195 	GPIO_WriteLow(GPIOC,GPIO_PIN_6);	
 981  01fe 4b40          	push	#64
 982  0200 ae500a        	ldw	x,#20490
 983  0203 cd0000        	call	_GPIO_WriteLow
 985  0206 84            	pop	a
 986                     ; 197 	GPIO_WriteLow(GPIOD,GPIO_PIN_0);
 988  0207 4b01          	push	#1
 989  0209 ae500f        	ldw	x,#20495
 990  020c cd0000        	call	_GPIO_WriteLow
 992  020f 84            	pop	a
 993                     ; 198 	GPIO_WriteHigh(GPIOD,GPIO_PIN_3);		
 995  0210 4b08          	push	#8
 996  0212 ae500f        	ldw	x,#20495
 997  0215 cd0000        	call	_GPIO_WriteHigh
 999  0218 84            	pop	a
1000                     ; 199 }
1003  0219 81            	ret
1028                     ; 201 static void KBot_TurnLeft(void)
1028                     ; 202 {
1029                     	switch	.text
1030  021a               L133_KBot_TurnLeft:
1034                     ; 204 	GPIO_WriteLow(GPIOC,GPIO_PIN_5);
1036  021a 4b20          	push	#32
1037  021c ae500a        	ldw	x,#20490
1038  021f cd0000        	call	_GPIO_WriteLow
1040  0222 84            	pop	a
1041                     ; 205 	GPIO_WriteHigh(GPIOC,GPIO_PIN_6);	
1043  0223 4b40          	push	#64
1044  0225 ae500a        	ldw	x,#20490
1045  0228 cd0000        	call	_GPIO_WriteHigh
1047  022b 84            	pop	a
1048                     ; 207 	GPIO_WriteHigh(GPIOD,GPIO_PIN_0);
1050  022c 4b01          	push	#1
1051  022e ae500f        	ldw	x,#20495
1052  0231 cd0000        	call	_GPIO_WriteHigh
1054  0234 84            	pop	a
1055                     ; 208 	GPIO_WriteLow(GPIOD,GPIO_PIN_3);		
1057  0235 4b08          	push	#8
1058  0237 ae500f        	ldw	x,#20495
1059  023a cd0000        	call	_GPIO_WriteLow
1061  023d 84            	pop	a
1062                     ; 209 }
1065  023e 81            	ret
1141                     ; 212 int main(void)
1141                     ; 213 {
1142                     	switch	.text
1143  023f               _main:
1145  023f 89            	pushw	x
1146       00000002      OFST:	set	2
1149                     ; 215 	bool speedBalanceEnable = 0;
1151  0240 0f02          	clr	(OFST+0,sp)
1153                     ; 216 	char appData = '\0';
1155                     ; 218 	CLK_HSIPrescalerConfig(CLK_PRESCALER_HSIDIV1); //16MHz
1157  0242 4f            	clr	a
1158  0243 cd0000        	call	_CLK_HSIPrescalerConfig
1160                     ; 219 	Bluetooth_Init();
1162  0246 cd0000        	call	L3_Bluetooth_Init
1164                     ; 220 	SpeedSensors_Init();
1166  0249 cd0034        	call	L54_SpeedSensors_Init
1168                     ; 221 	Actuators_Init();
1170  024c cd00c7        	call	L751_Actuators_Init
1172  024f               L314:
1173                     ; 226 		appData = Bluetooth_Receive();
1175  024f cd001d        	call	L32_Bluetooth_Receive
1177  0252 6b01          	ld	(OFST-1,sp),a
1179                     ; 228 		switch(appData)
1181  0254 7b01          	ld	a,(OFST-1,sp)
1183                     ; 257 				break;
1184  0256 a030          	sub	a,#48
1185  0258 2714          	jreq	L343
1186  025a 4a            	dec	a
1187  025b 2718          	jreq	L543
1188  025d 4a            	dec	a
1189  025e 271c          	jreq	L743
1190  0260 4a            	dec	a
1191  0261 2722          	jreq	L153
1192  0263 4a            	dec	a
1193  0264 2725          	jreq	L353
1194  0266 4a            	dec	a
1195  0267 2729          	jreq	L553
1196  0269 4a            	dec	a
1197  026a 272d          	jreq	L753
1198  026c 2032          	jra	L124
1199  026e               L343:
1200                     ; 230 			case '0': //Pump control
1200                     ; 231 				Pump_Toggle();
1202  026e cd0150        	call	L171_Pump_Toggle
1204                     ; 232 				speedBalanceEnable = 0;
1206  0271 0f02          	clr	(OFST+0,sp)
1208                     ; 233 				break;
1210  0273 202b          	jra	L124
1211  0275               L543:
1212                     ; 234 			case '1': //Brush control
1212                     ; 235 				Brush_Toggle();
1214  0275 cd015a        	call	L302_Brush_Toggle
1216                     ; 236 				speedBalanceEnable = 0;
1218  0278 0f02          	clr	(OFST+0,sp)
1220                     ; 237 				break;
1222  027a 2024          	jra	L124
1223  027c               L743:
1224                     ; 238 			case '2': //Move back
1224                     ; 239 				Motors_Reverse();
1226  027c cd01ae        	call	L142_Motors_Reverse
1228                     ; 240 				speedBalanceEnable = 1;
1230  027f a601          	ld	a,#1
1231  0281 6b02          	ld	(OFST+0,sp),a
1233                     ; 241 				break;
1235  0283 201b          	jra	L124
1236  0285               L153:
1237                     ; 242 			case '3': //Turn left
1237                     ; 243 				KBot_TurnLeft();
1239  0285 ad93          	call	L133_KBot_TurnLeft
1241                     ; 244 				speedBalanceEnable = 0;
1243  0287 0f02          	clr	(OFST+0,sp)
1245                     ; 245 				break;
1247  0289 2015          	jra	L124
1248  028b               L353:
1249                     ; 246 			case '4': //Stop
1249                     ; 247 				Motors_Stop();
1251  028b cd0164        	call	L512_Motors_Stop
1253                     ; 248 				speedBalanceEnable = 0;
1255  028e 0f02          	clr	(OFST+0,sp)
1257                     ; 249 				break;
1259  0290 200e          	jra	L124
1260  0292               L553:
1261                     ; 250 			case '5': //Turn right
1261                     ; 251 				KBot_TurnRight();
1263  0292 cd01f5        	call	L713_KBot_TurnRight
1265                     ; 252 				speedBalanceEnable = 0;
1267  0295 0f02          	clr	(OFST+0,sp)
1269                     ; 253 				break;
1271  0297 2007          	jra	L124
1272  0299               L753:
1273                     ; 254 			case '6': //Move forward
1273                     ; 255 				Motors_Advance();
1275  0299 cd0189        	call	L722_Motors_Advance
1277                     ; 256 				speedBalanceEnable = 1;
1279  029c a601          	ld	a,#1
1280  029e 6b02          	ld	(OFST+0,sp),a
1282                     ; 257 				break;
1284  02a0               L124:
1285                     ; 260 		if(speedBalanceEnable)
1287  02a0 0d02          	tnz	(OFST+0,sp)
1288  02a2 27ab          	jreq	L314
1289  02a4 20a9          	jra	L314
1302                     	xdef	_main
1303                     	xref	_UART2_GetFlagStatus
1304                     	xref	_UART2_ReceiveData8
1305                     	xref	_UART2_Cmd
1306                     	xref	_UART2_Init
1307                     	xref	_TIM3_ClearFlag
1308                     	xref	_TIM3_GetCapture1
1309                     	xref	_TIM3_Cmd
1310                     	xref	_TIM3_ICInit
1311                     	xref	_TIM2_ClearFlag
1312                     	xref	_TIM2_GetCapture1
1313                     	xref	_TIM2_Cmd
1314                     	xref	_TIM2_ICInit
1315                     	xref	_TIM1_SetCompare2
1316                     	xref	_TIM1_SetCompare1
1317                     	xref	_TIM1_CtrlPWMOutputs
1318                     	xref	_TIM1_Cmd
1319                     	xref	_TIM1_OC2Init
1320                     	xref	_TIM1_OC1Init
1321                     	xref	_TIM1_TimeBaseInit
1322                     	xref	_GPIO_WriteReverse
1323                     	xref	_GPIO_WriteLow
1324                     	xref	_GPIO_WriteHigh
1325                     	xref	_GPIO_Init
1326                     	xref	_CLK_HSIPrescalerConfig
1345                     	end

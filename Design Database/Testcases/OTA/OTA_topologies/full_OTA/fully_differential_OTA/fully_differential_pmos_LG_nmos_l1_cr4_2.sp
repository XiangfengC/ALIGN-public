************************************************************************
* auCdl Netlist:
* 
* Library Name:  OTA_class
* Top Cell Name: fully_differential_pmos
* View Name:     schematic
* Netlisted on:  Sep 11 21:06:01 2019
************************************************************************

*.BIPOLAR
*.RESI = 2000 
*.RESVAL
*.CAPVAL
*.DIOPERI
*.DIOAREA
*.EQUATION
*.SCALE METER
*.MEGA
.PARAM

*.GLOBAL gnd!
+        vdd!

*.PIN gnd!
*+    vdd!

************************************************************************
* Library Name: OTA_class
* Cell Name:    fully_differential_pmos
* View Name:    schematic
************************************************************************

.SUBCKT fully_differential_pmos Vbiasn Vbiasp Vinn Vinp Voutn Voutp
*.PININFO Vbiasp:I Vinn:I Vinp:I Vbiasn:O Voutn:O Voutp:O
MM7 Voutp Vinn net12 net16 pmos_rvt w=WA l=LA nfin=nA
MM6 Voutn Vinp net12 net16 pmos_rvt w=WA l=LA nfin=nA
MM5 net12 Vbiasp vdd! vdd! pmos_rvt w=WA l=LA nfin=nA
MM9 Voutp Vbiasn gnd! gnd! nmos_rvt w=WA l=LA nfin=nA
MM8 Voutn Vbiasn gnd! gnd! nmos_rvt w=WA l=LA nfin=nA
.ENDS


.SUBCKT LG_nmos_l1 Biasn Vbiasn Vbiasp
*.PININFO Biasn:I Vbiasn:O Vbiasp:O
MM2 Vbiasn Vbiasn gnd! gnd! nmos_rvt w=WA l=LA nfin=nA
MM10 Vbiasp Biasn gnd! gnd! nmos_rvt w=WA l=LA nfin=nA
MM1 Vbiasn Vbiasp vdd! vdd! pmos_rvt w=WA l=LA nfin=nA
MM0 Vbiasp Vbiasp vdd! vdd! pmos_rvt w=WA l=LA nfin=nA
.ENDS

.SUBCKT CR4_2 Vbiasn Vbiasp
*.PININFO Vbiasn:O Vbiasp:O
MM11 net023 net024 Vbiasn gnd! nmos_rvt w=27.0n l=LA nfin=nA
MM8 net025 net010 net023 gnd! nmos_rvt w=27.0n l=LA nfin=nA
MM9 net024 net024 net023 gnd! nmos_rvt w=27.0n l=LA nfin=nA
MM7 net010 net010 net025 gnd! nmos_rvt w=WA l=LA nfin=nA
MM2 Vbiasn Vbiasn gnd! gnd! nmos_rvt w=WA l=LA nfin=nA
MM0 Vbiasp net025 gnd! gnd! nmos_rvt w=WA l=LA nfin=nA
MM10 net024 Vbiasp vdd! vdd! pmos_rvt w=WA l=LA nfin=nA
MM4 net010 Vbiasp vdd! vdd! pmos_rvt w=WA l=LA nfin=nA
MM3 Vbiasn Vbiasp vdd! vdd! pmos_rvt w=WA l=LA nfin=nA
MM1 Vbiasp Vbiasp vdd! vdd! pmos_rvt w=WA l=LA nfin=nA
.ENDS


xiota LG_Vbiasn LG_Vbiasp Vinn Vinp Voutn Voutp fully_differential_pmos
xiLG_nmos_l1 Biasn LG_Vbiasn LG_Vbiasp LG_nmos_l1
xibCR4_2 Biasn Vbiasp CR4_2
.END
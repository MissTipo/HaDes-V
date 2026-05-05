# Testcase Results 

**Repository:** hades-v_4_MissTipo  
**Test Run:** 05.05.2026 14:31  
**Test Deadline:** 01.06.2026 00:00  
### Tested Commit Information
**Date:** 05.05.2026 14:19  
**Hash:** 73d1cf5  
**Message:** feat(decode): implement decode stage, register file, and forwarding unit  
**Committer Email:** dorine.a.tipo@gmail.com  

# Module Under Test:  Fetch Stage  
<details><summary>Details for the  Fetch Stage</summary>

**Points:**   7.29 /  8  

## delayed wishbone acknowledge  
### ack 2 cycles delayed  
  
Test input: status_backwards_in = READY, wb.ack = 0, wb.err = 0  
| Signal | Is Value | Expected Value |   
| - | - | - |  
| status_forwards_out | 0x0 | 0x1 | 
  
Test input: status_backwards_in = READY, wb.ack = 0, wb.err = 0  
| Signal | Is Value | Expected Value |   
| - | - | - |  
| status_forwards_out | 0x0 | 0x1 | 
### READY + ack=0 => BUBBLE  
  
Test input: status_backwards_in = READY, wb.ack = 0, wb.err = 0  
| Signal | Is Value | Expected Value |   
| - | - | - |  
| status_forwards_out | 0x0 | 0x1 | 
## delayed wishbone error  
### err 2 cycles delayed  
  
Test input: status_backwards_in = READY, wb.ack = 0, wb.err = 0  
| Signal | Is Value | Expected Value |   
| - | - | - |  
| status_forwards_out | 0x0 | 0x1 | 
### STALL + err=1 => ignore error  
  
Test input: status_backwards_in = STALL, wb.ack = 0, wb.err = 1  
| Signal | Is Value | Expected Value |   
| - | - | - |  
| status_forwards_out | 0x0 | 0x1 | 
</details>


# Module Under Test:  Decode Stage  
<details><summary>Details for the  Decode Stage</summary>

**Points:**   3.48 /  4  

## OPC_SYSTEM  
### ECALL  
  
Test input: ECALL with status_backwards_in = READY and status_forwards_in = VALID  
| Signal | Is Value | Expected Value |   
| - | - | - |  
| status_forwards_out | 0 | 9 | 
### EBREAK  
  
Test input: EBREAK with status_backwards_in = READY and status_forwards_in = VALID  
| Signal | Is Value | Expected Value |   
| - | - | - |  
| status_forwards_out | 0 | 10 | 
## FORWARDING NOT VALID => insert BUBBLE  
### status_backwards_in = JUMP, while forwarding.data_valid = 0  
  
Test input: BEQ with status_backwards_in = JUMP and status_forwards_in = VALID  
| Signal | Is Value | Expected Value |   
| - | - | - |  
| status_backwards_out | 1 | 2 | 
  
Test input: BEQ with status_backwards_in = JUMP and status_forwards_in = VALID  
| Signal | Is Value | Expected Value |   
| - | - | - |  
| status_backwards_out | 1 | 2 | 
### status_backwards_in = JUMP, while forwarding.data_valid = 0  
  
Test input: SW with status_backwards_in = JUMP and status_forwards_in = VALID  
| Signal | Is Value | Expected Value |   
| - | - | - |  
| status_backwards_out | 1 | 2 | 
  
Test input: SW with status_backwards_in = JUMP and status_forwards_in = VALID  
| Signal | Is Value | Expected Value |   
| - | - | - |  
| status_backwards_out | 1 | 2 | 
### status_backwards_in = JUMP, while forwarding.data_valid = 0  
  
Test input: SLT with status_backwards_in = JUMP and status_forwards_in = VALID  
| Signal | Is Value | Expected Value |   
| - | - | - |  
| status_backwards_out | 1 | 2 | 
## raise ILLEGAL_INSTRUCTION  
### invalid OPC  
  
Test input: ILLEGAL with status_backwards_in = READY and status_forwards_in = VALID  
| Signal | Is Value | Expected Value |   
| - | - | - |  
| status_forwards_out | 0 | 4 | 
  
Test input: ILLEGAL with status_backwards_in = READY and status_forwards_in = VALID  
| Signal | Is Value | Expected Value |   
| - | - | - |  
| status_forwards_out | 0 | 4 | 
### invalid FUNCT3 for OPC_BRANCH  
  
Test input: ILLEGAL with status_backwards_in = READY and status_forwards_in = VALID  
| Signal | Is Value | Expected Value |   
| - | - | - |  
| status_forwards_out | 0 | 4 | 
  
Test input: ILLEGAL with status_backwards_in = READY and status_forwards_in = VALID  
| Signal | Is Value | Expected Value |   
| - | - | - |  
| status_forwards_out | 0 | 4 | 
### invalid FUNCT3 for OPC_LOAD  
  
Test input: ILLEGAL with status_backwards_in = READY and status_forwards_in = VALID  
| Signal | Is Value | Expected Value |   
| - | - | - |  
| status_forwards_out | 0 | 4 | 
  
Test input: ILLEGAL with status_backwards_in = READY and status_forwards_in = VALID  
| Signal | Is Value | Expected Value |   
| - | - | - |  
| status_forwards_out | 0 | 4 | 
### invalid FUNCT3 for OPC_STORE  
  
Test input: ILLEGAL with status_backwards_in = READY and status_forwards_in = VALID  
| Signal | Is Value | Expected Value |   
| - | - | - |  
| status_forwards_out | 0 | 4 | 
  
Test input: ILLEGAL with status_backwards_in = READY and status_forwards_in = VALID  
| Signal | Is Value | Expected Value |   
| - | - | - |  
| status_forwards_out | 0 | 4 | 
### invalid FUNCT3 + FUNCT7 for IMM  
  
Test input: ILLEGAL with status_backwards_in = READY and status_forwards_in = VALID  
| Signal | Is Value | Expected Value |   
| - | - | - |  
| status_forwards_out | 0 | 4 | 
  
Test input: ILLEGAL with status_backwards_in = READY and status_forwards_in = VALID  
| Signal | Is Value | Expected Value |   
| - | - | - |  
| status_forwards_out | 0 | 4 | 
  
Test input: ILLEGAL with status_backwards_in = READY and status_forwards_in = VALID  
| Signal | Is Value | Expected Value |   
| - | - | - |  
| status_forwards_out | 0 | 4 | 
### invalid FUNCT3 + FUNCT7 for ALU  
  
Test input: ILLEGAL with status_backwards_in = READY and status_forwards_in = VALID  
| Signal | Is Value | Expected Value |   
| - | - | - |  
| status_forwards_out | 0 | 4 | 
  
Test input: ILLEGAL with status_backwards_in = READY and status_forwards_in = VALID  
| Signal | Is Value | Expected Value |   
| - | - | - |  
| status_forwards_out | 0 | 4 | 
  
Test input: ILLEGAL with status_backwards_in = READY and status_forwards_in = VALID  
| Signal | Is Value | Expected Value |   
| - | - | - |  
| status_forwards_out | 0 | 4 | 
  
Test input: ILLEGAL with status_backwards_in = READY and status_forwards_in = VALID  
| Signal | Is Value | Expected Value |   
| - | - | - |  
| status_forwards_out | 0 | 4 | 
### invalid CSR-address  
  
Test input: CSRRW with status_backwards_in = READY and status_forwards_in = VALID  
| Signal | Is Value | Expected Value |   
| - | - | - |  
| status_forwards_out | 0 | 4 | 
  
Test input: CSRRS with status_backwards_in = READY and status_forwards_in = VALID  
| Signal | Is Value | Expected Value |   
| - | - | - |  
| status_forwards_out | 0 | 4 | 
  
Test input: CSRRC with status_backwards_in = READY and status_forwards_in = VALID  
| Signal | Is Value | Expected Value |   
| - | - | - |  
| status_forwards_out | 0 | 4 | 
  
Test input: CSRRW with status_backwards_in = READY and status_forwards_in = VALID  
| Signal | Is Value | Expected Value |   
| - | - | - |  
| status_forwards_out | 0 | 4 | 
### invalid CSR access  
  
Test input: CSRRS with status_backwards_in = READY and status_forwards_in = VALID  
| Signal | Is Value | Expected Value |   
| - | - | - |  
| status_forwards_out | 0 | 4 | 
  
Test input: CSRRCI with status_backwards_in = READY and status_forwards_in = VALID  
| Signal | Is Value | Expected Value |   
| - | - | - |  
| status_forwards_out | 0 | 4 | 
### trigger error after STALL  
  
Test input: ILLEGAL with status_backwards_in = READY and status_forwards_in = VALID  
| Signal | Is Value | Expected Value |   
| - | - | - |  
| status_forwards_out | 0 | 4 | 
### trigger error after JUMP  
  
Test input: ILLEGAL with status_backwards_in = READY and status_forwards_in = VALID  
| Signal | Is Value | Expected Value |   
| - | - | - |  
| status_forwards_out | 0 | 4 | 
### illegal instruction word, but status_backwards_in = JUMP => ignore error  
  
Test input: ILLEGAL with status_backwards_in = JUMP and status_forwards_in = VALID  
| Signal | Is Value | Expected Value |   
| - | - | - |  
| status_backwards_out | 1 | 2 | 
## STALL error  
### trigger new error  
  
Test input: ILLEGAL with status_backwards_in = READY and status_forwards_in = VALID  
| Signal | Is Value | Expected Value |   
| - | - | - |  
| status_forwards_out | 0 | 4 | 
### STALL error  
  
Test input: SLTU with status_backwards_in = STALL and status_forwards_in = VALID  
| Signal | Is Value | Expected Value |   
| - | - | - |  
| status_forwards_out | 0 | 4 | 
### STALL error => ignore "new error"  
  
Test input: ILLEGAL with status_backwards_in = STALL and status_forwards_in = VALID  
| Signal | Is Value | Expected Value |   
| - | - | - |  
| status_forwards_out | 0 | 4 | 
### STALL error (old one)  
  
Test input: SRAI with status_backwards_in = STALL and status_forwards_in = VALID  
| Signal | Is Value | Expected Value |   
| - | - | - |  
| status_forwards_out | 0 | 4 | 
</details>


# Module Under Test:  Register File  
<details><summary>Details for the  Register File</summary>

**Points:**   2.55 /  4  

## Write values to register 0  
| Signal | Is Value | Expected Value |   
| - | - | - |  
| read_data2 | 0xffffffe1 | 0x00000000 | 
| read_data1 | 0x00000001 | 0x00000000 | 
| read_data2 | 0xffffffe2 | 0x00000000 | 
| read_data1 | 0x00000002 | 0x00000000 | 
| read_data2 | 0xffffffe3 | 0x00000000 | 
| read_data1 | 0x00000003 | 0x00000000 | 
| read_data2 | 0xffffffe4 | 0x00000000 | 
| read_data1 | 0x00000004 | 0x00000000 | 
| read_data2 | 0xffffffe5 | 0x00000000 | 
| read_data1 | 0x00000005 | 0x00000000 | 
| read_data2 | 0xffffffe6 | 0x00000000 | 
| read_data1 | 0x00000006 | 0x00000000 | 
| read_data2 | 0xffffffe7 | 0x00000000 | 
| read_data1 | 0x00000007 | 0x00000000 | 
| read_data2 | 0xffffffe8 | 0x00000000 | 
| read_data1 | 0x00000008 | 0x00000000 | 
| read_data2 | 0xffffffe9 | 0x00000000 | 
| read_data1 | 0x00000009 | 0x00000000 | 
| read_data2 | 0xffffffea | 0x00000000 | 
| read_data1 | 0x0000000a | 0x00000000 | 
| read_data2 | 0xffffffeb | 0x00000000 | 
| read_data1 | 0x0000000b | 0x00000000 | 
| read_data2 | 0xffffffec | 0x00000000 | 
| read_data1 | 0x0000000c | 0x00000000 | 
| read_data2 | 0xffffffed | 0x00000000 | 
| read_data1 | 0x0000000d | 0x00000000 | 
| read_data2 | 0xffffffee | 0x00000000 | 
| read_data1 | 0x0000000e | 0x00000000 | 
| read_data2 | 0xffffffef | 0x00000000 | 
| read_data1 | 0x0000000f | 0x00000000 | 
| read_data2 | 0xfffffff0 | 0x00000000 | 
| read_data2 | 0x0000000a | 0x00000000 | 
| read_data1 | 0x0000000f | 0x00000000 | 
| read_data2 | 0x0000000f | 0x00000000 | 
| read_data2 | 0x0000000b | 0x00000000 | 
| read_data1 | 0xffffffe1 | 0x00000000 | 
| read_data2 | 0x00000007 | 0x00000000 | 
| read_data2 | 0xffffffe1 | 0x00000000 | 
| read_data1 | 0x00000001 | 0x00000000 | 
| read_data2 | 0xffffffe2 | 0x00000000 | 
| read_data1 | 0x00000002 | 0x00000000 | 
| read_data2 | 0xffffffe3 | 0x00000000 | 
| read_data1 | 0x00000003 | 0x00000000 | 
| read_data2 | 0xffffffe4 | 0x00000000 | 
| read_data1 | 0x00000004 | 0x00000000 | 
| read_data2 | 0xffffffe5 | 0x00000000 | 
| read_data1 | 0x00000005 | 0x00000000 | 
| read_data2 | 0xffffffe6 | 0x00000000 | 
| read_data1 | 0x00000006 | 0x00000000 | 
| read_data2 | 0xffffffe7 | 0x00000000 | 
| read_data1 | 0x00000007 | 0x00000000 | 
| read_data2 | 0xffffffe8 | 0x00000000 | 
| read_data1 | 0x00000008 | 0x00000000 | 
| read_data2 | 0xffffffe9 | 0x00000000 | 
| read_data1 | 0x00000009 | 0x00000000 | 
| read_data2 | 0xffffffea | 0x00000000 | 
| read_data1 | 0x0000000a | 0x00000000 | 
| read_data2 | 0xffffffeb | 0x00000000 | 
| read_data1 | 0x0000000b | 0x00000000 | 
| read_data2 | 0xffffffec | 0x00000000 | 
| read_data1 | 0x0000000c | 0x00000000 | 
| read_data2 | 0xffffffed | 0x00000000 | 
| read_data1 | 0x0000000d | 0x00000000 | 
| read_data2 | 0xffffffee | 0x00000000 | 
| read_data1 | 0x0000000e | 0x00000000 | 
| read_data2 | 0xffffffef | 0x00000000 | 
| read_data1 | 0x0000000f | 0x00000000 | 
| read_data2 | 0xfffffff0 | 0x00000000 | 
## Write values to registers with write_enable = 0  
| Signal | Is Value | Expected Value |   
| - | - | - |  
| read_data2 | 0xffffffe1 | 0x00000000 | 
| read_data1 | 0x00000001 | 0x00000000 | 
| read_data2 | 0xffffffe2 | 0x00000000 | 
| read_data1 | 0x00000002 | 0x00000000 | 
| read_data2 | 0xffffffe3 | 0x00000000 | 
| read_data1 | 0x00000003 | 0x00000000 | 
| read_data2 | 0xffffffe4 | 0x00000000 | 
| read_data1 | 0x00000004 | 0x00000000 | 
| read_data2 | 0xffffffe5 | 0x00000000 | 
| read_data1 | 0x00000005 | 0x00000000 | 
| read_data2 | 0xffffffe6 | 0x00000000 | 
| read_data1 | 0x00000006 | 0x00000000 | 
| read_data2 | 0xffffffe7 | 0x00000000 | 
| read_data1 | 0x00000007 | 0x00000000 | 
| read_data2 | 0xffffffe8 | 0x00000000 | 
| read_data1 | 0x00000008 | 0x00000000 | 
| read_data2 | 0xffffffe9 | 0x00000000 | 
| read_data1 | 0x00000009 | 0x00000000 | 
| read_data2 | 0xffffffea | 0x00000000 | 
| read_data1 | 0x0000000a | 0x00000000 | 
| read_data2 | 0xffffffeb | 0x00000000 | 
| read_data1 | 0x0000000b | 0x00000000 | 
| read_data2 | 0xffffffec | 0x00000000 | 
| read_data1 | 0x0000000c | 0x00000000 | 
| read_data2 | 0xffffffed | 0x00000000 | 
| read_data1 | 0x0000000d | 0x00000000 | 
| read_data2 | 0xffffffee | 0x00000000 | 
| read_data1 | 0x0000000e | 0x00000000 | 
| read_data2 | 0xffffffef | 0x00000000 | 
| read_data1 | 0x0000000f | 0x00000000 | 
| read_data2 | 0xfffffff0 | 0x00000000 | 
| read_data2 | 0xffffffe1 | 0x00000000 | 
| read_data1 | 0xffffffe1 | 0x00000000 | 
| read_data2 | 0xffffffe2 | 0x00000000 | 
| read_data1 | 0xffffffe2 | 0x00000000 | 
| read_data2 | 0xffffffe3 | 0x00000000 | 
| read_data1 | 0xffffffe3 | 0x00000000 | 
| read_data2 | 0xffffffe4 | 0x00000000 | 
| read_data1 | 0xffffffe4 | 0x00000000 | 
| read_data2 | 0xffffffe5 | 0x00000000 | 
| read_data1 | 0xffffffe5 | 0x00000000 | 
| read_data2 | 0xffffffe6 | 0x00000000 | 
| read_data1 | 0xffffffe6 | 0x00000000 | 
| read_data2 | 0xffffffe7 | 0x00000000 | 
| read_data1 | 0xffffffe7 | 0x00000000 | 
| read_data2 | 0xffffffe8 | 0x00000000 | 
| read_data1 | 0xffffffe8 | 0x00000000 | 
| read_data2 | 0xffffffe9 | 0x00000000 | 
| read_data1 | 0xffffffe9 | 0x00000000 | 
| read_data2 | 0xffffffea | 0x00000000 | 
| read_data1 | 0xffffffea | 0x00000000 | 
| read_data2 | 0xffffffeb | 0x00000000 | 
| read_data1 | 0xffffffeb | 0x00000000 | 
| read_data2 | 0xffffffec | 0x00000000 | 
| read_data1 | 0xffffffec | 0x00000000 | 
| read_data2 | 0xffffffed | 0x00000000 | 
| read_data1 | 0xffffffed | 0x00000000 | 
| read_data2 | 0xffffffee | 0x00000000 | 
| read_data1 | 0xffffffee | 0x00000000 | 
| read_data2 | 0xffffffef | 0x00000000 | 
| read_data1 | 0xffffffef | 0x00000000 | 
| read_data2 | 0xfffffff0 | 0x00000000 | 
| read_data1 | 0xfffffff0 | 0x00000000 | 
| read_data2 | 0x0000000f | 0x00000000 | 
| read_data1 | 0x0000000f | 0x00000000 | 
| read_data2 | 0x0000000e | 0x00000000 | 
| read_data1 | 0x0000000e | 0x00000000 | 
| read_data2 | 0x0000000d | 0x00000000 | 
| read_data1 | 0x0000000d | 0x00000000 | 
| read_data2 | 0x0000000c | 0x00000000 | 
| read_data1 | 0x0000000c | 0x00000000 | 
| read_data2 | 0x0000000b | 0x00000000 | 
| read_data1 | 0x0000000b | 0x00000000 | 
| read_data2 | 0x0000000a | 0x00000000 | 
| read_data1 | 0x0000000a | 0x00000000 | 
| read_data2 | 0x00000009 | 0x00000000 | 
| read_data1 | 0x00000009 | 0x00000000 | 
| read_data2 | 0x00000008 | 0x00000000 | 
| read_data1 | 0x00000008 | 0x00000000 | 
| read_data2 | 0x00000007 | 0x00000000 | 
| read_data1 | 0x00000007 | 0x00000000 | 
| read_data2 | 0x00000006 | 0x00000000 | 
| read_data1 | 0x00000006 | 0x00000000 | 
| read_data2 | 0x00000005 | 0x00000000 | 
| read_data1 | 0x00000005 | 0x00000000 | 
| read_data2 | 0x00000004 | 0x00000000 | 
| read_data1 | 0x00000004 | 0x00000000 | 
| read_data2 | 0x00000003 | 0x00000000 | 
| read_data1 | 0x00000003 | 0x00000000 | 
| read_data2 | 0x00000002 | 0x00000000 | 
| read_data1 | 0x00000002 | 0x00000000 | 
| read_data2 | 0x00000001 | 0x00000000 | 
| read_data1 | 0x00000001 | 0x00000000 | 
| read_data2 | 0xffffffe1 | 0x00000000 | 
| read_data1 | 0x00000001 | 0x00000000 | 
| read_data2 | 0xffffffe2 | 0x00000000 | 
| read_data1 | 0x00000002 | 0x00000000 | 
| read_data2 | 0xffffffe3 | 0x00000000 | 
| read_data1 | 0x00000003 | 0x00000000 | 
| read_data2 | 0xffffffe4 | 0x00000000 | 
| read_data1 | 0x00000004 | 0x00000000 | 
| read_data2 | 0xffffffe5 | 0x00000000 | 
| read_data1 | 0x00000005 | 0x00000000 | 
| read_data2 | 0xffffffe6 | 0x00000000 | 
| read_data1 | 0x00000006 | 0x00000000 | 
| read_data2 | 0xffffffe7 | 0x00000000 | 
| read_data1 | 0x00000007 | 0x00000000 | 
| read_data2 | 0xffffffe8 | 0x00000000 | 
| read_data1 | 0x00000008 | 0x00000000 | 
| read_data2 | 0xffffffe9 | 0x00000000 | 
| read_data1 | 0x00000009 | 0x00000000 | 
| read_data2 | 0xffffffea | 0x00000000 | 
| read_data1 | 0x0000000a | 0x00000000 | 
| read_data2 | 0xffffffeb | 0x00000000 | 
| read_data1 | 0x0000000b | 0x00000000 | 
| read_data2 | 0xffffffec | 0x00000000 | 
| read_data1 | 0x0000000c | 0x00000000 | 
| read_data2 | 0xffffffed | 0x00000000 | 
| read_data1 | 0x0000000d | 0x00000000 | 
| read_data2 | 0xffffffee | 0x00000000 | 
| read_data1 | 0x0000000e | 0x00000000 | 
| read_data2 | 0xffffffef | 0x00000000 | 
| read_data1 | 0x0000000f | 0x00000000 | 
| read_data2 | 0xfffffff0 | 0x00000000 | 
</details>


# Testcase Results 

**Repository:** hades-v_4_MissTipo  
**Test Run:** 22.03.2026 00:00  
**Test Deadline:** 03.06.2026 00:00  
### Tested Commit Information
**Date:** 21.03.2026 12:59  
**Hash:** 5c72b2d  
**Message:** feat(fetch): implement instruction fetch stage  
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


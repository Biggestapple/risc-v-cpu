# risc-v-cpu
This is a simple risc-v core based on FPGA  

这个Risc-v核心结构来自于《Digital Design and Computer Architecture RISC-V Edition》的Chapter 7  
并用Verilog语言实现，特别针对单周期处理器部分(基本完成)做了部分改进,使得时序更加稳定，并支持  
绝大多数的RV32I指令集，添加了外部的IO总线模块，使得处理器能够访问外部IO.  

开发平台：紫光同创MES50HP盘古开发板  
单周期处理器模型由于使用过多的组合逻辑，使得时序难以收敛，鉴于门延时的存在，在高主频下可能不稳定  
所以在Demo中使用pll生成5Mhz时钟作为系统时钟，而实际的运行速度是系统时钟的二分频即2.5Mhz  
单周期处理器占用FPGA中大量资源(实测PANGOP50超过30%)而不具有实用价值，仅仅作为实验用途，所以除  
必要的分支、运算指令，部分指令未实现比如移位指令等详见下表.



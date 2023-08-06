# CRC
CRC stands for Cyclic Redundancy check. 
it's an error detecting code that finds changes in data as it travels from one computer to another by adding a code to the end of data string.
CRC works at the data link layer by protocols such as Ethernet.
It's easy to implement in hardware with shift feedback registers, as the message leaves the network card from the sending computer it travels through the shift feedback register 
and what remains in the register as all the message bits leave is the CRC. and the register attaches that CRC to the end of the message.
And the idea of using simple registers to check for errors is to ensure that there is no added latency   

*********** Specification ****************
1. All registers are set to LFSR Seed value using asynchronous active low reset (SEED = 8'hD8)
2. All outputs are registered
3. DATA serial bit length vary from 1 byte to 4 bytes (Typically: 1 Byte)
4. ACTIVE input signal is high during data transmission, low otherwise
5. CRC 8 bits are shifted serially through CRC output port
6. Valid signal is high during CRC bits transmission, otherwise low.

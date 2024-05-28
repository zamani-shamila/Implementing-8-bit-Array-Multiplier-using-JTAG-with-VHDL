----------Full Adder-----------

--Style of Modelling: Dataflow

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
 
entity fullAdder is
 Port ( A : in STD_LOGIC;
 B : in STD_LOGIC;
 Cin : in STD_LOGIC;
 S : out STD_LOGIC;
 Cout : out STD_LOGIC);
end fullAdder;
 
architecture fulladd of fullAdder is
 
 signal AxorB: std_logic;
 signal NotA, NotB, NotCin: std_logic;
 signal t1, t2, t3, t4: std_logic;
 signal AandB, BandCin, AandCin: std_logic;
 begin
--  AxorB <= A XOR B;
--  S <=  AxorB XOR Cin ;
--  Cout <= (AxorB and Cin) or (A AND B)  ;
 NotA <=not A;
 NotB <= not B;
 NotCin <= not Cin;
 t1 <= (NotA and NotB) and Cin;
 t2 <= (NotA and B) and NotCin;
 t3 <= (A and NotB) and NotCin;
 t4 <= (A and B) and Cin;
 S <= (((t1 or t2) or t3) or t4);
 
 AandB <= A and B;
 BandCin <= B and Cin;
 AandCin <= A and Cin;
 
 Cout <= ((AandB or BandCin) or AandCin);
 
end fulladd;
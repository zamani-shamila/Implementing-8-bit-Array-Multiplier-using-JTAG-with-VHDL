------------- AND Gate for Partial Product Generator--------
--Purpose: AND gate used in partial product Generator
--Style of modelling: Dataflow
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity myAND is
  Port ( a : in STD_LOGIC;
  b : in STD_LOGIC;
  Y : out STD_LOGIC);
end myAND;
architecture Behavioral of myAND is
begin
  Y <= a AND b;
end Behavioral;


----------- Partial Product Generator for Multiplier ---------
--Purpose: Generation of 64 (8x8) partial products for input operands.
--Style of modelling: Structural
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity creating_pp is
  Port ( A : in STD_LOGIC_VECTOR (7 downto 0);
  B : in STD_LOGIC_VECTOR (7 downto 0);
  Y : out STD_LOGIC_VECTOR (63 downto 0));
end creating_pp;
architecture Behavioral of creating_pp is
-- component declaration
component myAND
  port(a,b : in std_logic; y: out std_logic);
end component;
begin
a0: myAND port map(a(0),b(0),y(0));a1: myAND port map(a(1),b(0),y(1));
a2: myAND port map(a(2),b(0),y(2));a3: myAND port map(a(3),b(0),y(3));
a4: myAND port map(a(4),b(0),y(4));a5: myAND port map(a(5),b(0),y(5));
a6: myAND port map(a(6),b(0),y(6));a7: myAND port map(a(7),b(0),y(7));
a8: myAND port map(a(0),b(1),y(8));a9: myAND port map(a(1),b(1),y(9));
a10: myAND port map(a(2),b(1),y(10));a11: myAND port map(a(3),b(1),y(11));
a12: myAND port map(a(4),b(1),y(12));a13: myAND port map(a(5),b(1),y(13));
a14: myAND port map(a(6),b(1),y(14));a15: myAND port map(a(7),b(1),y(15));
a16: myAND port map(a(0),b(2),y(16));a17: myAND port map(a(1),b(2),y(17));
a18: myAND port map(a(2),b(2),y(18));a19: myAND port map(a(3),b(2),y(19));
a20: myAND port map(a(4),b(2),y(20));a21: myAND port map(a(5),b(2),y(21));
a22: myAND port map(a(6),b(2),y(22));a23: myAND port map(a(7),b(2),y(23));
a24: myAND port map(a(0),b(3),y(24));a25: myAND port map(a(1),b(3),y(25));
a26: myAND port map(a(2),b(3),y(26));a27: myAND port map(a(3),b(3),y(27));
a28: myAND port map(a(4),b(3),y(28));a29: myAND port map(a(5),b(3),y(29));
a30: myAND port map(a(6),b(3),y(30));a31: myAND port map(a(7),b(3),y(31));
a32: myAND port map(a(0),b(4),y(32));a33: myAND port map(a(1),b(4),y(33));
a34: myAND port map(a(2),b(4),y(34));a35: myAND port map(a(3),b(4),y(35));
a36: myAND port map(a(4),b(4),y(36));a37: myAND port map(a(5),b(4),y(37));
a38: myAND port map(a(6),b(4),y(38));a39: myAND port map(a(7),b(4),y(39));
a40: myAND port map(a(0),b(5),y(40));a41: myAND port map(a(1),b(5),y(41));
a42: myAND port map(a(2),b(5),y(42));a43: myAND port map(a(3),b(5),y(43));
a44: myAND port map(a(4),b(5),y(44));a45: myAND port map(a(5),b(5),y(45));
a46: myAND port map(a(6),b(5),y(46));a47: myAND port map(a(7),b(5),y(47));
a48: myAND port map(a(0),b(6),y(48));a49: myAND port map(a(1),b(6),y(49));
a50: myAND port map(a(2),b(6),y(50));a51: myAND port map(a(3),b(6),y(51));
a52: myAND port map(a(4),b(6),y(52));a53: myAND port map(a(5),b(6),y(53));
a54: myAND port map(a(6),b(6),y(54));a55: myAND port map(a(7),b(6),y(55));
a56: myAND port map(a(0),b(7),y(56));a57: myAND port map(a(1),b(7),y(57));
a58: myAND port map(a(2),b(7),y(58));a59: myAND port map(a(3),b(7),y(59));
a60: myAND port map(a(4),b(7),y(60));a61: myAND port map(a(5),b(7),y(61));
a62: myAND port map(a(6),b(7),y(62));a63: myAND port map(a(7),b(7),y(63));
end Behavioral;



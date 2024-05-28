


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use IEEE.NUMERIC_STD.ALL;



ENTITY boundrySReg IS
        PORT(
            boundryScell_in1:IN  STD_LOGIC_VECTOR (7 downto 0);
            boundryScell_in2:IN STD_LOGIC_VECTOR (7 downto 0);
            
            ClockDR, UpdateDR:IN std_logic;
            shiftDR, Mode: IN std_logic;
            reset,clock: IN std_logic;
            TDI: IN std_logic;
            boundrySReg_out: OUT std_logic;
            --
            --TDO: OuT std_logic;
            --
	       --boundryScell_out8,boundryScell_out9,boundryScell_out10,boundryScell_out11,boundryScell_out12,boundryScell_out13,boundryScell_out14,boundryScell_out15: OUT std_logic
            boundryScell_out: OUT STD_LOGIC_VECTOR (15 downto 0)
            --boundryScell_NexCell_in: OUT std_logic
        );
        
END boundrySReg;




ARCHITECTURE Behavioral OF boundrySReg IS

SIGNAL boundryScell_NexCell_out:STD_LOGIC_VECTOR (30 downto 0);

SIGNAL Mult_in1, Mult_in2: STD_LOGIC_VECTOR (7 downto 0);
SIGNAL Mult_out : STD_LOGIC_VECTOR (15 downto 0);

COMPONENT boundryScell IS
        PORT(

            boundryScell_in, boundryScell_PrevCell_in: IN std_logic;
            ClockDR, UpdateDR:IN std_logic;
            shiftDR, Mode: IN std_logic;
            reset,clock: IN std_logic;
	        boundryScell_out,boundryScell_NexCell_out: OUT std_logic
        );
        
END COMPONENT;


COMPONENT multi_8bit is
            Port ( a : in STD_LOGIC_VECTOR (7 downto 0);
            x : in STD_LOGIC_VECTOR (7 downto 0);
            p : out STD_LOGIC_VECTOR (15 downto 0));
END COMPONENT ;


BEGIN


         -- entity multi_8bit is
        --     Port ( a : in STD_LOGIC_VECTOR (7 downto 0);
        --     x : in STD_LOGIC_VECTOR (7 downto 0);
        --     p : out STD_LOGIC_VECTOR (15 downto 0));
        --   end multi_8bit;
        MULT:multi_8bit

        PORT MAP(
           
            a => Mult_in1, x => Mult_in2,
            p => Mult_out
        );


    -- first 8bit
        cell0:boundryScell
        PORT MAP(
            clock => clock, reset=> reset,shiftDR => shiftDR, Mode => Mode,
            ClockDR => ClockDR, UpdateDR => UpdateDR,
            boundryScell_in => boundryScell_in1(0), boundryScell_PrevCell_in => boundryScell_NexCell_out(14),
            boundryScell_out => Mult_in1(0), boundryScell_NexCell_out => boundryScell_NexCell_out(15)
        );
    
    
        cell1:boundryScell
        PORT MAP(
            clock => clock, reset=> reset,shiftDR => shiftDR, Mode => Mode,
            ClockDR => ClockDR, UpdateDR => UpdateDR,
            boundryScell_in => boundryScell_in1(1), boundryScell_PrevCell_in => boundryScell_NexCell_out(13),
            boundryScell_out => Mult_in1(1), boundryScell_NexCell_out => boundryScell_NexCell_out(14)
        );

        cell2:boundryScell
        PORT MAP(
            clock => clock, reset=> reset,shiftDR => shiftDR, Mode => Mode,
            ClockDR => ClockDR, UpdateDR => UpdateDR,
            boundryScell_in => boundryScell_in1(2), boundryScell_PrevCell_in => boundryScell_NexCell_out(12),
            boundryScell_out => Mult_in1(2), boundryScell_NexCell_out => boundryScell_NexCell_out(13)
        );
        cell3:boundryScell
        PORT MAP(
            clock => clock, reset=> reset,shiftDR => shiftDR, Mode => Mode,
            ClockDR => ClockDR, UpdateDR => UpdateDR,
            boundryScell_in => boundryScell_in1(3), boundryScell_PrevCell_in => boundryScell_NexCell_out(11),
            boundryScell_out => Mult_in1(3), boundryScell_NexCell_out => boundryScell_NexCell_out(12)
        );
        cell4:boundryScell
        PORT MAP(
                clock => clock, reset=> reset,shiftDR => shiftDR, Mode => Mode,
                ClockDR => ClockDR, UpdateDR => UpdateDR,
                boundryScell_in => boundryScell_in1(4), boundryScell_PrevCell_in => boundryScell_NexCell_out(10),
                boundryScell_out => Mult_in1(4), boundryScell_NexCell_out => boundryScell_NexCell_out(11)
        );
        cell5:boundryScell

        PORT MAP(
            clock => clock, reset=> reset,shiftDR => shiftDR, Mode => Mode,
            ClockDR => ClockDR, UpdateDR => UpdateDR,
            boundryScell_in => boundryScell_in1(5), boundryScell_PrevCell_in => boundryScell_NexCell_out(9),
            boundryScell_out => Mult_in1(5), boundryScell_NexCell_out => boundryScell_NexCell_out(10)
        );
        cell6:boundryScell

        PORT MAP(
            clock => clock, reset=> reset,shiftDR => shiftDR, Mode => Mode,
            ClockDR => ClockDR, UpdateDR => UpdateDR,
            boundryScell_in => boundryScell_in1(6), boundryScell_PrevCell_in => boundryScell_NexCell_out(8),
            boundryScell_out => Mult_in1(6), boundryScell_NexCell_out => boundryScell_NexCell_out(9)
        );
        cell7:boundryScell

        PORT MAP(
            clock => clock, reset=> reset,shiftDR => shiftDR, Mode => Mode,
            ClockDR => ClockDR, UpdateDR => UpdateDR,
            boundryScell_in => boundryScell_in1(7), boundryScell_PrevCell_in => boundryScell_NexCell_out(7),
            boundryScell_out => Mult_in1(7), boundryScell_NexCell_out => boundryScell_NexCell_out(8)
        );

    -- second 8bit


        cell8:boundryScell

        PORT MAP(
            clock => clock, reset=> reset,shiftDR => shiftDR, Mode => Mode,
            ClockDR => ClockDR, UpdateDR => UpdateDR,
            boundryScell_in => boundryScell_in2(0), boundryScell_PrevCell_in => boundryScell_NexCell_out(6),
            boundryScell_out => Mult_in2(0), boundryScell_NexCell_out => boundryScell_NexCell_out(7)
        );


        cell9:boundryScell

        PORT MAP(
            clock => clock, reset=> reset,shiftDR => shiftDR, Mode => Mode,
            ClockDR => ClockDR, UpdateDR => UpdateDR,
            boundryScell_in => boundryScell_in2(1), boundryScell_PrevCell_in => boundryScell_NexCell_out(5),
            boundryScell_out => Mult_in2(1), boundryScell_NexCell_out => boundryScell_NexCell_out(6)
        );

        cell10:boundryScell

        PORT MAP(
            clock => clock, reset=> reset,shiftDR => shiftDR, Mode => Mode,
            ClockDR => ClockDR, UpdateDR => UpdateDR,
            boundryScell_in => boundryScell_in2(2), boundryScell_PrevCell_in => boundryScell_NexCell_out(4),
            boundryScell_out => Mult_in2(2), boundryScell_NexCell_out => boundryScell_NexCell_out(5)
        );


        cell11:boundryScell

        PORT MAP(
            clock => clock, reset=> reset,shiftDR => shiftDR, Mode => Mode,
            ClockDR => ClockDR, UpdateDR => UpdateDR,
            boundryScell_in => boundryScell_in2(3), boundryScell_PrevCell_in => boundryScell_NexCell_out(3),
            boundryScell_out => Mult_in2(3), boundryScell_NexCell_out => boundryScell_NexCell_out(4)
        );


        cell12:boundryScell

        PORT MAP(
            clock => clock, reset=> reset,shiftDR => shiftDR, Mode => Mode,
            ClockDR => ClockDR, UpdateDR => UpdateDR,
            boundryScell_in => boundryScell_in2(4), boundryScell_PrevCell_in => boundryScell_NexCell_out(2),
            boundryScell_out => Mult_in2(4), boundryScell_NexCell_out => boundryScell_NexCell_out(3)
        );


        cell13:boundryScell

        PORT MAP(
            clock => clock, reset=> reset,shiftDR => shiftDR, Mode => Mode,
            ClockDR => ClockDR, UpdateDR => UpdateDR,
            boundryScell_in => boundryScell_in2(5), boundryScell_PrevCell_in => boundryScell_NexCell_out(1),
            boundryScell_out => Mult_in2(5), boundryScell_NexCell_out => boundryScell_NexCell_out(2)
        );


        cell14:boundryScell

        PORT MAP(
            clock => clock, reset=> reset,shiftDR => shiftDR, Mode => Mode,
            ClockDR => ClockDR, UpdateDR => UpdateDR,
            boundryScell_in => boundryScell_in2(6), boundryScell_PrevCell_in => boundryScell_NexCell_out(0),
            boundryScell_out => Mult_in2(6), boundryScell_NexCell_out => boundryScell_NexCell_out(1)
        );


        cell15:boundryScell

        PORT MAP(
            clock => clock, reset=> reset,shiftDR => shiftDR, Mode => Mode,
            ClockDR => ClockDR, UpdateDR => UpdateDR,
            boundryScell_in => boundryScell_in2(7), boundryScell_PrevCell_in => TDI,
            boundryScell_out => Mult_in2(7), boundryScell_NexCell_out => boundryScell_NexCell_out(0)
        );

    -- third 16bit
         ---------------------------------------------------------------------------------------------------------   

        cellO1:boundryScell

        PORT MAP(
            clock => clock, reset=> reset,shiftDR => shiftDR, Mode => Mode,
            ClockDR => ClockDR, UpdateDR => UpdateDR,
            boundryScell_in => Mult_out(0), boundryScell_PrevCell_in => boundryScell_NexCell_out(15),
            boundryScell_out => boundryScell_out(0), boundryScell_NexCell_out => boundryScell_NexCell_out(16)
        );

        cellO2:boundryScell

        PORT MAP(
            clock => clock, reset=> reset,shiftDR => shiftDR, Mode => Mode,
            ClockDR => ClockDR, UpdateDR => UpdateDR,
            boundryScell_in => Mult_out(1), boundryScell_PrevCell_in => boundryScell_NexCell_out(16),
            boundryScell_out => boundryScell_out(1), boundryScell_NexCell_out => boundryScell_NexCell_out(17)
        );

        cellO3:boundryScell

        PORT MAP(
            clock => clock, reset=> reset,shiftDR => shiftDR, Mode => Mode,
            ClockDR => ClockDR, UpdateDR => UpdateDR,
            boundryScell_in => Mult_out(2), boundryScell_PrevCell_in => boundryScell_NexCell_out(17),
            boundryScell_out => boundryScell_out(2), boundryScell_NexCell_out => boundryScell_NexCell_out(18)
        );

        cellO4:boundryScell

        PORT MAP(
            clock => clock, reset=> reset,shiftDR => shiftDR, Mode => Mode,
            ClockDR => ClockDR, UpdateDR => UpdateDR,
            boundryScell_in => Mult_out(3), boundryScell_PrevCell_in => boundryScell_NexCell_out(18),
            boundryScell_out => boundryScell_out(3), boundryScell_NexCell_out => boundryScell_NexCell_out(19)
        );

        cellO5:boundryScell

        PORT MAP(
            clock => clock, reset=> reset,shiftDR => shiftDR, Mode => Mode,
            ClockDR => ClockDR, UpdateDR => UpdateDR,
            boundryScell_in => Mult_out(4), boundryScell_PrevCell_in => boundryScell_NexCell_out(19),
            boundryScell_out => boundryScell_out(4), boundryScell_NexCell_out => boundryScell_NexCell_out(20)
        );

        cellO6:boundryScell

        PORT MAP(
            clock => clock, reset=> reset,shiftDR => shiftDR, Mode => Mode,
            ClockDR => ClockDR, UpdateDR => UpdateDR,
            boundryScell_in => Mult_out(5), boundryScell_PrevCell_in => boundryScell_NexCell_out(20),
            boundryScell_out => boundryScell_out(5), boundryScell_NexCell_out => boundryScell_NexCell_out(21)
        );

        cellO7:boundryScell

        PORT MAP(
            clock => clock, reset=> reset,shiftDR => shiftDR, Mode => Mode,
            ClockDR => ClockDR, UpdateDR => UpdateDR,
            boundryScell_in => Mult_out(6), boundryScell_PrevCell_in => boundryScell_NexCell_out(21),
            boundryScell_out => boundryScell_out(6), boundryScell_NexCell_out => boundryScell_NexCell_out(22)
        );

        cellO8:boundryScell

        PORT MAP(
            clock => clock, reset=> reset,shiftDR => shiftDR, Mode => Mode,
            ClockDR => ClockDR, UpdateDR => UpdateDR,
            boundryScell_in => Mult_out(7), boundryScell_PrevCell_in => boundryScell_NexCell_out(22),
            boundryScell_out => boundryScell_out(7), boundryScell_NexCell_out => boundryScell_NexCell_out(23)
        );

        cellO9:boundryScell

        PORT MAP(
            clock => clock, reset=> reset,shiftDR => shiftDR, Mode => Mode,
            ClockDR => ClockDR, UpdateDR => UpdateDR,
            boundryScell_in => Mult_out(8), boundryScell_PrevCell_in => boundryScell_NexCell_out(23),
            boundryScell_out => boundryScell_out(8), boundryScell_NexCell_out => boundryScell_NexCell_out(24)
        );


        cellO10:boundryScell

        PORT MAP(
            clock => clock, reset=> reset,shiftDR => shiftDR, Mode => Mode,
            ClockDR => ClockDR, UpdateDR => UpdateDR,
            boundryScell_in => Mult_out(9), boundryScell_PrevCell_in => boundryScell_NexCell_out(24),
            boundryScell_out => boundryScell_out(9), boundryScell_NexCell_out => boundryScell_NexCell_out(25)
        );

        cellO11:boundryScell

        PORT MAP(
            clock => clock, reset=> reset,shiftDR => shiftDR, Mode => Mode,
            ClockDR => ClockDR, UpdateDR => UpdateDR,
            boundryScell_in => Mult_out(10), boundryScell_PrevCell_in => boundryScell_NexCell_out(25),
            boundryScell_out => boundryScell_out(10), boundryScell_NexCell_out => boundryScell_NexCell_out(26)
        );

        cellO12:boundryScell

        PORT MAP(
            clock => clock, reset=> reset,shiftDR => shiftDR, Mode => Mode,
            ClockDR => ClockDR, UpdateDR => UpdateDR,
            boundryScell_in => Mult_out(11), boundryScell_PrevCell_in => boundryScell_NexCell_out(26),
            boundryScell_out => boundryScell_out(11), boundryScell_NexCell_out => boundryScell_NexCell_out(27)
        );


        cellO13:boundryScell

        PORT MAP(
            clock => clock, reset=> reset,shiftDR => shiftDR, Mode => Mode,
            ClockDR => ClockDR, UpdateDR => UpdateDR,
            boundryScell_in => Mult_out(12), boundryScell_PrevCell_in => boundryScell_NexCell_out(27),
            boundryScell_out => boundryScell_out(12), boundryScell_NexCell_out => boundryScell_NexCell_out(28)
        );


        cellO14:boundryScell

        PORT MAP(
            clock => clock, reset=> reset,shiftDR => shiftDR, Mode => Mode,
            ClockDR => ClockDR, UpdateDR => UpdateDR,
            boundryScell_in => Mult_out(13), boundryScell_PrevCell_in => boundryScell_NexCell_out(28),
            boundryScell_out => boundryScell_out(13), boundryScell_NexCell_out => boundryScell_NexCell_out(29)
        );


        cellO15:boundryScell

        PORT MAP(
            clock => clock, reset=> reset,shiftDR => shiftDR, Mode => Mode,
            ClockDR => ClockDR, UpdateDR => UpdateDR,
            boundryScell_in => Mult_out(14), boundryScell_PrevCell_in => boundryScell_NexCell_out(29),
            boundryScell_out => boundryScell_out(14), boundryScell_NexCell_out => boundryScell_NexCell_out(30)
        );


        cellO16:boundryScell

        PORT MAP(
            clock => clock, reset=> reset,shiftDR => shiftDR, Mode => Mode,
            ClockDR => ClockDR, UpdateDR => UpdateDR,
            boundryScell_in => Mult_out(15), boundryScell_PrevCell_in => boundryScell_NexCell_out(30),
            boundryScell_out => boundryScell_out(15), boundryScell_NexCell_out => boundrySReg_out
        );


       
      
       
       
        






end Behavioral;


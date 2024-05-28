


library IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_ARITH.ALL;
USE IEEE.STD_LOGIC_UNSIGNED.ALL;
USE IEEE.NUMERIC_STD.ALL;


entity tb4_TopLevel is
end tb4_TopLevel;

architecture tb of tb4_TopLevel is

    component TopLevel
        port (TMS            : in std_logic;
              TDO            : out std_logic;
	      Mode: IN std_logic; 
              Multiplier_in1 : in std_logic_vector (7 downto 0);
              Multiplier_in2 : in std_logic_vector (7 downto 0);
              reset          : in std_logic;
              clock          : in std_logic;
              TDI            : in std_logic;
              Multiplier_out : out std_logic_vector (15 downto 0));
    end component;
	
    signal Mode		  : std_logic := '1'; 
    signal TMS            : std_logic := '1';
    signal TDO            : std_logic:= '0';
    signal Multiplier_in1 : std_logic_vector (7 downto 0);
    signal Multiplier_in2 : std_logic_vector (7 downto 0);
    signal reset          : std_logic;
    signal clock          : std_logic;
    signal TDI            : std_logic;
    signal Multiplier_out : std_logic_vector (15 downto 0):= (others => '0');

    constant clock_period : time := 10 ns; -- EDIT Put right period here
    
    SIGNAL TbSimEnded : BOOLEAN;

begin

    dut : TopLevel
    port map (Mode	     => Mode,
	      TMS            => TMS,
              TDO            => TDO,
              Multiplier_in1 => Multiplier_in1,
              Multiplier_in2 => Multiplier_in2,
              reset          => reset,
              clock          => clock,
              TDI            => TDI,
              Multiplier_out => Multiplier_out);

    -- Clock generation
      
    clocking : PROCESS
    BEGIN
      WHILE NOT TbSimEnded LOOP
      clock <= '0', '1' AFTER clock_period / 2;
        WAIT FOR clock_period;
      END LOOP;
      WAIT;
    END PROCESS; 

    stimuli : process
    begin
        -- EDIT Adapt initialization as needed

        TMS <= '1';
        Multiplier_in1 <= (others => '0');
        Multiplier_in2 <= (others => '0');
        TDI <= '0';
	Mode <= '0';
        -- Reset generation
        -- EDIT: Check that reset is really your reset signal
        reset <= '1';
        wait for 2*clock_period;
        reset <= '0';
        wait for 2*clock_period;

        -- EDIT Add stimuli here
        
        				
				
				
		Multiplier_in2 <= x"77";
		Multiplier_in1	<= x"57";
		TDI <= '1';
                TMS <= '0';
		Mode <= '1';
                wait for clock_period;
                TMS <= '0';
                wait for clock_period;
                TMS <= '0';
                wait for clock_period;
                TMS <= '0';
                       ------ SP
                wait for clock_period;
                TMS <= '1';
                wait for clock_period;
                TMS <= '0';
                wait for clock_period;
                TMS <= '0';
                wait for 8*clock_period;
				
				
				TMS <= '1';
                wait for clock_period;
				TMS <= '1';
                wait for clock_period;
				TMS <= '1';
                wait for clock_period;
				TMS <= '1';
                wait for clock_period;
				
				TMS <= '1';
                wait for clock_period;
                TMS <= '1';
                wait for clock_period; 
		TMS <= '1';
                wait for clock_period;
		
			   --- BYPASS
                TMS <= '1';
                wait for clock_period;
                TMS <= '1';
                wait for clock_period;
                TMS <= '1';
                wait for clock_period;
                TMS <= '1';
		wait for clock_period;


        -- Stop the clock and hence terminate the simulation
        TbSimEnded <= true;
        wait;
    end process;

end tb;

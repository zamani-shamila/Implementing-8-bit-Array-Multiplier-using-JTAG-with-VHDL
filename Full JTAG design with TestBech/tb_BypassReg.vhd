
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;





entity tb_BypassReg is
end tb_BypassReg;

architecture tb of tb_BypassReg is

    component BypassReg
        port (reset          : in std_logic;
              clock          : in std_logic;
              TDI            : in std_logic;
              shiftDR        : in std_logic;
              ClockDR        : in std_logic;
              BypassReg_OUT  : out std_logic);
    end component;

    signal reset          : std_logic;
    signal clock          : std_logic;
    signal TDI            : std_logic;
    signal shiftDR        : std_logic;
    signal ClockDR        : std_logic;
    signal BypassReg_OUT  : std_logic:='0';

    constant clock_period : time := 10 ns; 
    
    SIGNAL TbSimEnded : BOOLEAN;

begin

    dut : BypassReg
    port map (reset          => reset,
              clock          => clock,
              TDI            => TDI,
              shiftDR        => shiftDR,
              ClockDR        => ClockDR,
              BypassReg_OUT  => BypassReg_OUT);


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
        
        TDI <= '0';
        shiftDR <= '0';
        ClockDR <= '0';

        -- Reset generation
       
        reset <= '1';
        wait for  5 * clock_period;
        reset <= '0';
        wait for 5 * clock_period;

        -- EDIT Add stimuli here
        wait for 5 * clock_period;

		        
                TDI <= '1';     --TDI
                ClockDR <= '1';
                shiftDR <= '1';     
            
		wait for 100 ns;
		
                
                TDI <= '1';     --TDI
                ClockDR <= '0';
                shiftDR <= '1';     
            
		wait for 100 ns;
		
		TDI <= '1';     --TDI
                ClockDR <= '1';
                shiftDR <= '0';     
            
		wait for 100 ns;
		
                
                TDI <= '1';     --TDI
                ClockDR <= '1';
                shiftDR <= '1';     
            
		wait for 100 ns;
		
		
		
		
        -- Stop the clock and terminate the simulation
        TbSimEnded <= true;
		
		
        wait;
    end process;

end tb;
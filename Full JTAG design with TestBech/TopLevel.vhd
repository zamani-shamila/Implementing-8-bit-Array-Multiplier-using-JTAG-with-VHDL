

library IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_ARITH.ALL;
USE IEEE.STD_LOGIC_UNSIGNED.ALL;
USE IEEE.NUMERIC_STD.ALL;


entity TopLevel is
    Port ( 
            TMS: IN std_logic;
	    Mode: IN std_logic;  
            TDO: OUT std_logic;
            Multiplier_in1:IN  STD_LOGIC_VECTOR (7 downto 0);
            Multiplier_in2:IN STD_LOGIC_VECTOR (7 downto 0);
            reset,clock: IN std_logic;
            TDI: IN std_logic;
            -- boundrySReg_out: OUT std_logic;
            Multiplier_out: OUT STD_LOGIC_VECTOR (15 downto 0)
           
           );
   end TopLevel;




   architecture Behavioral of TopLevel is
	-- BoundryScan Register
	
    SIGNAL ClockDR,shiftDR, UpdateDR, boundrySReg_out: std_logic;
    

    COMPONENT boundrySReg IS
        PORT(
            boundryScell_in1:IN  STD_LOGIC_VECTOR (7 downto 0);
            boundryScell_in2:IN STD_LOGIC_VECTOR (7 downto 0);
            ClockDR, UpdateDR:IN std_logic;
            shiftDR, Mode: IN std_logic;
            reset,clock: IN std_logic;
            TDI: IN std_logic;
            boundrySReg_out: OUT std_logic;
            boundryScell_out: OUT STD_LOGIC_VECTOR (15 downto 0)
           
        );
        
    END COMPONENT;



    -- Instruction Register

    SIGNAL DataBypasRegMux_OUT,ClockIR,ShiftIR, UpdateIR, IrCell2Decoder_Out_1,IrCell2Decoder_Out_2,IrCell2Decoder_Out_3,IrCell2Decoder_Out_4,IrCell_Out: std_logic;
    
    COMPONENT InstructionReg is
        Port (
            ClockIR, reset: IN std_logic; 
            TDI: IN std_logic;
            
            ShiftIR, UpdateIR: in std_logic;
            IrCell2Decoder_Out_1, IrCell2Decoder_out_2,IrCell2Decoder_out_3,IrCell2Decoder_out_4: out std_logic;
            IrCell_Out: out std_logic
        
         );
      end COMPONENT;

    --   Bypass Register
      
    SIGNAL BoundBypasRegMux_Select,BypassReg_OUT,BoundBypasRegMux_OUT,DataInstruRegMux_OUT : std_logic;
    
      
    COMPONENT BypassReg is
        Port ( 
            reset,clock: IN std_logic;
            TDI,shiftDR: IN std_logic;
            ClockDR: IN std_logic;
            BypassReg_OUT: OUT std_logic
        );
    end COMPONENT;

    -- TAP Ctrl
    
    SIGNAL Select_MUX : std_logic;

    COMPONENT TapCtrl IS
        Port (
            TMS: IN std_logic;
            TRST, TCK: IN std_logic; --TCK = Clk , --TRST = Reset
            ShiftIR, UpdateIR : out std_logic;
                
            Select_MUX: out std_logic;
            ClockDR, ShiftDR, UpdateDR: out std_logic
        );
    END COMPONENT;

    begin



        boundrySReg0:boundrySReg
            PORT Map(
                boundryScell_in1 => Multiplier_in1, 
                boundryScell_in2 => Multiplier_in2, 
                ClockDR => ClockDR, 
                UpdateDR => UpdateDR,
                shiftDR => shiftDR, 
                Mode => Mode,
                reset => reset ,
                clock => clock,
                TDI => TDI ,
                boundrySReg_out =>boundrySReg_out ,
                boundryScell_out => Multiplier_out
            
            );

        InstructionReg0 : InstructionReg 
            PORT Map(
                
                ClockIR => clock,
                reset => reset,
                TDI => TDI,
                
                ShiftIR =>ShiftIR, 
                UpdateIR =>UpdateIR,
                IrCell2Decoder_Out_1 =>IrCell2Decoder_out_1, 
                IrCell2Decoder_out_2 =>IrCell2Decoder_out_2,
                IrCell2Decoder_out_3 =>IrCell2Decoder_out_3,
                IrCell2Decoder_out_4=> IrCell2Decoder_out_4,
                IrCell_Out=>IrCell_Out
            
            );

        BypassReg0: BypassReg 
            PORT Map(
                reset  => reset,
                clock  => clock,
                TDI  => TDI,
                shiftDR => shiftDR,
                ClockDR  => ClockDR ,
                BypassReg_OUT =>  BypassReg_OUT

            );

        TapCtrl0: TapCtrl
            PORT Map(
                TMS => TMS,
                TRST=> reset, 
                TCK => clock, --TCK = ClOCk , --TRST = Reset
                ShiftIR =>ShiftIR, 
                UpdateIR =>UpdateIR,
                    
                Select_MUX => Select_MUX,
                ClockDR => ClockDR, 
                ShiftDR => shiftDR, 
                UpdateDR => UpdateDR
            );

            BoundBypasRegMux_Select <= not (IrCell2Decoder_out_1 and IrCell2Decoder_out_2 and IrCell2Decoder_out_3 and IrCell2Decoder_out_4);

            BoundBypasRegMux_OUT <=  boundrySReg_out when BoundBypasRegMux_Select ='1' else BypassReg_OUT ;

            DataInstruRegMux_OUT <= IrCell_Out when Select_MUX ='1' else BoundBypasRegMux_OUT;
            TDO <= DataInstruRegMux_OUT;




            -- process(reset,clock)
            --     begin   
            --         if (reset ='1')then 
            --             TDO <= '0';
            --         elsif (clock'event and clock='0') then 
            --             TDO <= DataInstruRegMux_OUT;
            --         end if;
            --     end process;
                



        --         shiftDR <= '0';       
        --     Mode <= '1';       
        --     ClockDR <= '1';     
        --     UpdateDR <= '0';    
        --     TDI <= '1';             
        --     wait for 32*clock_period;
        -- TDI <= '0';
        -- wait for 5*clock_period;
        -- TDI <= '1';
        --     Mode <= '1';       
        --     ClockDR <= '0';     
        --     UpdateDR <= '1';    
        --     wait for 5*clock_period;

       

	end Behavioral;

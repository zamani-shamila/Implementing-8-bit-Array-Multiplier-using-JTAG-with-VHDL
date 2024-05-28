

library IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_ARITH.ALL;
USE IEEE.STD_LOGIC_UNSIGNED.ALL;
USE IEEE.NUMERIC_STD.ALL;





ENTITY TapCtrl IS
  Port (
        TMS: IN std_logic;
        TRST, TCK: IN std_logic; --TCK = Clk , --TRST = Reset
        ShiftIR, UpdateIR : out std_logic;
        
		Select_MUX: out std_logic;
        ClockDR, ShiftDR, UpdateDR: out std_logic
   );
END TapCtrl;

architecture Behavioral of TapCtrl IS
    TYPE state_type IS (Test_Logic_Reset,
                        Run_Test_Idle,
                        Selec_DR_Scan, 
                        Capture_DR,
                        Shift_DR,
                        Exite1_DR, 
                        Pause_DR,
                        Exite2_DR,
                        Update_DR,
                        Select_IR_Scan, 
                        Capture_IR,
                        Shift_IR,
                        Exite1_IR,
                        Pause_IR,
                        Exite2_IR, 
                        Update_IR
    );
SIGNAL state_current, Next_State: state_type;







BEGIN
PROCESS (TCK, TRST)
BEGIN
    IF (TRST ='1') THEN
        --TMS= '1';
        state_current <=Test_Logic_Reset;
    elsif (TCK'event and TCK ='1')THEN
        state_current <= Next_State;    
   END IF;
   END PROCESS;
   


PROCESS(state_current, TMS)
BEGIN
    
   
   
  
    
   CASE (state_current) IS

    -------------------------------------  
        WHEN Test_Logic_Reset => 
            
          Select_MUX<='0';
            --------------
            ClockDR<='0';
            ShiftDR<='0'; 
            UpdateDR <='0';
            
            ShiftIR<='0'; 
            UpdateIR <='0';



            IF (TMS ='0')THEN 
                Next_State <= Run_Test_Idle;

            ELSE
                Next_State <= Test_Logic_Reset;
            END IF;
   -------------------------------------  
        WHEN Run_Test_Idle =>
            IF (TMS ='1') THEN
                Next_State <= Selec_DR_Scan;
            ELSE
                Next_State <= Run_Test_Idle;
            END IF;
    -------------------------------------  
    -- Data Register (DR):

        WHEN Selec_DR_Scan => 
		
			
            IF (TMS= '1') THEN
                Next_State <= Select_IR_Scan;
            ELSE
                Next_State <= Capture_DR;
            END IF;
    -------------------------------------  

        WHEN Capture_DR =>
            ClockDR <= '1';
            
            IF (TMS ='1') THEN 
                Next_State <= Exite1_DR;
            ELSE
                Next_State <= Shift_DR;
            END IF;

    -------------------------------------    
        WHEN Shift_DR =>
            ShiftDR <= '1';
            
            IF(TMS ='1') THEN 
                Next_State <= Exite1_DR;
            ELSE
                Next_State <= Shift_DR;
               
            END IF;
    -------------------------------------  

        WHEN Exite1_DR =>
            IF (TMS='1') THEN 
                Next_State <= Update_DR;
            ELSE
                Next_State <= Pause_DR;
            END IF;

   -------------------------------------  
        WHEN Pause_DR =>
            IF (TMS ='1') THEN 
                Next_State <= Exite2_DR;
            ELSE
                Next_State <= Pause_DR;
                    
            END IF;

   -------------------------------------  
        WHEN Exite2_DR =>
            IF (TMS ='1') THEN 
                Next_State <= Update_DR;
            ELSE 
                Next_State <= Shift_DR;
            END IF;
   
   -------------------------------------  
        WHEN Update_DR =>
            UpdateDR <= '1';
            IF (TMS ='1') THEN 
                Next_State <= Selec_DR_Scan;
            ELSE
                Next_State <= Run_Test_Idle;
            END IF;
   -------------------------------------  
   -------------------------------------  
   ------------------------------------- 
   -- Instruction Register (IR):
   
        WHEN Select_IR_Scan => 
	    Select_MUX<='1';
            IF (TMS ='1') THEN 
                Next_State <= Test_Logic_Reset;
            ELSE
                Next_State <= Capture_IR;
            END IF; 
   -------------------------------------  
        WHEN Capture_IR => 
            
            -- ClockIR <= '1'; or ShiftIR or UpdateIR
            ---??????????
            IF (TMS ='1') THEN
                Next_State <= Exite1_IR;
            ELSE
                Next_State <= Shift_IR;
            END IF;

   -------------------------------------  
        WHEN Shift_IR => 
            ShiftIR <= '1';
            
            IF(TMS='1') THEN 
                Next_State <= Exite1_IR;
            ELSE
                Next_State <= Shift_IR;
            
            END IF;
   -------------------------------------  
        WHEN Exite1_IR =>
            IF(TMS ='1') THEN 
                Next_State <= Update_IR;
            ELSE 
                Next_State <= Pause_IR;
            END IF ;

   ------------------------------------- 
        WHEN Pause_IR => 
            IF(TMS ='1') THEN 
                Next_State <= Exite2_IR;
            ELSE 
                Next_State <= Pause_IR;
            END IF;   
   ------------------------------------- 


        WHEN Exite2_IR =>
            IF (TMS='1') THEN 
                Next_State <= Update_IR;
            ELSE
                Next_State <= Shift_IR;
            END IF;

   ------------------------------------- 

     
        WHEN Update_IR =>
            UpdateIR <='1';
            
            IF(TMS ='1') THEN 
                Next_State <= Selec_DR_Scan;
            ELSE 
                Next_State <= Run_Test_Idle;
            END IF;

   ------------------------------------- 
   ------------------------------------- 
   ------------------------------------- 
    
                             
        END CASE;
        END PROCESS;
END Behavioral;
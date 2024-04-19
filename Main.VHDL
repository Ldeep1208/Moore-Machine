--Name: Lovedeep Singh
Library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.STD_LOGIC_unsigned.all;
---------------Entity-----------------------------------------------------------------------------------------------------------------------------------------------------
--External describtion of the I/O interface of the Traffic Light Design. 
Entity Traffic_Controller is                               
 port (clk: in STD_LOGIC;                                --Input signal that provides timing and synchronization 
       clr: in STD_LOGIC;                                --Input signal that reset the states to the initial state 
       west: out STD_LOGIC_VECTOR(2 downto 0);    --Output Traffic light on the West road
       east: out STD_LOGIC_VECTOR(2 downto 0);    --Output Traffic light on the East road
       north: out STD_LOGIC_VECTOR(2 downto 0));  --Output Traffic light on the North road
--(2 downto 0) Vector has 3 Entries utilied to represent the 3 Colours of the Traffic Lights 
end Traffic_Controller;
---------------Architecture-------------------------------------------------------------------------------------------------------------------------------------------------
architecture Behaviour of Traffic_Controller is
type state_type is (s0, s1, s2, s3);                     --Define data type (4 different status)
signal state: state_type;                                --Declare specified data type with a signal
signal count: STD_LOGIC_VECTOR(2 downto 0);              --Declare a Vector signal for the counter
constant delay: STD_LOGIC_VECTOR(2 downto 0) := "101";   --Delay of 5 counts 
--The period of the clock is 1 second, the system is delayed temporarily for 5 counts, means that the output will change every 5 seconds    
----------------Logic-------------------------------------------------------------------------------------------------------------------------------------------------------
begin
process(clk, clr)                                        --Sub routine where statements are executed sequentially
begin
 if clr = '1' then                                       --Reset to start the logic
 state <= s0;                                            --Signal state is equal to the define data s0
 count <= "001";                                         --Count start from 1
 elsif clk'event and clk = '1' then                      --Condition that the clock is 1
 case state is                                           --Signal state is equal to [Depend on the 4 defined output]
 
 when s0 =>                                              --When the defined output is s0
 if count < delay then                                   --Condition that the count is less than the value of the delay [count<5]
 state <= s0;                                            --Signal state is equal to the define data s0
 count <= count + 1;                                     --Count is increasing by 1 everytime that the clock is 1 
 else                                                    --If the condition is not met
 state <= s1;                                            --Signal state is equal to the define data s1
 count <= "001";                                         --Count is cleared to 1
 end if;                                                 --End the case
 
 when s1 =>                                              --When the defined output is s1
 if count < delay then                                   --Condition that the count is less than the value of the delay [count<5]
 state <= s1;                                            --Signal state is equal to the define data s1
 count <= count + 1;                                     --Count is increasing by 1 everytime that the clock is 1 
 else                                                    --If the condition is not met
 state <= s2;                                            --Signal state is equal to the define data s2
 count <= "001";                                         --Count is cleared to 1
 end if;                                                 --End the case
 
 when s2 =>                                              --When the defined output is s2
 if count < delay then                                   --Condition that the count is less than the value of the delay [count<5]
 state <= s2;                                            --Signal state is equal to the define data s2
 count <= count + 1;                                     --Count is increasing by 1 everytime that the clock is 1 
 else                                                    --If the condition is not met
 state <= s3;                                            --Signal state is equal to the define data s3
 count <= "001";                                         --Count is cleared to 1
 end if;                                                 --End the case
 
 when s3 =>                                              --When the defined output is s3
 if count < delay then                                   --Condition that the count is less than the value of the delay [count<5]
 state <= s3;                                            --Signal state is equal to the define data s3
 count <= count + 1;                                     --Count is increasing by 1 everytime that the clock is 1
 else                                                    --If the condition is not met
 state <= s0;                                            --Signal state is equal to the define data s0
 count <= "001";                                         --Count is cleared to 1
 end if;                                                 --End the case
 
 when others =>                                          --When the defined output is in any another state
 state <= s0;                                            --Signal state is equal to the define data s0
 end case;                                               
 end if;
 end process;                                            --End of the logic
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
C2: process(state)                                       --Value the defined data with the equivalent light of traffic light 
 begin
 case state is 
 --In a Traffic light the lights are positionated from top to bottom in this sequence Red,Yellow and Green
 --The Most Significant Bit is the light Red, the bit in the middle is Yellow and the Lest Significant Bit is Green
 --When the bit is 0 the light is OFF, When the bit is 1 the light is ON
  when s0 => --------------------------------------------During stage s0 
   North <= "001";                                --North is GREEN
   West  <= "100";                                --West  is RED
   East  <= "100";                                --East  is RED
  when s1 => --------------------------------------------During stage s1
   North <= "010";                                --North is YELLOW
   West  <= "110";                                --West  is RED and YELLOW 
   East  <= "110";                                --East  is RED and YELLOW 
  when s2 => --------------------------------------------During stage s2
   North <= "100";                                --North is RED
   West  <= "001";                                --West  is GREEN
   East  <= "001";                                --East  is GREEN
  when s3 => --------------------------------------------During stage s3
   North <= "110";                                --North is RED and YELLOW          
   West  <= "010";                                --West  is YELLOW
   East  <= "010";                                --East  is YELLOW
  when others => --------------------------------------------During any other stage [in case there is a fault all light will be red to avoid accidents]
   North <= "100";                                --North is RED  
   West  <= "100";                                --Wesr  is RED
   East  <= "100";                                --East  is RED
 end case;
 end process;
 end Behaviour;                                          --End of the logic

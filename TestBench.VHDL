--Name: Lovedeep Singh
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity TL_SYSTEM_TB is
end TL_SYSTEM_TB;

architecture behavior of TL_SYSTEM_TB is 
    component TL_SYSTEM is
        port (
            clk: in STD_LOGIC;
            clr: in STD_LOGIC;
            HL_lights: out STD_LOGIC_VECTOR(2 downto 0);
            HR_lights: out STD_LOGIC_VECTOR(2 downto 0);
            V_lights: out STD_LOGIC_VECTOR(2 downto 0)
        );
    end component;

    signal clk: STD_LOGIC := '0';
    signal clr: STD_LOGIC := '0';
    signal HL_lights: STD_LOGIC_VECTOR(2 downto 0);
    signal HR_lights: STD_LOGIC_VECTOR(2 downto 0);
    signal V_lights: STD_LOGIC_VECTOR(2 downto 0);

    constant clk_period : time := 10 ns;

begin
    uut: TL_SYSTEM port map (
        clk => clk,
        clr => clr,
        HL_lights => HL_lights,
        HR_lights => HR_lights,
        V_lights => V_lights
    );

    clk_process :process
    begin
        clk <= '0';
        wait for clk_period/2;
        clk <= '1';
        wait for clk_period/2;
    end process;

    stim_proc: process
    begin
        wait for clk_period;
        clr <= '1';
        wait for clk_period;
        clr <= '0';
        wait;
    end process;

end behavior;

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity full_system is
    port(
        start : in std_logic;
        clk_a : in std_logic;
        clk_b : in std_logic;
        data_out: out std_logic_vector(5 downto 0)
    );
end full_system;

architecture structural of full_system is
    signal rts, cts: std_logic;
    signal data : std_logic_vector(3 downto 0);
    
begin
    A: entity work.unitA(structural)
        port map(
            clk_a => clk_a, start => start,
            rts => rts, cts => cts, data => data
            );
    B: entity work.unitB(structural)
        port map(
            clk_b => clk_b, rts => rts, cts => cts,
            data => data, output => data_out
            );
end structural;

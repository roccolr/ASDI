library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity unitA is
    port (
        clk_a : in std_logic;
        start : in std_logic;
        rts : out std_logic;
        cts : in std_logic;
        -- done: in std_logic;
        data : out std_logic_vector(3 downto 0)
    );
end unitA;

architecture structural of unitA is
    signal addr : std_logic_vector(2 downto 0);
    signal en, tk, rd, rst: std_logic;
begin
    cont: entity work.contatore_mod_8(behavioral)
        port map(
            en => en, clk_a => clk_a, rst => rst, addr => addr, tk => tk
            );
    
    rom: entity work.ROM_8_4(behavioral)
        port map(
            clk_a => clk_a, rd => rd, addr => addr, data => data
            );
 
    cu: entity work.cuA(behavioral)
        port map(
            clk_a => clk_a, rst => rst, en => en, rd => rd,
            start => start, tk => tk, rts => rts, cts => cts
            );

end structural;

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity interconn16_4 is
    port(
        x: in std_logic_vector(0 to 15);
        s_i: in std_logic_vector(3 downto 0);
        s_o: in std_logic_vector(1 downto 0);
        y: out std_logic_vector(0 to 3)
    );
end interconn16_4;

architecture structural of interconn16_4 is
    signal q: std_logic := '0';
begin
    MUX:    entity work.mux_16_1 port map(a => x, s => s_i, y => q); 
    DEMUX:  entity work.demux_1_4 port map(a => q, s => s_o, y => y);
    
end structural;

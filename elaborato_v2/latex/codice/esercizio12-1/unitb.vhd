library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity unitB is
    port(
        clk_b : in std_logic;
        rts : in std_logic;
        cts: out std_logic;
        --done: out std_logic;
        data: in std_logic_vector(3 downto 0);
        output: out std_logic_vector(5 downto 0)
    );
end unitB;

architecture structural of unitB is
    signal load : std_logic;
    signal data_out, sum, ext_data: std_logic_vector(5 downto 0);
begin
    ext_data <= "00" & data;
    R: entity work.registro_6(behavioral)
        port map(
            clk_b => clk_b, rst => '0', data_out => data_out,
            sum => sum, load => load
            );
    
    CarryLA: entity work.CLA(dataflow)
        port map(
            x => ext_data, y => data_out, s => sum, c_out => open,
            c0 => '0'
            );
            
    cu: entity work.cuB(behavioral)
        port map(
            clk_b => clk_b, load=> load, rts => rts, cts => cts
            );
    output <= data_out;
end structural;

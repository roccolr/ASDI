library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity demux1_2 is
    port(
        z : in std_logic_vector(1 downto 0);
        y0: out std_logic_vector(1 downto 0);
        y1: out std_logic_vector(1 downto 0);
        s : in std_logic
        );
end demux1_2;

architecture dataflow of demux1_2 is

begin
    y0 <= z when s = '0' else "00"; 
    y1 <= z when s = '1' else "00"; 
end dataflow;

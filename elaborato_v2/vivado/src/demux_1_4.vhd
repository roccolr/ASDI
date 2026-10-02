library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity demux_1_4 is
    port(
        a : in std_logic;
        s : in std_logic_vector(1 downto 0);
        y : out std_logic_vector(0 to 3)
        );
end demux_1_4;

architecture dataflow of demux_1_4 is
    
begin
    y(0) <= a when s = "00" else '0';
    y(1) <= a when s = "01" else '0';
    y(2) <= a when s = "10" else '0';
    y(3) <= a when s = "11" else '0';

end dataflow;

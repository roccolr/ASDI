library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity switch2_2 is
    port(
        x0 : in std_logic_vector(1 downto 0);
        x1 : in std_logic_vector(1 downto 0);
        y0 : out std_logic_vector(1 downto 0);
        y1 : out std_logic_vector(1 downto 0);
        s: in std_logic_vector(1 downto 0)
    );
end switch2_2;

architecture structural of switch2_2 is
    signal z : std_logic_vector(1 downto 0);
begin
    mux: entity work.mux2_1(dataflow)
        port map(
            x0 => x0, x1 => x1, 
            z => z, s => s(0)
            );
    
    demux: entity work.demux1_2(dataflow)
        port map(
            z => z, y0 => y0,
            y1 => y1, s => s(1)
        );

end structural;

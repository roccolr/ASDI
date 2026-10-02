library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity booth_tl is
    port(
        CLK100MHZ : in std_logic;
        SW : in std_logic_vector(15 downto 0); -- x 15-8, y 7-0
        BTNC : in std_logic; -- start
        BTND : in std_logic; --reset
        LED : out std_logic_vector(15 downto 0);
        LED16_G : out stD_logic -- done
    );
end booth_tl;

architecture structural of booth_tl is


begin
    Mbooth: entity work.booth(structural)
        port map( clk => CLK100MHZ, rst => BTND, start => BTNC, 
                x => SW(15 downto 8), y => SW(7 downto 0),
                p => LED, done => LED16_G);

end structural;

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity sistema_tl is
    port (
        CLK100MHZ : in std_logic;
        SW : in std_logic_vector(15 downto 0);
        BTNC: in std_logic; -- read (1 step)
        BTND: in std_logic; -- reset
        LED : out std_logic_vector(15 downto 0)
    );
end sistema_tl;

architecture structural of sistema_tl is
    signal rst, step_p : std_logic;
begin
    rst <= BTND;
    
    deb: entity work.debouncer(Behavioral)
        port map (clk => CLK100MHZ, rst => rst, button => BTNC, button_fix => step_p);
    
    sys: entity work.sistema(structural)
        generic map(N => 16, a => 4)
        port map   (clk => CLK100MHZ, rst => rst,
                    start => SW(15),
                    step => step_p,
                    done => LED(7),
                    raddr => SW(3 downto 0),
                    dout => LED(3 downto 0),
                    addr_dbg => LED(15 downto 12),
                    m_dbg => LED(11 downto 8)
                    );
    LED(6 downto 4) <= "000";
end structural;

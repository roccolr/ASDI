library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity omega_network_4 is
    port (
        x1 : in std_logic_vector(1 downto 0);
        x2 : in std_logic_vector(1 downto 0);
        x3 : in std_logic_vector(1 downto 0);
        x4 : in std_logic_vector(1 downto 0);
        y1 : out std_logic_vector(1 downto 0);
        y2 : out std_logic_vector(1 downto 0);
        y3 : out std_logic_vector(1 downto 0);
        y4 : out std_logic_vector(1 downto 0);
        s_src: in std_logic_vector(1 downto 0);
        s_dst:  in std_logic_vector(1 downto 0)
    );
end omega_network_4;

architecture structural of omega_network_4 is
    signal l1 : std_logic_vector(1 downto 0);
    signal l2 : std_logic_vector(1 downto 0);
    signal l3 : std_logic_vector(1 downto 0);
    signal l4 : std_logic_vector(1 downto 0);

begin
    omega1: entity work.switch2_2(structural)
        -- s0 -> seleziona il mux, s1 -> seleziona il dmux
        port map(
            x0 => x1, x1 => x3, 
            y0 => l1, y1 => l2,
            s(0) => s_src(1), s(1) => s_dst(1)
            );
             
    omega2: entity work.switch2_2(structural)
        port map(
            x0 => x2, x1 => x4, 
            y0 => l3, y1 => l4,
            s(0) => s_src(1), s(1) => s_dst(1)
            );
    omega3: entity work.switch2_2(structural)
        port map(
            x0 => l1, x1 => l3, 
            y0 => y1, y1 => y2,
            s(0) => s_src(0), s(1) => s_dst(0)
            );
    
    omega4: entity work.switch2_2(structural)
        port map(
            x0 => l2, x1 => l4, 
            y0 => y3, y1 => y4,
            s(0) => s_src(0), s(1) => s_dst(0)
            );
            
        

end structural;

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity omega_network_4_tb is
end omega_network_4_tb;

architecture bench of omega_network_4_tb is
    signal x1, x2, x3, x4 : std_logic_vector(1 downto 0);
    signal y1, y2, y3, y4 : std_logic_vector(1 downto 0);
    signal s_src, s_dst   : std_logic_vector(1 downto 0);
begin

    dut : entity work.omega_network_4(structural)
        port map (x1 => x1, x2 => x2, x3 => x3, x4 => x4,
                  y1 => y1, y2 => y2, y3 => y3, y4 => y4,
                  s_src => s_src, s_dst => s_dst);

    stim : process
    begin
        x1 <= "01";
        x2 <= "11";
        x3 <= "10";
        x4 <= "01";

        -- nodo 1 -> nodo 4
        s_src <= "00"; s_dst <= "11";
        wait for 10 ns;
        assert y4 = "01" report "nodo 1 -> nodo 4 fallito" severity error;
        assert y1 = "00" report "nodo 1 -> nodo 4: dato spurio su y1" severity error;

        -- nodo 3 -> nodo 2
        s_src <= "10"; s_dst <= "01";
        wait for 10 ns;
        assert y2 = "10" report "nodo 3 -> nodo 2 fallito" severity error;

        -- nodo 2 -> nodo 3
        s_src <= "01"; s_dst <= "10";
        wait for 10 ns;
        assert y3 = "11" report "nodo 2 -> nodo 3 fallito" severity error;

        -- nodo 4 -> nodo 1
        s_src <= "11"; s_dst <= "00";
        wait for 10 ns;
        assert y1 = "01" report "nodo 4 -> nodo 1 fallito" severity error;

        report "Fine test" severity note;
        wait;
    end process;

end bench;
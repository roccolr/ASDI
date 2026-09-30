library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity booth_tb is
end booth_tb;

architecture bench of booth_tb is

    constant T : time := 10 ns;

    signal clk   : std_logic := '0';
    signal rst   : std_logic := '1';
    signal start : std_logic := '0';
    signal x, y  : std_logic_vector(7 downto 0) := (others => '0');
    signal p     : std_logic_vector(15 downto 0);
    signal done  : std_logic;

begin

    dut : entity work.booth(structural)
        port map (clk => clk, rst => rst, start => start,
                  x => x, y => y, p => p, done => done);

    clk_proc : process
    begin
        clk <= '0'; wait for T/2;
        clk <= '1'; wait for T/2;
    end process;

    stim : process
    begin
        rst <= '1'; wait for 2*T;
        rst <= '0'; wait for T;

        -- (-7) * 13 = -91
        x <= std_logic_vector(to_signed(-7, 8));
        y <= std_logic_vector(to_signed(13, 8));
        start <= '1';

        wait until done = '1';
        assert p = std_logic_vector(to_signed(-91, 16))
            report "Prodotto errato: " & integer'image(to_integer(signed(p)))
            severity error;
        report "Prodotto calcolato: " & integer'image(to_integer(signed(p)))
            severity note;

        start <= '0';
        wait for 2*T;
        wait;
    end process;

end bench;
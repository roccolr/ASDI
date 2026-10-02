library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity full_system_tb is
end full_system_tb;

architecture bench of full_system_tb is
    constant TA : time := 10 ns;   -- periodo clk_a
    constant TB : time := 14 ns;   -- periodo clk_b (diverso da TA)

    signal clk_a    : std_logic := '0';
    signal clk_b    : std_logic := '0';
    signal start    : std_logic := '0';
    signal data_out : std_logic_vector(5 downto 0);
begin

    dut : entity work.full_system(structural)
        port map (start => start, clk_a => clk_a, clk_b => clk_b,
                  data_out => data_out);

    clk_a_proc : process
    begin
        clk_a <= '0'; wait for TA/2;
        clk_a <= '1'; wait for TA/2;
    end process;

    clk_b_proc : process
    begin
        clk_b <= '0'; wait for TB/2;
        clk_b <= '1'; wait for TB/2;
    end process;

    stim : process
    begin
        start <= '0';
        wait for 3*TA;

        start <= '1';
        wait for 2 us;              -- tempo abbondante per 8 trasferimenti

        -- somma attesa: 0+1+2+3+4+5+6+7 = 28
        assert data_out = std_logic_vector(to_unsigned(28, 6))
            report "Somma errata: " & integer'image(to_integer(unsigned(data_out)))
            severity error;
        report "Somma in B: " & integer'image(to_integer(unsigned(data_out)))
            severity note;

        start <= '0';
        wait;
    end process;

end bench;
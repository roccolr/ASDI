library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

-- Durata simulazione: 10 ms 

entity macro_system_tb is
end macro_system_tb;

architecture Behavioral of macro_system_tb is
    signal start : std_logic := '0';
    signal addr  : std_logic_vector(2 downto 0) := "000";
    signal data  : std_logic_vector(7 downto 0);
    signal clk   : std_logic := '0';
    signal rst   : std_logic := '1';
    constant T   : time := 10 ns;

    -- contenuto atteso: deve coincidere con la ROM di A
    type rom_t is array(0 to 7) of std_logic_vector(7 downto 0);
    constant EXPECTED : rom_t := (
        x"00", x"FF", x"01", x"80",
        x"0F", x"F0", x"AA", x"55"
    );
begin
    dut: entity work.marco_system(structural)
        port map(
            clk => clk, rst => rst, start => start, addr => addr,
            data => data
            );

    clock: process
    begin
        clk <= '0'; wait for T/2;
        clk <= '1'; wait for T/2;
    end process;

    stim: process
        variable errors : integer := 0;
    begin
        -- reset
        rst <= '1';
        wait for 5*T;
        rst <= '0';
        wait for 2*T;

        -- 8 trasferimenti: un impulso di start per byte,
        -- poi si attende la fine del frame seriale (~0.7 ms)
        for i in 0 to 7 loop
            start <= '1';
            wait for T;
            start <= '0';
            wait for 1 ms;
        end loop;

        -- verifica del contenuto della MEM di B
        for i in 0 to 7 loop
            addr <= std_logic_vector(to_unsigned(i, addr'length));
            wait for T;
            if data /= EXPECTED(i) then
                errors := errors + 1;
            end if;
            assert data = EXPECTED(i)
                report "MEM(" & integer'image(i) & ") = "
                       & integer'image(to_integer(unsigned(data)))
                       & ", atteso " & integer'image(to_integer(unsigned(EXPECTED(i))))
                severity error;
        end loop;

        if errors = 0 then
            report "TEST SUPERATO: MEM = ROM" severity note;
        else
            report "TEST FALLITO: " & integer'image(errors) & " errori" severity error;
        end if;

        wait;
    end process;
end Behavioral;
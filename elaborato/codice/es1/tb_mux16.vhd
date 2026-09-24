library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

-- Testbench esaustivo del mux 16:1: per ogni selezione si applica
-- un pattern "one-hot" e il suo complemento, e si verifica l'uscita.
entity tb_mux16 is
end entity;

architecture sim of tb_mux16 is
    signal d : std_logic_vector(15 downto 0) := (others => '0');
    signal s : std_logic_vector(3 downto 0)  := (others => '0');
    signal y : std_logic;
begin
    dut : entity work.mux16
        port map (d => d, s => s, y => y);

    stim : process
        variable errori : natural := 0;
    begin
        for sel in 0 to 15 loop
            s <= std_logic_vector(to_unsigned(sel, 4));

            -- solo l'ingresso selezionato vale 1: y deve valere 1
            d <= (others => '0');
            d(sel) <= '1';
            wait for 10 ns;
            if y /= '1' then
                errori := errori + 1;
                report "Errore con s = " & integer'image(sel) & ", pattern one-hot" severity error;
            end if;

            -- solo l'ingresso selezionato vale 0: y deve valere 0
            d <= (others => '1');
            d(sel) <= '0';
            wait for 10 ns;
            if y /= '0' then
                errori := errori + 1;
                report "Errore con s = " & integer'image(sel) & ", pattern complementato" severity error;
            end if;
        end loop;

        report "Simulazione terminata con " & integer'image(errori) & " errori" severity note;
        wait;
    end process;
end architecture;

library ieee;
use ieee.std_logic_1164.all;

-- Multiplexer 16:1 ottenuto per composizione di cinque mux 4:1 su due livelli
entity mux16 is
    port (
        d : in  std_logic_vector(15 downto 0);  -- ingressi dati
        s : in  std_logic_vector(3 downto 0);   -- selezione
        y : out std_logic
    );
end entity;

architecture structural of mux16 is
    signal y_lvl1 : std_logic_vector(3 downto 0);  -- uscite del primo livello
begin
    -- Primo livello: un mux 4:1 per ogni gruppo di 4 ingressi, selezionato da s(1..0)
    gen_lvl1 : for i in 0 to 3 generate
        mux_i : entity work.mux4
            port map (
                d => d(4*i + 3 downto 4*i),
                s => s(1 downto 0),
                y => y_lvl1(i)
            );
    end generate;

    -- Secondo livello: sceglie il gruppo, selezionato da s(3..2)
    mux_out : entity work.mux4
        port map (
            d => y_lvl1,
            s => s(3 downto 2),
            y => y
        );
end architecture;

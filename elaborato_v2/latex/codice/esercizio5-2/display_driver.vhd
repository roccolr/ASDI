library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity display_driver is
    generic ( N_REFRESH : positive := 100_000 );       -- 1 ms a 100 MHz
    port (
        clk, rst : in  std_logic;
        ore_d, ore_u : in  std_logic_vector(3 downto 0);
        min_d, min_u : in  std_logic_vector(3 downto 0);
        sec_d, sec_u : in  std_logic_vector(3 downto 0);
        seg : out std_logic_vector(6 downto 0);         -- "gfedcba", attivo basso
        dp  : out std_logic;                            -- attivo basso
        an  : out std_logic_vector(7 downto 0)          -- attivo basso
    );
end display_driver;

architecture structural of display_driver is
    constant ZERO17 : std_logic_vector(16 downto 0) := (others => '0');
    constant ZERO3  : std_logic_vector(2 downto 0)  := (others => '0');
    signal tick  : std_logic;
    signal sel   : std_logic_vector(2 downto 0);
    signal cifra : std_logic_vector(3 downto 0);
begin

    --  tick di refresh -> un impulso ogni N_REFRESH cicli
    refresh : entity work.counter_mod(behavioral)
        generic map (M => N_REFRESH, W => 17)
        port map (clk => clk, rst => rst, en => '1', load => '0',
                  d => ZERO17, q => open, tc => tick);

    --  contatore di cifra: 0..5, ogni tick avanza di cifra
    sel_cnt : entity work.counter_mod(behavioral)
        generic map (M => 6, W => 3)
        port map (clk => clk, rst => rst, en => tick, load => '0',
                  d => ZERO3, q => sel, tc => open);

    --  multiplexer: cifra, punto e anodo per ogni valore di sel
    mux : process(sel, ore_d, ore_u, min_d, min_u, sec_d, sec_u)
    begin
        case sel is
            when "000" => cifra <= sec_u; dp <= '1'; an <= "11111110";
            when "001" => cifra <= sec_d; dp <= '1'; an <= "11111101";
            when "010" => cifra <= min_u; dp <= '0'; an <= "11111011";
            when "011" => cifra <= min_d; dp <= '1'; an <= "11110111";
            when "100" => cifra <= ore_u; dp <= '0'; an <= "11101111";
            when "101" => cifra <= ore_d; dp <= '1'; an <= "11011111";
            when others => cifra <= "1111"; dp <= '1'; an <= "11111111";
        end case;
    end process;

    --  un solo decoder, per la cifra selezionata
    dec : entity work.seg7_decoder(dataflow)
        port map (cifra => cifra, seg => seg);

end structural;
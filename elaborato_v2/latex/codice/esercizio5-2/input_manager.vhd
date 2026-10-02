library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity input_manager is
    port(
        clk : in std_logic;
        rst : in std_logic;
        load : in std_logic; -- 2 b debounced
        sw : in std_logic_vector(5 downto 0); -- 6 bit con cui inserire ore, minuti e secondi (uno per volta)
        h_in : out std_logic_vector(4 downto 0);
        m_in : out std_logic_vector(5 downto 0);
        s_in : out std_logic_vector(5 downto 0);
        set : out std_logic; -- carica in una volta tutto il cronometro
        campo: out std_logic_vector(2 downto 0) -- per i led 
    );
end input_manager;

architecture behavioral of input_manager is

    type stato is (ORE, MINUTI, SECONDI);
    signal current_state : stato;
    
    signal h_reg : std_logic_vector(4 downto 0);
    signal m_reg : std_logic_vector(5 downto 0);
    signal s_reg : std_logic_vector(5 downto 0);
    
begin
    process(clk)
    begin
        
        if clk'event and clk = '1' then
            set <= '0';
            if rst = '1' then
                current_state <= ORE;
                h_reg <= (others => '0');
                m_reg <= (others => '0');
                s_reg <= (others => '0');
            elsif load = '1' then
                case current_state is 
                    when ORE => 
                        h_reg <= sw(4 downto 0);
                        current_state <= MINUTI;
                    when MINUTI => 
                        m_reg <= sw;
                        current_state <= SECONDI;
                    when SECONDI =>
                        s_reg <= sw;
                        set <= '1';
                        current_state <= ORE;
                    end case;
            end if;
        end if;
    end process;
    
    -- 3 segnali di uscita leggono i registri al prossimo ciclo
    h_in <= h_reg;
    m_in <= m_reg;
    s_in <= s_reg;
    
    campo <= "100" when current_state = ORE else
             "010" when current_state = MINUTI else
             "001";
        
end Behavioral;

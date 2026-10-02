library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity fsm_sequence_tl is
    port(
        CLK100MHZ  : in  std_logic;
        CPU_RESETN : in  std_logic;                      -- attivo basso
        SW         : in  std_logic_vector(1 downto 0);   -- SW0 = i, SW1 = M
        BTNL       : in  std_logic;                      -- B1: acquisisci i
        BTNR       : in  std_logic;                      -- B2: acquisisci M
        LED        : out std_logic_vector(2 downto 0)
    );
end fsm_sequence_tl;

architecture structural of fsm_sequence_tl is
    signal rst : std_logic;
    signal load_next : std_logic; 
    signal change_m : std_logic;
    signal bit_i : std_logic;
    signal mode_m : std_logic;
    signal step: std_logic; -- la fsm avanza
    signal y_fsm : std_logic;
    signal y_reg : std_logic := '0';
    
begin
    rst <= not CPU_RESETN;

    u_db_i: entity work.debouncer(Behavioral) -- debouncer per il caricamento del bit i-esimo
        port map (clk => CLK100MHZ, rst => rst, button => BTNL, button_fix => load_next);
    u_db_m: entity work.debouncer(Behavioral)
        port map (clk => CLK100MHZ, rst => rst, button => BTNR, button_fix => change_m);
    
    u_in: entity work.input_manager(Behavioral) 
        port map   (clk => CLK100MHZ, input => SW,
                    change_m => change_m, load_next => load_next,
                    detect_input => bit_i, detect_m => mode_m, detect_en => step 
                    );
    
    u_fsm: entity work.fsm_sequence(Behavioral)
        port map   (i => bit_i, m => mode_m, a => CLK100MHZ,
                    rst => rst, en => step, y => y_fsm
                    );
    
    -- registro su Y: tiene il risultato dell'ultimo bit acquisito
    reg_y : process (CLK100MHZ)
    begin
        if CLK100MHZ'event and CLK100MHZ = '1' then
            if rst = '1' then
                y_reg <= '0';
            elsif step = '1' then
                y_reg <= y_fsm;
            end if;
        end if;
    end process;
    
    LED(0) <= y_reg; -- sequenza riconosciuta
    LED(1) <= bit_i; -- ultimo bit acquisito 
    LED(2) <= mode_m; -- modo attuale
    
end structural;

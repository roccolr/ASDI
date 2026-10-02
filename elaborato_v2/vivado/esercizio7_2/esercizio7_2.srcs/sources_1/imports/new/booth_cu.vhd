library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity booth_cu is
    port(
        clk : in std_logic;
        rst : in std_logic;
        start: in std_logic;
        
        q0 : in std_logic;
        qm1 : in std_logic;
        last : in std_logic;
        
        load_mq : out std_logic;
        load_a : out std_logic;
        sub : out std_logic;
        shift: out std_logic;
        cnt_en : out std_logic;
        cnt_rst: out std_logic;
        
        done: out std_logic
    );
end booth_cu;

architecture behavioral of booth_cu is
    type stato is (S_IDLE, S_INIT, S_ADD, S_SHIFT, S_DONE);
    signal stato_corrente, stato_prossimo : stato;
begin
    f_controllo : process (stato_corrente, start, q0, qm1, last)
    begin
        stato_prossimo <= stato_corrente;
        load_mq <= '0';
        load_a <= '0';
        sub <= '0';
        shift <= '0';
        cnt_en <= '0';
        cnt_rst <= '0';
        done <= '0';
        
        case stato_corrente is
            
            when S_IDLE => 
                if start = '1' then
                    stato_prossimo <= S_INIT;
                end if;
                
            when S_INIT => 
                load_mq <= '1';
                cnt_rst <= '1';
                stato_prossimo <= S_ADD;
                
            when S_ADD =>
                if q0 = '1' and qm1 = '0' then
                    load_a <= '1';
                    sub <= '1';
                elsif q0 = '0' and qm1 = '1' then
                    load_a <= '1';
                end if; -- 00 e 11 non fa nulla, resta com'è
                stato_prossimo <= S_SHIFT;
            
            when S_SHIFT => 
                shift <= '1';
                cnt_en <= '1';
                if last = '1' then
                    stato_prossimo <= S_DONE;
                else 
                    stato_prossimo <= S_ADD;
                end if;
                
            when S_DONE =>
                done <= '1';
                if start = '0' then
                    stato_prossimo <= S_IDLE;
                end if;
            end case;
        end process;
        
        mem_stato : process(clk)
        begin 
            if clk'event and clk = '1' then
                if rst = '1' then 
                    stato_corrente <= S_IDLE;
                else 
                    stato_corrente <= stato_prossimo;
                end if;
            end if;
        end process;     
end behavioral;

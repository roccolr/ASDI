library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
--use IEEE.NUMERIC_STD.ALL;

entity control_unit is
    port(
        clk : in std_logic;
        rst : in std_logic;
        start : in std_logic;
        tc : in std_logic; -- <- contatore
        rd : out std_logic; -- -> rom 
        we : out std_logic; -- -> mem
        cnt_en : out std_logic; -- -> contatore
        done: out std_logic -- -> esteno
    );
end control_unit;

architecture behavioral of control_unit is
    type stato is (S_IDLE, S_READ, S_WRITE, S_DONE);
    signal stato_corrente, stato_prossimo : stato;
begin
    f_controllo: process(stato_corrente, start, tc)
    begin
        -- default
        stato_prossimo <= stato_corrente;
        rd <= '0';
        we <= '0';
        cnt_en <= '0';
        done <= '0';
        
        case stato_corrente is 
            
            when S_IDLE =>
                if start = '1' then 
                    stato_prossimo <= S_READ;
                end if;
                
            when S_READ =>
                rd <= '1';
                stato_prossimo <= S_WRITE;
           
            when S_WRITE =>
                we <= '1';
                cnt_en <= '1';
                -- abbiamo scritto, quindi avanziamo
                if tc = '1' then 
                    stato_prossimo <= S_DONE;
                else 
                    stato_prossimo <= S_READ;
                end if;
           
            when S_DONE =>
                done <= '1';
                if start = '0' then
                    stato_prossimo <= S_IDLE;
                end if;
            
            end case;
        end process;
    
    mem_stato: process(clk)
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

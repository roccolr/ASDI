library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity cuB is
    port(
        clk : in std_logic;
        rst : in std_logic;
        
        -- contatore
        en : out std_logic;
        
        -- UART
        rts : in std_logic;
        rda: in std_logic;
        cts : out std_logic;
        rd : out std_logic;
        
        -- MEM
        memw: out std_logic
    );
end cuB;

architecture Behavioral of cuB is
    type stato is (LISTEN, ACCEPT, MEM);
    signal current_state, next_state : stato;
begin
    f_stato_uscita: process(current_state, rda, rts)
    begin
        cts <= '0';
        next_state <= current_state;
        memw <= '0';
        rd <= '0';
        en <= '0';
        
        case current_state is 
            when LISTEN =>
                if rts = '1' then
                    next_state <= ACCEPT;
                    cts <= '1';
                end if;
           
            when ACCEPT => 
                cts <= '1';
                if rda = '1' then
                    next_state <= MEM;
                    -- rd <= '1'; AZZERA RDA!!
                    --memw <= '1';
                end if;
            
            when MEM =>
                memw <= '1';
                rd <= '1';
                en <= '1';
                next_state <= LISTEN;
            
            end case;
    end process;
                
    mem_proc: process(clk)
    begin 
        if clk'event and clk = '1' then
            if rst = '1' then
                current_state <= LISTEN;
            else 
                current_state <= next_state;
            end if;
        end if;
    end process;
                    
end Behavioral;

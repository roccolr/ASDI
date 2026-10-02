library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.numeric_std.ALL;

entity debouncer is
    generic (
        clk_period : integer := 10; --ns 
        noise_duration : integer := 10000000 -- ns
    );
    port (
        clk : in std_logic;
        rst : in std_logic;
        button : in std_logic;
        button_fix : out std_logic        
    );
end debouncer;

architecture Behavioral of debouncer is
    type stato is (IDLE, PULSE, LOCK);
    signal next_state, current_state : stato;
    constant max_count : integer := noise_duration/clk_period;
    signal count : unsigned(19 downto 0);
    
    
begin
    f_stato_uscita: process(count, current_state, button)
    begin 
        next_state <= current_state;
        button_fix <= '0';
        
        case current_state is 
            when IDLE =>
                if button = '1' then
                    next_state <= PULSE;
                end if;
                
            when PULSE =>
                next_state <= LOCK;
                button_fix <= '1';
            
            when LOCK =>
                if button = '0' and count = max_count - 1 then
                    next_state <= IDLE;
                end if;
            end case;
    end process;
    
    mem : process(clk)
    begin
        if clk'event and clk = '1' then
            if rst = '1' then
                current_state <= IDLE;
                count <= (others => '0');
            else 
                current_state <= next_state;
                if current_state = LOCK and button = '0' then
                    count <= count + 1;
                else 
                    count <= (others => '0');
                end if;
            end if;
        end if;
    end process;
end Behavioral;

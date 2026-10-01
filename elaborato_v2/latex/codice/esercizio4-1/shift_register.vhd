library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity shift_register is
    generic(
        N: positive := 8
    );
    port(
        clk: in std_logic;
        rst: in std_logic; -- reset sincrono
        load: in std_logic; -- 1 -> parallel load
        en: in std_logic; -- shift (<< aut >>)
        dir: in std_logic; -- 0 >>, 1 <<
        pos: in std_logic; -- 0 -> 1 pos, 1 -> 2 pos
        d: in std_logic_vector(N-1 downto 0); -- data 2 be load
        q: out std_logic_vector(N-1 downto 0) -- content
    );
end shift_register;

architecture Behavioral of shift_register is
    signal r: std_logic_vector(N-1 downto 0);
begin
    assert N >=2
        report "shift register: N deve essere maggiore di 2"
        severity failure;
    process (clk)
    begin
        if clk'event and clk = '1' then 
            if rst = '1' then 
                r <= (others => '0');
            elsif load = '1' then
                r <= d;
            elsif en = '1' then
                if dir = '0' then
                    if pos = '0' then
                        r <= '0' & r(N-1 downto 1);
                    else 
                        r <= "00" & r(N-1 downto 2);
                    end if;
                else 
                    if pos = '0' then
                        r <= r(N-2 downto 0) & '0';
                    else 
                        r <=  r(N-3 downto 0) & "00";
                    end if;
                end if;
            end if;
        end if;
    end process;
    
    q <= r;
end Behavioral;

architecture structural of shift_register is
    signal r    :   std_logic_vector(N-1 downto 0); -- uscite ff
    signal ext  :   std_logic_vector(N+3 downto 0); -- r con padding 
    signal sh   :   std_logic_vector(N-1 downto 0); -- uscita MUX 4:1 (shift)
    signal nx   :   std_logic_vector(N-1 downto 0); -- shift vel load  (next)
    signal dn   :   std_logic_vector(N-1 downto 0); -- ingresso ff (d next)
    signal we   :   std_logic;                      -- 1 -> il registro si aggiorna (write en)
    
    begin 
        assert N >=2
            report "shift register: N deve essere maggiore di 2"
            severity failure;
        ext <= "00" & r & "00";
        we <= load or en;
        
        slice: for i in 0 to N-1 generate
            m_shift: entity work.mux_4_1(dataflow)
                port map(
                    a(0) => ext(i+3), -- r(i+1) dx di 1
                    a(1) => ext(i+4), -- r(i+2) dx di 2
                    a(2) => ext(i+1), -- r(i-1) sx di 1 
                    a(3) => ext(i),   -- r(i-2) sx di 2
                    s(1) => dir,      -- LSB
                    s(0) => pos,      -- MSB  
                    y => sh(i)
                    );
            m_load: entity work.mux_2_1(dataflow) 
                port map(
                    a0 => sh(i), a1 => d(i), s => load, y => nx(i)
                    );
            m_hold: entity work.mux_2_1(dataflow)
                port map(
                    a0 => r(i), a1 => nx(i), s => we, y => dn(i)
                    ); -- se !(en or load) -> deve mantenere 
            ff : entity work.dff(behavioral) 
                port map(
                    clk => clk, rst => rst, d => dn(i), q => r(i)
                    );
            end generate;
            q <= r;
            
end structural;

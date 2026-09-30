library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
--use IEEE.NUMERIC_STD.ALL;

entity booth_po is
    port(
        clk : in std_logic;
        rst : in std_logic;
        
        x : in std_logic_vector(7 downto 0); -- moltiplicatore
        y : in std_logic_vector(7 downto 0); -- moltiplicando 
        p : out std_logic_vector(15 downto 0); -- prodotto
        
        -- input dalla CU
        load_mq : in std_logic; -- M <- y, Q <- X, A <- 0, Q[-1] <- 0
        load_a : in std_logic;
        sub: in std_logic; 
        shift: in std_logic;
        cnt_en: in std_logic;
        cnt_rst: in std_logic;
        
        -- output per la CU 
        q0 : out std_logic;
        qm1 : out std_logic;
        last : out std_logic -- ci interessa solo l'ultimo
    );
end booth_po;

architecture mixed of booth_po is
    constant ZERO3 : std_logic_vector(2 downto 0) := (others => '0');
    
    signal m_reg : std_logic_vector(7 downto 0);
    signal a_reg : std_logic_vector(7 downto 0);
    signal q_reg: std_logic_vector(7 downto 0);
    signal qm1_reg : std_logic;
    signal sum : std_logic_vector(7 downto 0); 
    
begin
    u_addsub: entity work.add_sub(structural)
        generic map  (N => 8)
        port map ( a => a_reg, b => m_reg, c_in => sub, s => sum, ovf => open);
    u_cnt: entity work.counter_mod(behavioral)
        generic map (M => 8, W => 3)
        port map (  clk => clk, rst => cnt_rst, en => cnt_en, load => '0', 
                    d => ZERO3, q => open, tc => last);
    
    registri: process(clk)
    begin
        if clk'event and clk = '1' then
            if rst = '1' then
                m_reg <= (others => '0');
                a_reg <= (others => '0');
                q_reg <= (others => '0');
                qm1_reg <= '0';
            elsif load_mq = '1' then
                m_reg <= y;
                q_reg <= x;
                a_reg <= (others => '0');
                qm1_reg <= '0';
            elsif load_a = '1' then
                a_reg <= sum;
            elsif shift = '1' then
                a_reg <= a_reg(7) & a_reg(7 downto 1);
                q_reg <= a_reg(0) & q_reg(7 downto 1);
                qm1_reg <= q_reg(0);
            end if;
        end if;
    end process;
    
    p <= a_reg(7 downto 0) & q_reg;
    q0 <= q_reg(0);
    qm1 <= qm1_reg;     
end mixed;

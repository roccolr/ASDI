library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
--use IEEE.NUMERIC_STD.ALL;

entity sistema is
    generic (
        N: positive := 16;
        A: positive := 4
    );
    port (
        clk : in std_logic;
        rst : in std_logic;
        start : in std_logic;
        step : in std_logic;
        done : out std_logic;
        
        raddr : in std_logic_vector(A-1 downto 0);
        dout : out std_logic_vector(3 downto 0);
        
        addr_dbg : out std_logic_vector(A-1 downto 0);
        m_dbg : out std_logic_vector(3 downto 0)
    );
    
end sistema;

architecture structural of sistema is
    constant ZERO_A : std_logic_vector(A-1 downto 0) := (others => '0');
    
    signal addr : std_logic_vector(A-1 downto 0); -- comune a mem e ROM
    signal rom_data : std_logic_vector(7 downto 0); -- ROM -> M 
    signal m_data : std_logic_vector(3 downto 0); -- M -> MEM
    
    -- link datapath <-> controllo
    signal rd, we, cnt_en : std_logic;
    signal tc : std_logic;
begin
    u_cnt : entity work.counter_mod(behavioral)
        generic map(M => N, W => A)
        port map(   clk => clk, rst => rst, en => cnt_en, load => '0', 
                    d => ZERO_A, q => addr, tc => tc);
    
    u_rom: entity work.rom(behavioral)
        generic map (N => N, A => A)
        port map ( clk => clk, rd => rd, addr => addr, data => rom_data);
        
    u_m: entity work.onecount(behavioral) 
        port map ( x => rom_data, y => m_data);
    
    u_mem: entity work.mem(behavioral)
        port map (  clk => clk, we => we, waddr => addr, din => m_data,
                    raddr => raddr, dout => dout);
    u_cu: entity work.control_unit(behavioral)
        port map (  clk => clk, rst => rst, start => start, tc => tc,
                    rd => rd, we => we, cnt_en => cnt_en, done => done, step => step);
    
    addr_dbg <= addr; -- questo mostrera' l'indirizzo successivo
    m_dbg <= m_data;
    
    
end structural;

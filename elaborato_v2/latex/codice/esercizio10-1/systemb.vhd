library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity systemB is
    port(
        clk : in std_logic;
        rst : in std_logic;
        cts : out std_logic;
        rx: in std_logic;
        rts : in std_logic;
        
        -- utilities
        raddr: in std_logic_vector(2 downto 0);
        dout: out std_logic_vector(7 downto 0)
    );
end systemB;

architecture structural of systemB is
    signal counter_2_ram : std_logic_vector(2 downto 0);
    signal uart_2_ram : std_logic_vector(7 downto 0) := (others => '0');
    signal en, we, rda, rd: std_logic;
    signal ZERO8 : std_logic_vector(7 downto 0) := (others => '0');
begin
    ram: entity work.mem(behavioral)
        generic map(
            N => 8, A => 3, W => 8
            )
        port map(
            clk => clk, we => we, waddr => counter_2_ram, 
            din => uart_2_ram, raddr => raddr, dout => dout
            );
        
    cnt: entity work.counter_mod(behavioral)
        generic map(
            M => 8,
            W => 3
            )
        port map(
            clk => clk, rst => rst, en => en, load => '0', 
            d => (others => '0'), q => counter_2_ram, tc => open
            );
        
    cu: entity work.cuB(behavioral)
        port map(
            clk => clk, rst => rst, en => en, rts => rts, rda => rda,
            cts => cts, memw => we, rd => rd
            );
    
    uart: entity work.Rs232RefComp(Behavioral)
        port map (
            TXD => open, RXD => rx, CLK => clk, DBIN => ZERO8, 
            DBOUT => uart_2_ram, RDA => rda, TBE => open, RD => rd,
            WR => '0', PE => open, FE => open, OE => open, RST => rst
            );  
end structural;

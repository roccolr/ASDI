library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity systemA is
    port(
        clk : in std_logic;
        rst : in std_logic;
        start : in std_logic;
        cts : in std_logic;
        tx: out std_logic;
        rts : out std_logic
    );
end systemA;

architecture structural of systemA is
    signal counter_2_rom : std_logic_vector(2 downto 0);
    signal rom_2_uart : std_logic_vector(7 downto 0);
    signal en, wr: std_logic;
    signal ZERO8 : std_logic_vector(7 downto 0) := (others => '0');
begin
    rom: entity work.rom(Behavioral)
        generic map(
            N => 8, A => 3
            )
        port map(
            clk => clk, rd => '1', addr => counter_2_rom, 
            data => rom_2_uart
        );
    
    cnt: entity work.counter_mod(behavioral)
        generic map(
            M => 8,
            W => 3
            )
        port map(
            clk => clk, rst => rst, en => en, load => '0', 
            d => (others => '0'), q => counter_2_rom, tc => open
            );
    
    cu: entity work.cuA(behavioral)
        port map(
            clk => clk, rst => rst, start => start, en => en,
            cts => cts, wr => wr, rts => rts
            );
    
    uart: entity work.Rs232RefComp(Behavioral)
        port map (
            TXD => tx, RXD => '0', CLK => clk, DBIN => rom_2_uart, 
            DBOUT => ZERO8, RDA => open, TBE => open, RD => '0',
            WR => wr, PE => open, FE => open, OE => open, RST => rst
            );
end structural;

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity cronometro_tl is
    port (
        CLK100MHZ : in  std_logic;
        SW        : in  std_logic_vector(15 downto 0);
        BTNC      : in  std_logic;                      -- carica il campo corrente
        BTND      : in  std_logic;                      -- reset
        LED       : out std_logic_vector(2 downto 0);   -- campo caricando
        CA, CB, CC, CD, CE, CF, CG : out std_logic;
        DP        : out std_logic;
        AN        : out std_logic_vector(7 downto 0)
    );
end cronometro_tl;

architecture structural of cronometro_tl is
    signal rst, load_p, set_p : std_logic;
    signal h_in, h : std_logic_vector(4 downto 0);
    signal m_in, s_in, m, s : std_logic_vector(5 downto 0);
    signal h_ext : std_logic_vector(5 downto 0);
    signal ore_d, ore_u, min_d, min_u, sec_d, sec_u : std_logic_vector(3 downto 0);
    signal seg : std_logic_vector(6 downto 0);
begin

    rst <= BTND; -- reset idempotente
    -- set idempotente
    
    -- il bottone centrale passa per il deboucer
    deb : entity work.debouncer(Behavioral)
        port map (clk => CLK100MHZ, rst => rst, button => BTNC, button_fix => load_p);

    -- caricamento ore -> minuti -> secondi con gli stessi 6 switch
    im : entity work.input_manager(behavioral)
        port map (clk => CLK100MHZ, rst => rst, load => load_p, sw => SW(5 downto 0),
                  h_in => h_in, m_in => m_in, s_in => s_in,
                  set => set_p, campo => LED);

    
    cr : entity work.cronometro(structural)
        port map (clk => CLK100MHZ, rst => rst, run => SW(15), set => set_p,
                  h_in => h_in, m_in => m_in, s_in => s_in,
                  h => h, m => m, s => s);

    -- conversione binario -> due cifre BCD
    h_ext <= '0' & h; -- 6 bit

    conv_h : entity work.bin2dec(behavioral)
        port map (bin => h_ext, decine => ore_d, unita => ore_u);
    conv_m : entity work.bin2dec(behavioral)
        port map (bin => m, decine => min_d, unita => min_u);
    conv_s : entity work.bin2dec(behavioral)
        port map (bin => s, decine => sec_d, unita => sec_u);

    -- visualizzazione 
    disp : entity work.display_driver(structural)
        port map (clk => CLK100MHZ, rst => rst,
                  ore_d => ore_d, ore_u => ore_u,
                  min_d => min_d, min_u => min_u,
                  sec_d => sec_d, sec_u => sec_u,
                  seg => seg, dp => DP, an => AN);

    -- segmenti: seg(0)=a ... seg(6)=g
    CA <= seg(0);
    CB <= seg(1);
    CC <= seg(2);
    CD <= seg(3);
    CE <= seg(4);
    CF <= seg(5);
    CG <= seg(6);

end structural;
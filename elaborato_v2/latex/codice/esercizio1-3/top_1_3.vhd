library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity top_1_3 is
    port (
        CLK100MHZ : in  std_logic;
        SW        : in  std_logic_vector(13 downto 0);
        BTNL      : in  std_logic;
        BTNR      : in  std_logic;
        LED       : out std_logic_vector(3 downto 0)
    );
end top_1_3;

architecture structural of top_1_3 is

    signal d_half : std_logic_vector(0 to 7);     -- mezzo dato dagli switch
    signal data   : std_logic_vector(0 to 15);    -- dato completo dal registro
    signal y      : std_logic_vector(0 to 3);     -- uscite 

begin

    gen_d : for i in 0 to 7 generate
        d_half(i) <= SW(i);
    end generate;

    gen_led : for i in 0 to 3 generate
        LED(i) <= y(i);
    end generate;

    u_acq : entity work.acq_reg(behavioral)
        port map (clk => CLK100MHZ, load_lo => BTNL, load_hi => BTNR,
                  d => d_half, q => data);

    u_net : entity work.interconn16_4(structural)
        port map (x => data, s_i => SW(11 downto 8), s_o => SW(13 downto 12),
                  y => y);

end structural;
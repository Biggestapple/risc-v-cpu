library verilog;
use verilog.vl_types.all;
entity pc is
    port(
        clk             : in     vl_logic;
        sys_rst_n       : in     vl_logic;
        pcSrc           : in     vl_logic;
        pc              : out    vl_logic_vector(31 downto 0);
        immExt          : in     vl_logic_vector(31 downto 0);
        rom_rdy         : in     vl_logic;
        pcPlus4         : out    vl_logic_vector(31 downto 0)
    );
end pc;

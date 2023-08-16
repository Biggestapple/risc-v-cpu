library verilog;
use verilog.vl_types.all;
entity sc_cpu is
    port(
        clk             : in     vl_logic;
        sys_rst_n       : in     vl_logic;
        rom_addr        : out    vl_logic_vector(31 downto 0);
        rom_rdata       : in     vl_logic_vector(31 downto 0);
        rom_rdy         : in     vl_logic;
        mem_rdata       : in     vl_logic_vector(31 downto 0);
        mem_addr        : out    vl_logic_vector(31 downto 0);
        mem_wdata       : out    vl_logic_vector(31 downto 0);
        mem_we          : out    vl_logic
    );
end sc_cpu;

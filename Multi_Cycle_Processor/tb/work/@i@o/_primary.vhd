library verilog;
use verilog.vl_types.all;
entity IO is
    port(
        clk             : in     vl_logic;
        sys_rst_n       : in     vl_logic;
        led             : out    vl_logic_vector(7 downto 0);
        mem_addr        : in     vl_logic_vector(31 downto 0);
        mem_rdata       : out    vl_logic_vector(31 downto 0);
        mem_wdata       : in     vl_logic_vector(31 downto 0);
        mem_we          : in     vl_logic
    );
end IO;

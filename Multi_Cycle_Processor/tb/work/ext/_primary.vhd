library verilog;
use verilog.vl_types.all;
entity ext is
    port(
        instr           : in     vl_logic_vector(31 downto 0);
        immSrc          : in     vl_logic_vector(2 downto 0);
        immExt          : out    vl_logic_vector(31 downto 0)
    );
end ext;

library verilog;
use verilog.vl_types.all;
entity compu is
    port(
        srcA            : in     vl_logic_vector(31 downto 0);
        srcB            : in     vl_logic_vector(31 downto 0);
        comCtr          : in     vl_logic_vector(1 downto 0);
        zero            : out    vl_logic
    );
end compu;

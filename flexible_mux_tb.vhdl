library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity flexible_mux_tb is
end entity flexible_mux_tb;

architecture behavioral of flexible_mux_tb is

  component flexible_mux is
    generic (
      N : integer := 2;
      M : integer := 1
    );
    port (
      sel : in std_logic_vector(ceil(log2(real(N))) - 1 downto 0);
      din : in std_logic_vector((N*M)-1 downto 0);
      dout : out std_logic_vector(M-1 downto 0)
    );
  end component flexible_mux;

  signal sel : std_logic_vector(1 downto 0);
  signal din : std_logic_vector(7 downto 0);
  signal dout : std_logic_vector(7 downto 0);

begin

  dut: flexible_mux
    generic map (
      N => 4,
      M => 1
    )
    port map (
      sel => sel,
      din => din,
      dout => dout
    );

  stimulus: process
  begin
    -- test case 1
    sel <= "00";
    din <= "00001111";
    wait for 10 ns;
    assert dout = "00001111" report "Test case 1 failed" severity error;
    
    -- test case 2
    sel <= "01";
    din <= "11110000";
    wait for 10 ns;
    assert dout = "11110000" report "Test case 2 failed" severity error;
    
    -- test case 3
    sel <= "10";
    din <= "01010101";
    wait for 10 ns;
    assert dout = "01010101" report "Test case 3 failed" severity error;
    
    -- test case 4
    sel <= "11";
    din <= "10101010";
    wait for 10 ns;
    assert dout = "10101010" report "Test case 4 failed" severity error;
    
    -- test case 5
    sel <= "11";
    din <= "11110000";
    wait for 10 ns;
    assert dout /= "10101010" report "Test case 5 failed" severity error;
    
    wait;
  end process stimulus;

end architecture behavioral;

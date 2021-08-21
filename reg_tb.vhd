library ieee;
use ieee.std_logic_1164.all;

entity reg_tb is 
end entity;

architecture test of reg_tb is
   
   signal rst: std_logic;
   signal clk: std_logic;
   signal en: std_logic;
   signal oe: std_logic;
   signal input: std_logic_vector(7 downto 0) := "11001100";
   signal output: std_logic_vector(7 downto 0);
   signal output_bus: std_logic_vector(7 downto 0);
	
   constant t: time := 20 ns;
	
begin

   dut: entity work.reg generic map (8) port map (rst, clk, en, oe, input, output, output_bus);
	
   -- Clock signal
   process
   begin
      clk <= '0';
      wait for t/2;
      clk <= '1';
      wait for t/2;
   end process;

   -- Control signals
   process
   begin
      rst <= '0';
      oe <= '0';
      en <= '0';
      wait for t;
      rst <= '1';
      wait for t*3;
      input <= "00110011";
      wait for t;
      input <= "10101100";
      wait for t;
      en <= '1';
      wait for t*4;
      en <= '0';
      wait for t*3;
      oe <= '1';
      wait for t;
      oe <= '0';
      wait;
   end process;
	
end test;

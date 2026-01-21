-- Laboratory GdTi solutions/versuch7
-- Winter Semester 24/25
-- Group Details
-- Lab Date:
-- 1. Participant First and  Last Name: 
-- 2. Participant First and Last Name:
 
 
-- coding conventions
-- g_<name> Generics
-- p_<name> Ports
-- c_<name> Constants
-- s_<name> Signals
-- v_<name> Variables

library ieee;
use ieee.std_logic_1164.all;

entity my_gen_n_bit_full_adder is
  Generic (
    G_DATA_WIDTH : integer := 4
  );
  port (
    -- begin solution:
    P_A         : in  std_logic_vector(G_DATA_WIDTH-1 downto 0);
    P_B         : in  std_logic_vector(G_DATA_WIDTH-1 downto 0);
    P_CARRY_IN  : in  std_logic;
    P_SUM       : out std_logic_vector(G_DATA_WIDTH-1 downto 0);
    P_CARRY_OUT : out std_logic
    -- end solution!!
  );
end my_gen_n_bit_full_adder;

-- structure
architecture structure of my_gen_n_bit_full_adder is
-- begin solution:
  signal s_carry : std_logic_vector(G_DATA_WIDTH downto 0);
  signal s_b_in      : std_logic_vector(G_DATA_WIDTH-1 downto 0);
  signal s_b_nand_ab : std_logic_vector(G_DATA_WIDTH-1 downto 0);
  signal s_b_nand_a  : std_logic_vector(G_DATA_WIDTH-1 downto 0);
  signal s_b_nand_b  : std_logic_vector(G_DATA_WIDTH-1 downto 0);
-- end solution!!
begin
  s_carry(0) <= P_CARRY_IN;

  GEN_FA : for i in 0 to G_DATA_WIDTH-1 generate
    -- B xor sub using NAND only.
    s_b_nand_ab(i) <= P_B(i) nand P_CARRY_IN;
    s_b_nand_a(i)  <= P_B(i) nand s_b_nand_ab(i);
    s_b_nand_b(i)  <= P_CARRY_IN nand s_b_nand_ab(i);
    s_b_in(i)      <= s_b_nand_a(i) nand s_b_nand_b(i);

    FA_I : entity work.my_full_adder(structure)
      port map (
        P_A         => P_A(i),
        P_B         => s_b_in(i),
        P_CARRY_IN  => s_carry(i),
        P_SUM       => P_SUM(i),
        P_CARRY_OUT => s_carry(i+1)
      );
  end generate;

  P_CARRY_OUT <= s_carry(G_DATA_WIDTH);
end structure;

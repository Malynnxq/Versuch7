library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity my_gen_n_bit_full_adder_tb2 is
end my_gen_n_bit_full_adder_tb2;

architecture behavior of my_gen_n_bit_full_adder_tb2 is
  constant C_DATA_WIDTH : positive := 4;
  signal s_carry_in, s_carry_out : std_logic;
  signal s_input_a, s_input_b, s_sum : std_logic_vector(C_DATA_WIDTH-1 downto 0);

begin
  DUT1 : entity work.my_gen_n_bit_full_adder
    generic map (
      G_DATA_WIDTH => C_DATA_WIDTH
    )
    port map (
    P_A       => s_input_a,
    P_B       => s_input_b,
    P_CARRY_IN  => s_carry_in,
    P_SUM   => s_sum,
    P_CARRY_OUT => s_carry_out
    );

  process
    variable v_sum_in_loop, v_error_count : integer;
    variable v_expected_vec : signed(C_DATA_WIDTH-1 downto 0);
  begin
    v_error_count := 0;

    report "Starting tests... ";
    report "Normal Test - ADD";

    -- Add Test
    for ai in 0 to (2 ** (C_DATA_WIDTH-1))-1 loop
      for bi in 0 to (2 ** (C_DATA_WIDTH-1))-1 loop
        s_input_a <= std_logic_vector(to_unsigned(ai, C_DATA_WIDTH));
        s_input_b <= std_logic_vector(to_unsigned(bi, C_DATA_WIDTH));
        s_carry_in <= '0';
        wait for 1 fs;
        v_sum_in_loop := to_integer(signed(s_sum));

        if ((ai+bi) /= v_sum_in_loop) and ((ai+bi- 2**C_DATA_WIDTH) /= (v_sum_in_loop)) then
          v_error_count := v_error_count + 1;
          report integer'image(ai) & "+" & integer'image(bi) & " ==> " & integer'image(ai+bi) & " but simulation returns " & integer'image(v_sum_in_loop) severity error;
        end if;
        wait for 1 fs;
      end loop;
    end loop;

    if v_error_count = 0 then
      report "Addition Tests had no errors";
    else
      report "Addition Test had " & integer'image(v_error_count) & " errors";
    end if;
    report "End of Addition Test.";

    report "Normal Test - SUBTRACT";

    v_error_count := 0;

    -- Subtract Test
    for ai in 0 to (2 ** (C_DATA_WIDTH-1))-1 loop
      for bi in 0 to (2 ** (C_DATA_WIDTH-1))-1 loop
        s_input_a <= std_logic_vector(to_unsigned(ai, C_DATA_WIDTH));
        s_input_b <= std_logic_vector(to_unsigned(bi, C_DATA_WIDTH));
        s_carry_in <= '1';  -- Trigger Subtraction
        wait for 1 fs;
        v_sum_in_loop := to_integer(signed(s_sum));
        if s_carry_out = '0' then
          if ((ai-bi) /= v_sum_in_loop) and ((ai-bi) /= (v_sum_in_loop mod 2**C_DATA_WIDTH)) then 
            v_error_count := v_error_count + 1;
            report integer'image(ai) & "-" & integer'image(bi) & " ==> " & integer'image(ai-bi) & " but simulation returns " & integer'image(v_sum_in_loop) severity error;
          end if;
        end if;
        wait for 1 fs;
      end loop;
    end loop;

    if v_error_count = 0 then
      report "Subtract Test had no errors";
    else
      report "Subctract Test had " & integer'image(v_error_count) & " errors";
    end if;
    report "End of Subtract test.";


    -- Knobelaufgabe
    report "Exhaustive Tests - Starting...";
    report "Exhaustive Tests - ADD:";

    v_error_count := 0;
  
    -- Add
    -- begin solution:
    for ai in -(2 ** (C_DATA_WIDTH-1)) to (2 ** (C_DATA_WIDTH-1))-1 loop
      for bi in -(2 ** (C_DATA_WIDTH-1)) to (2 ** (C_DATA_WIDTH-1))-1 loop
        s_input_a <= std_logic_vector(to_signed(ai, C_DATA_WIDTH));
        s_input_b <= std_logic_vector(to_signed(bi, C_DATA_WIDTH));
        s_carry_in <= '0';
        wait for 1 fs;
        v_expected_vec := to_signed(ai + bi, C_DATA_WIDTH);
        v_sum_in_loop := to_integer(signed(s_sum));
        if signed(s_sum) /= v_expected_vec then
          v_error_count := v_error_count + 1;
          report integer'image(ai) & "+" & integer'image(bi) & " ==> " &
                 integer'image(to_integer(v_expected_vec)) & " but simulation returns " &
                 integer'image(v_sum_in_loop) severity error;
        end if;
        wait for 1 fs;
      end loop;
    end loop;

    -- end solution!!    

    report "Exhaustive Tests - ADD - Done.";
    report "Exhaustive Tests - SUBTRACT:";

    -- Subtract
    -- begin solution:
    for ai in -(2 ** (C_DATA_WIDTH-1)) to (2 ** (C_DATA_WIDTH-1))-1 loop
      for bi in -(2 ** (C_DATA_WIDTH-1)) to (2 ** (C_DATA_WIDTH-1))-1 loop
        s_input_a <= std_logic_vector(to_signed(ai, C_DATA_WIDTH));
        s_input_b <= std_logic_vector(to_signed(bi, C_DATA_WIDTH));
        s_carry_in <= '1';
        wait for 1 fs;
        v_expected_vec := to_signed(ai - bi, C_DATA_WIDTH);
        v_sum_in_loop := to_integer(signed(s_sum));
        if signed(s_sum) /= v_expected_vec then
          v_error_count := v_error_count + 1;
          report integer'image(ai) & "-" & integer'image(bi) & " ==> " &
                 integer'image(to_integer(v_expected_vec)) & " but simulation returns " &
                 integer'image(v_sum_in_loop) severity error;
        end if;
        wait for 1 fs;
      end loop;
    end loop;

    -- end solution!!
    
    report "Exhaustive Tests - SUBTRACT - Done.";
    report "Exhaustive Tests - Done. Checking for errors...";
        
    if v_error_count = 0 then
      report "Exhaustive Tests had no errors";
    else
      report "Exhaustive Tests Test had " & integer'image(v_error_count) & " errors";
    end if;
    report "End of exhaustive test.";
  
  wait; -- Wait forever; this will finish the simulation.
  end process;

end behavior;

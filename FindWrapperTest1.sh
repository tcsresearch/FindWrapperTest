#!/bin/env bash

# shellcheck souyrce=/dev/null
# shellcheck disable=SC2038

### name: Lint .bfunc files
###      run: |

## TODO: Create code for usage of $Exclude_Old, $Exclude_Plugins, etc.

#####################################################################################################################
# Define Variables #                                                                                                #
#####################################################################################################################
  # --- Exclude Folders - Options --- #
    Exclude_Old="1"
    Exclude_Plugins="1"

  # --- Exclude Shellcheck - Options --- #
    SC_Exclude_SC1090="1"  # non-constant source
    SC_Exclude_SC2034="1"  # unused variable
    SC_Exclude_SC2154="1"  # var is referenced but not assigned

    SC_Exclude_SC2046="0"  # Quote this to prevent word splitting
    SC_Exclude_SC2006="0"  # Use $(...) notation instead of legacy backticked `...`
    SC_Exclude_SC2007="0"  # Use $((..)) instead of deprecated $[..]
    SC_Exclude_SC2103="0"  # Use a ( subshell ) to avoid having to cd back
    SC_Exclude_SC2162="0"  # read without -r will mangle backslashes
    SC_Exclude_SC2164="0"  # Use cd ... || exit in case cd fails.

    
  # --- Folders ---#
    ExcludeFolder_1="_Old"
    ExcludeFolder_2="plugins"


  # --- File Types --- #
    FileTyle_Sh="*.sh"
    FileType_Bfunc="*.bfunc"
    FileType_Profile="*.bprofile"

  # --- Find --- #
    Find_Excludes=( \( -path "*/_Old" -o -path "*/plugins" \) -prune -o -print )  # Define the array
    Find_CmdLines="-prune -o -type f"
    Find_FileType="*.bfunc"

  # --- Other --- #
    XArgs_CmdLines="-0 -r shellcheck --shell=bash"
    ShellCheck_Excludes="SC1090,SC2034,SC2154"

######################################################################################################################################################################################
# Run Finder #                                                                                                                                                                       #
######################################################################################################################################################################################
  # Find all .bfunc files and run shellcheck on them
  # Using -print0 and xargs -0 handles file names with spaces safely
  ### find . -type f -name "*.bfunc" -print0 | xargs -0 -r shellcheck --shell=bash
  ########## find . \( -path "*/_Old" -o -path "*/plugins" \) -prune -o -type f -name "*.bfunc" -print0 | xargs -0 -r shellcheck --shell=bash --exclude=SC1090,SC2034,SC2154
        
  # VarTest1 #
  function VarTest1() {
     find . \( -path "*/_Old" -o -path "*/plugins" \) "$Find_CmdLines" -name "*.bfunc" -print0 | xargs "$XArgs_CmdLines" --exclude="$ShellCheck_Excludes"
}
  # VarTest2 #
    function VarTest2() {
    # Define the array
        Find_Excludes=( \( -path "*/_Old" -o -path "*/plugins" \) -prune -o -print )

    # Execute the command using the array
         find . "${Find_Excludes[@]}" "$Find_CmdLines" -name "*.bfunc" -print0 | xargs "$XArgs_CmdLines" --exclude="$ShellCheck_Excludes"
}

    # VarTest3
    function VarTest3() {
      # 1. Initialize the array with the first set of arguments
            Find_Excludes=( \( -path "*/_Old" -o -path "*/plugins" \) -prune -o )

      # 2. Append your new arguments to the array
          Find_Excludes+=( -name "*.bfunc" -print0 )

      # 3. Execute the find command safely
        find . "${Find_Excludes[@]}" | xargs "$XArgs_CmdLines" --exclude="$ShellCheck_Excludes"
}        

#############################################################################################################
# Main Program #                                                                                            #
#############################################################################################################

echo "VarTest1: Minimal Variable Usage"
echo "VarTest2: Moderate Variable Usage (w/ Array)"
echo "VarTest3: Heavy Variable Usage (w/ Array & Appended Args)"
echo " "



